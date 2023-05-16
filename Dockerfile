#BUILD
FROM node:18-slim AS BUILD

WORKDIR /app
COPY ["package.json", "./"]
RUN npm install
COPY . . 
RUN ["./node_modules/.bin/ng","build","--configuration=development"]

#RUN
FROM nginx:1.17.1-alpine
COPY --from=build /app/dist/ /usr/share/nginx/html
WORKDIR /etc/nginx
CMD ["nginx", "-g", "daemon off;"]
