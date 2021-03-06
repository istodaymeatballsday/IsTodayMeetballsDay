FROM nginx:1.17.5
WORKDIR /app

RUN apt-get update 
RUN apt-get install cron -y 
RUN apt-get install python -y

RUN rm /etc/nginx/nginx.conf
COPY server/nginx.conf /etc/nginx/nginx.conf

COPY scripts/rebuild.py .
COPY index.template.html .
COPY crontab .
RUN cat /app/crontab | crontab -
RUN mkdir /build
COPY entrypoint.sh .

EXPOSE 80
CMD ["./entrypoint.sh"]