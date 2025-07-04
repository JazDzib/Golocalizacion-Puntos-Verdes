#----Build Stage----
FROM node:18-alpine AS build
WORKDIR /app

COPY package.json .
RUN npm install 

COPY . .

ARG REACT_APP_API_URL
ENV REACT_APP_API_URL=$REACT_APP_API_URL

RUN npm run build

#----Serve Stage---
FROM nginx
WORKDIR /app
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build /usr/share/nginx/html