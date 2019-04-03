# build our react app.
FROM node:alpine as build

COPY . /checkout
WORKDIR /checkout/rect_app
RUN npm install
RUN npm run-script build

# host the built app with nginx and pass requests to /api/ to our backend micro-service.
FROM nginx:1.15.2-alpine

COPY --from=build /checkout/react_app/build /var/www
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
ENTRYPOINT ["nginx","-g","daemon off;"]