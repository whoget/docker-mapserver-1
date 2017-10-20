# Mapserver for Docker
FROM ubuntu:14.04
MAINTAINER Admire Nyakudya<admire@kartoza.com>

ENV LANG C.UTF-8
RUN update-locale LANG=C.UTF-8
RUN DEBIAN_FRONTEND=noninteractive 

# Update and upgrade system
#RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
#RUN sudo apt-get -qq update --fix-missing && sudo apt-get -qq --yes upgrade
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  #apt-get install -y build-essential
  #apt-get install -y software-properties-common && \
  #apt-get install -y byobu curl git htop man unzip vim wget && \
  #rm -rf /var/lib/apt/lists/*



#ADD 71-apt-cacher-ng /etc/apt/apt.conf.d/71-apt-cacher-ng

#-------------Application Specific Stuff ----------------------------------------------------

# Install mapcache compilation prerequisites
RUN apt-get install -y build-essential software-properties-common g++ \
	make \ 
	cmake wget git \  
	bzip2 \
	apache2 \ 
	apache2-threaded-dev \ 
	curl \ 
	apache2-mpm-worker

# Install mapcache dependencies provided by Ubuntu repositories
RUN apt-get install -y \
    libxml2-dev \
    libxslt1-dev \
    libproj-dev \
    libfribidi-dev \
    libcairo2-dev \
    librsvg2-dev \
    libmysqlclient-dev \
    libpq-dev \
    libcurl4-gnutls-dev \
    libexempi-dev \
    libgdal-dev \
    libgeos-dev \
    gdal-bin

ADD resources /tmp/resources

ADD setup.sh /setup.sh
RUN chmod 0755 /setup.sh
RUN /setup.sh


# Configure localhost in Apache
RUN cp  /tmp/resources/000-default.conf /etc/apache2/sites-available/

# To be able to install libapache.
#RUN echo 'deb http://archive.ubuntu.com/ubuntu/dists/trusty multiverse' >> /etc/apt/sources.list
#RUN echo 'deb http://archive.ubuntu.com/ubuntu/dists/trusty-updates multiverse' >> /etc/apt/sources.list
#RUN echo 'deb http://security.ubuntu.com/ubuntu/dists/trusty-security multiverse' >> /etc/apt/sources.list
RUN  sudo apt-get update

# Install PHP5 and necessary modules
RUN  apt-get install -y libapache2-mod-fastcgi php5-fpm libapache2-mod-php5 php5-common php5-cli php5-fpm php5

RUN rm -rf /etc/apt/*.list

# Enable these Apache modules
RUN  a2enmod actions cgi alias

# Apache configuration for PHP-FPM
RUN cp /tmp/resources/php5-fpm.conf /etc/apache2/conf-available/

# Link to cgi-bin executable
RUN chmod o+x /usr/local/bin/mapserv
RUN ln -s /usr/local/bin/mapserv /usr/lib/cgi-bin/mapserv
RUN chmod 755 /usr/lib/cgi-bin

EXPOSE  80

#ENV HOST_IP `ifconfig | grep inet | grep Mask:255.255.255.0 | cut -d ' ' -f 12 | cut -d ':' -f 2`

CMD apachectl -D FOREGROUND
