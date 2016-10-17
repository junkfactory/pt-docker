# Docker file for running percona toolkit tests
FROM ubuntu:xenial
RUN apt-get update && apt-get install -y --no-install-recommends \
    libaio1 \
    libnuma1 \
    libdbd-mysql \
    libdbd-mysql-perl \
    libdbi-perl \
    wget && \
    apt-get clean autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt /var/lib/dpkg /var/lib/cache /var/lib/log && \
    useradd -m percona

# need to run as non-root user
USER percona
WORKDIR /home/percona
RUN mkdir -p mysql/percona-server-5.6.32 && \
    mkdir percona-toolkit && \
    wget --no-check-certificate "https://www.percona.com/downloads/Percona-Server-5.6/Percona-Server-5.6.32-78.1/binary/tarball/Percona-Server-5.6.32-rel78.1-Linux.x86_64.ssl100.tar.gz" && \
    cd mysql && cd percona-server-5.6.32 && \
    tar xvzf /home/percona/Percona-Server-5.6.32-rel78.1-Linux.x86_64.ssl100.tar.gz --strip 1 && \
    rm -f /home/percona/Percona-Server-5.6.32-rel78.1-Linux.x86_64.ssl100.tar.gz 

ENV PERCONA_TOOLKIT_BRANCH=/home/percona/percona-toolkit \
    PERCONA_TOOLKIT_SANDBOX=/home/percona/mysql/percona-server-5.6.32 \
    PERL5LIB=/home/percona/percona-toolkit/lib \
    RUN_TEST=true
    
VOLUME ["/home/percona/percona-toolkit"]

COPY ./run.sh /
ENTRYPOINT ["/run.sh"]
