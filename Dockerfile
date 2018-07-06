FROM node:latest
WORKDIR /tmp
RUN git clone https://github.com/thiru85/GlobalSmallApp.git
RUN npm install
ENTRYPOINT cd /tmp/GlobalSmallApp/ && node app.js
EXPOSE 8080