# base image
FROM nginx:1.17
COPY build/ /usr/share/nginx/html
FROM node:12.2.0-alpine
LABEL Taurean="ayobamitomi@gmail.com"
RUN npm install
RUN npm install react-scripts@3.0.1 -g
# set working directory
WORKDIR /tic-tac-toe
COPY package*.json ./
COPY . .
# start app
CMD ["npm", "start", "serve", "-p", "80", "-s", "."]