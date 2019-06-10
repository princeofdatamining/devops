FROM node

RUN npm install -g gitbook-cli
RUN gitbook fetch 3.2.3

WORKDIR /mnt
