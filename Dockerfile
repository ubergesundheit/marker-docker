FROM node

RUN apt-get update

RUN apt-get install -y nginx

ADD nginx-default.conf /etc/nginx/sites-available/default

ADD . /marker
WORKDIR /marker


RUN npm install

EXPOSE 80

CMD [ "/bin/bash", "startscript.sh" ]
