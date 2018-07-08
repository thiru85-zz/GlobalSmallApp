FROM node:latest
ENV GITURL "https://github.com/thiru85/GlobalSmallApp.git"
RUN mkdir -p /app
RUN git clone $GITURL /app
RUN pwd
RUN ls -al
RUN ls /app
#COPY /GlobalSmallApp/* /app/
WORKDIR /app
ADD package*.json /app/
RUN npm install
ADD . /app/
EXPOSE 8080
CMD ["node", "app.js"]

