FROM node:latest
ENV GITURL "https://github.com/thiru85/GlobalSmallApp.git"
WORKDIR /app
RUN git clone $GITURL
ENTRYPOINT cd/app/*/ && git pull && npm install && npm start
EXPOSE 8080