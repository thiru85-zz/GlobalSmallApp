FROM node:latest
WORKDIR /usr/local/
RUN git clone https://github.com/thiru85/GlobalSmallApp.git
RUN cd GlobalSmallApp
RUN npm install
EXPOSE 8080
CMD [ "npm", "app.js"]