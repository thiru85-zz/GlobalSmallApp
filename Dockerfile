FROM node:latest
WORKDIR /tmp
RUN git clone https://github.com/thiru85/GlobalSmallApp.git
WORKDIR /tmp/GlobalSmallApp
RUN npm install
CMD ["node", "app.js"]
EXPOSE 8080