FROM randomparity/docker-supervisor:latest

MAINTAINER David Christensen <randomparity@gmail.com>

ENV LAST_UPDATE_COUCHPOTATO 2015-01-16

# Install required tools
RUN apt-get -qy install unrar

# Clean-up any unneeded files
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/tmp/* && \
    rm -rf /tmp/*

# Fetch the Couchpotato package (select a known release rather than a git clone)
RUN mkdir -p /opt/couchpotato && \
    wget -qO - https://github.com/RuudBurger/CouchPotatoServer/archive/build/2.6.1.tar.gz | \
    tar -C /opt/couchpotato -zx --strip-components 1 && \
    chown -R $BASE_USER:$BASE_GROUP /opt/couchpotato

VOLUME ["/config", "/download", "/media"]

EXPOSE 5050

# Copy the supervisord configuration files into the container
COPY couchpotato.conf /etc/supervisor/conf.d/couchpotato.conf
RUN echo "user=$BASE_USER" >> /etc/supervisor/conf.d/couchpotato.conf

# No need to setup a CMD directive since that was handled by FROM image.
