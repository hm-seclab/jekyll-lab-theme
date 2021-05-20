require 'net/http'
require 'json'

Jekyll::Hooks.register :site, :post_read do |site|

    if site.collections['team'] 
        site.collections['team'].docs.each do |person|
            if person.data['orcid']                
                Jekyll.logger.info "Requesting ORCID Data for #{person.data['orcid']}"
                uri = URI("https://pub.orcid.org/v2.1/#{person.data['orcid']}")
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
            end
        end
    end

end