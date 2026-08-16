FROM nginx:1.27-alpine

COPY index.html /usr/share/nginx/html/index.html
COPY apps.json /usr/share/nginx/html/apps.json
COPY assets/ /usr/share/nginx/html/assets/
