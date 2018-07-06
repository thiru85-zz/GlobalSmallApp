FROM node:latest
RUN git clone https://github.com/thiru85/GlobalSmallApp.git
WORKDIR /GlobalSmallApp/
RUN npm install
EXPOSE 8080
CMD [ "npm", "app.js"]