FROM phusion/baseimage
MAINTAINER Prateek Agarwal <prat0318@gmail.com>

# Install Nginx.
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# Define mountable directories.
# VOLUME ["/data", "/etc/nginx/sites-enabled", "/var/log/nginx"]

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

ADD . /home/app/prettyresu.me/

RUN cp /home/app/prettyresu.me/docker-helpers/webapp.conf /etc/nginx/sites-enabled/webapp.conf
RUN cp /home/app/prettyresu.me/docker-helpers/nginx.sh /etc/my_init.d/nginx.sh
# RUN chmod +x /etc/my_init.d/nginx.sh
RUN chown -R 9999 /home/app/prettyresu.me

# Turn ssh login off by default
RUN /usr/sbin/enable_insecure_key

EXPOSE 80
EXPOSE 443

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
