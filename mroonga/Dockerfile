FROM centos:6
MAINTAINER hokuma

RUN yum install -y http://packages.groonga.org/centos/groonga-release-1.1.0-1.noarch.rpm
RUN yum install -y http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm
RUN yum makecache
RUN yum install -y mysql-community-server
RUN yum install -y mysql-community-mroonga
COPY run.sh ./
RUN chmod o+x ./run.sh

ENTRYPOINT ["./run.sh"]
CMD ["mysqld"]
