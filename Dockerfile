FROM debian:wheezy
MAINTAINER tokuhirom

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://cdn.debian.net/debian/ wheezy main contrib non-free" > /etc/apt/sources.list.d/mirror.jp.list
RUN echo "deb http://cdn.debian.net/debian/ wheezy-updates main contrib" >> /etc/apt/sources.list.d/mirror.jp.list
RUN rm /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -yq --no-install-recommends build-essential curl ca-certificates tar bzip2 patch && \
    apt-get clean && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

ENV PERL_VERSION 5.20.2
ENV PATH /opt/perl/bin:$PATH

# Perl
RUN curl -sL https://raw.githubusercontent.com/tokuhirom/Perl-Build/master/perl-build > /usr/bin/perl-build
RUN perl -pi -e 's%^#!/usr/bin/env perl%#!/usr/bin/perl%g' /usr/bin/perl-build
RUN chmod +x /usr/bin/perl-build
RUN perl-build $PERL_VERSION /opt/perl/
RUN curl -sL http://cpanmin.us/ | /opt/perl/bin/perl - --notest App::cpanminus

