FROM nginx:alpine
RUN echo '<h1>done working!</h1>' > /usr/share/nginx/html/index.html
