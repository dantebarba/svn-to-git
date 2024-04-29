FROM debian:stretch

ENV PROJECT_NAME "misistema"
ENV EMAIL "midominio.com.ar"
ENV BASE_SVN "http://midominio.com.ar/misistema"
ENV BRANCHES "branches/miSistema"
ENV TAGS "tags/miSistema"
ENV TRUNK "trunk/miSistema"
ENV ABSOLUTE_PATH "/root/destination"
ENV GIT_PAT "##REEMPLAZAR CON GIT PAT##"
ENV GIT_URL "https://oauth2:${GIT_PAT}@gitlab.midominio.com.ar/miempresa/desarrollo/misistema.git"

RUN apt-get update

RUN apt-get install -y git git-svn subversion

COPY migrate.sh /root/svn-to-git/migrate.sh
COPY push-to-remote.sh /root/svn-to-git/push-to-remote.sh
COPY .gitignore.example /root/svn-to-git/.gitignore.example

RUN chmod +x /root/svn-to-git/*.sh

WORKDIR /root/svn-to-git