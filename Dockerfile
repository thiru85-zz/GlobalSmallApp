FROM node:latest
WORKDIR /tmp
RUN git clone https://github.com/thiru85/GlobalSmallApp.git
RUN cp /tmp/GlobalSmallApp/* /tmp/
RUN npm install
ENTRYPOINT node app.js
EXPOSE 8080