require 'net/http'
require 'json'

API_BASEURL = "https://pub.orcid.org/v3.0"

def handlePublications(orcData)
    
    orcData['activities-summary']['works']['group'].each do |workGroup| 
        workGroup['work-summary'].each do |summary| 
            uri = URI("#{API_BASEURL}#{summary['path']}")
            request = Net::HTTP::Get.new(uri)
            request["Accept"] = "application/json"
            summaryResponse = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) {|http|
                http.request(request)
            }
            summaryData = JSON.load(summaryResponse.body)
            if summaryData['short-description'] == "seclab:pub"
                Jekyll.logger.info "  - #{summary['path']} marked as lab publication"                
                @publications.data['publications'].push(workGroup)
                break
            end
        end
    end
end


Jekyll::Hooks.register :site, :post_read do |site|
    @site = site
    @publications = @site.pages.find{|page| page.permalink == '/publications/'}
    if ! @publications.data['publications'] 
        @publications.data['publications'] = []
    end
    if @site.collections['team'] 
        @site.collections['team'].docs.each do |person|
            if person.data['orcid']                
                Jekyll.logger.info "Requesting ORCID Data for #{person.data['orcid']}"
                uri = URI("#{API_BASEURL}/#{person.data['orcid']}")
                request = Net::HTTP::Get.new(uri)
                request["Accept"] = "application/json"
                response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) {|http|
                    http.request(request)
                }
                
                orcData = JSON.load(response.body)
                person.data['orcData'] = orcData 
                person.data['familyName'] = orcData['person']['name']['family-name']['value']
                person.data['givenNames'] = orcData['person']['name']['given-names']['value']
                person.data['title'] = "#{person.data['familyName']} #{person.data['givenNames']}"                
                image = site.static_files.find{|x| x.basename == person.data['orcid'] && x.extname.match(/\.(jpe?g|png)/i)}
                if image
                    person.data['image'] = image.relative_path 
                end

                handlePublications(orcData)

            end
        end
    end

end