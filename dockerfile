FROM mhart/alpine-node:11 AS builder
WORKDIR /tic-tac-toe
COPY package*.json /tic-tac-toe/
COPY . .
RUN npm install
RUN npm install react-scripts@3.0.1 -g
RUN npm run build


FROM nginx:1.15
WORKDIR /tic-tac-toe
COPY --from=node /usr/src/app/dist /usr/share/nginx/html
# COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /nginx.conf /etc/nginx/conf.d/default.conf
# COPY --from=builder /app/build/ /usr/share/nginx/html
COPY --from=builder /app/build .
EXPOSE 3000
CMD ["npm", "start", "serve", "-p", "80", "-s", "."]