FROM centos:6

MAINTAINER hokuma

RUN yum install -y httpd
ENTRYPOINT ["/usr/sbin/httpd"]
CMD ["-D", "FOREGROUND"]
