FROM centos:6

MAINTAINER hokuma

RUN yum -y update && yum install -y httpd

ENV USERNAME admin
ENV PASSWORD qwerty

COPY server.conf auth.conf /etc/httpd/conf.d/
COPY index.html /var/www/html/

RUN mkdir /var/www/html/admin
RUN echo "CustomLog /proc/self/fd/1 combined" >> /etc/httpd/conf/httpd.conf
RUN echo "ErrorLog /proc/self/fd/2" >> /etc/httpd/conf/httpd.conf
COPY run.sh ./
RUN chmod o+x ./run.sh
ENTRYPOINT ["./run.sh"]
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
