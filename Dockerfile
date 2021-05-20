FROM ruby

RUN gem install bundler jekyll jekyll-postcss

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt install nodejs

WORKDIR /app
COPY . .
RUN  npm install && bundle install && JEKYLL_ENV=production bundle exec jekyll build

FROM nginx 

COPY --from=0 /app/_site /usr/share/nginx/html
