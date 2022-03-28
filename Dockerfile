FROM docker.io/library/fedora:30

MAINTAINER "@svk"

LABEL description="SWAPI json server Container"
RUN dnf -y install npm nodejs procps-ng
COPY . /swapi
WORKDIR /swapi
RUN npm install
RUN useradd -ms /bin/bash swapi
RUN rm /usr/sbin/pam_timestamp_check /usr/bin/chage /usr/bin/sudo /usr/bin/newgrp /usr/sbin/unix_chkpwd /usr/bin/gpasswd
USER swapi
HEALTHCHECK CMD curl http://localhost:3000/people/1 || exit 1
CMD ["/usr/bin/npm", "start"]
EXPOSE 3000


