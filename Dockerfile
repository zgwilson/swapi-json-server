FROM docker.io/library/fedora

MAINTAINER "@svk"

LABEL description="SWAPI json server Container"
RUN dnf -y install npm nodejs procps-ng
#RUN git clone  https://github.com/codecowboydotio/swapi-json-server
#WORKDIR /swapi-json-server
COPY . /swapi
WORKDIR /swapi
RUN npm install
RUN useradd -ms /bin/bash swapi
USER swapi
HEALTHCHECK --interval=5m --timeout=3s \
 CMD curl http://localhost:3000/people/1 -k || exit 1
CMD ["/usr/bin/npm", "start"]
EXPOSE 3000
