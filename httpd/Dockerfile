FROM centos:6

MAINTAINER hokuma

RUN yum install -y httpd
COPY server.conf /etc/httpd/conf.d/
COPY index.html /var/www/html/
ENTRYPOINT ["/usr/sbin/httpd"]
CMD ["-D", "FOREGROUND"]
