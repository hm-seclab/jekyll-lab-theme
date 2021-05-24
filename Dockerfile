FROM ruby

RUN gem install bundler jekyll jekyll-postcss

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt install nodejs

WORKDIR /app
COPY package.json package-lock.json Gemfile Gemfile.lock ./
RUN  npm install && bundle install 
ARG CACHEBUST=1
COPY . .
RUN JEKYLL_ENV=production bundle exec jekyll build

FROM nginx 

COPY --from=0 /app/_site /usr/share/nginx/html
