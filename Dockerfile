FROM docker.io/library/ubuntu

MAINTAINER "@svk"

LABEL description="SWAPI json server Container"
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y npm nodejs
COPY . /swapi
WORKDIR /swapi
RUN npm install
RUN useradd -ms /bin/bash swapi
RUN chmod u-s /usr/bin/passwd /usr/bin/newgrp /usr/bin/chfn /usr/bin/umount /usr/bin/mount /usr/bin/chsh /usr/bin/su /usr/bin/gpasswd /usr/lib/dbus-1.0/dbus-daemon-launch-helper 
RUN chmod g-s /usr/bin/expiry /usr/bin/wall /usr/sbin/unix_chkpwd /usr/bin/chage /usr/sbin/pam_extrausers_chkpwd 
USER swapi
HEALTHCHECK CMD /bin/curl http://localhost:3000/people/1 || exit 1
CMD ["/usr/bin/npm", "start"]
EXPOSE 3000
