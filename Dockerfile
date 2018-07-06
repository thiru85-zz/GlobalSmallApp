FROM node:latest
WORKDIR /tmp
RUN git clone https://github.com/thiru85/GlobalSmallApp.git
ENTRYPOINT cd /tmp/GlobalSmallApp/ && git pull && npm install && node app.js
EXPOSE 8080