FROM mhart/alpine-node:11 AS builder
WORKDIR /tic-tac-toe
COPY package*.json /tic-tac-toe/
COPY . .
RUN npm install
RUN npm install react-scripts@3.0.1 -g
RUN npm run build


FROM nginx:1.15.2-alpine
WORKDIR /tic-tac-toe
COPY ./build /var/www
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["npm", "start", "serve", "-p", "80", "-s", "."]