ARG NGINX_BASE_IMAGE
FROM ${NGINX_BASE_IMAGE}

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["nginx", "-g", "daemon off;"]

COPY nginx.conf /etc/nginx/
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh