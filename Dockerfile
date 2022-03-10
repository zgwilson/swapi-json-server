FROM docker.io/library/fedora

MAINTAINER "@svk"

LABEL description="SWAPI json server Container"
RUN dnf -y install git npm nodejs procps-ng
#RUN git clone  https://github.com/codecowboydotio/swapi-json-server
WORKDIR /swapi-json-server
#RUN npm install
CMD ["/usr/bin/npm", "start"]
EXPOSE 3000

