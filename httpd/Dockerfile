FROM centos:6

MAINTAINER hokuma

RUN yum install -y httpd
COPY server.conf /etc/httpd/conf.d/
COPY index.html /var/www/html/
RUN echo "CustomLog /proc/self/fd/1 combined" >> /etc/httpd/conf/httpd.conf
ENTRYPOINT ["/usr/sbin/httpd"]
CMD ["-D", "FOREGROUND"]
