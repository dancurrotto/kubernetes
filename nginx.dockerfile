##### Stage 1
FROM node:latest as node 
LABEL author="Dan Currotto"
WORKDIR /app
COPY package.json package.json
RUN npm install
COPY . . 
RUN npm run build -- --prod

##### Stage 2
FROM nginx:alpine
VOLUME /var/cache/nginx
COPY --from=node /app/dist /usr/share/nginx/html
COPY ./config/nginx.conf /etc/nginx/conf.d/default.conf



# docker build -t nginx-angular -f nginx.dockerfile .

# docker run -p 8080:80 -v $(pwd)/dist:/usr/share/nginx/html nginx-angular