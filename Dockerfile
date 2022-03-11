FROM docker.io/library/fedora

MAINTAINER "@svk"

LABEL description="SWAPI json server Container"
RUN dnf -y install npm nodejs procps-ng
#RUN git clone  https://github.com/codecowboydotio/swapi-json-server
#WORKDIR /swapi-json-server
COPY . /swapi
WORKDIR /swapi
RUN npm install
RUN swapi -ms /bin/bash loadgen
USER swapi
CMD ["/usr/bin/npm", "start"]
EXPOSE 3000
