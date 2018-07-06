FROM node:latest
WORKDIR /tmp
RUN git clone https://github.com/thiru85/GlobalSmallApp.git
ENTRYPOINT cd /tmp/GlobalSmallApp/ && npm install && npm start
EXPOSE 8080