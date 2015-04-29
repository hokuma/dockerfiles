FROM centos:6
MAINTAINER hokuma

RUN yum -y update
RUN yum install -y http://packages.groonga.org/centos/groonga-release-1.1.0-1.noarch.rpm
RUN yum install -y http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm
RUN yum install -y mysql-community-server mysql-community-mroonga
COPY run.sh /
COPY my.cnf /etc/my.cnf
RUN chmod o+x /run.sh

EXPOSE 3306
ENTRYPOINT ["/run.sh"]
CMD ["/usr/sbin/mysqld"]
