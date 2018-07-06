FROM node:latest
ENV GITURL "https://github.com/thiru85/GlobalSmallApp.git"
WORKDIR /app
RUN git clone $GITURL
RUN cd GlobalSmallApp
RUN npm install
ENTRYPOINT cd/app/*/ && git pull && node app.js
EXPOSE 8080
