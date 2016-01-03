FROM ubuntu:16.04
MAINTAINER lijy91@foxmail.com

# apt
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y wget

# JAVA7
RUN wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz
RUN tar -xvzf jdk-7u79-linux-x64.tar.gz
RUN mv jdk1.7.0_79 /usr/local/jdk1.7.0_79

# JAVA8
RUN wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u66-b17/jdk-8u66-linux-x64.tar.gz
RUN tar -xvzf jdk-8u66-linux-x64.tar.gz
RUN mv jdk1.8.0_66 /usr/local/jdk1.8.0_66

ENV JAVA7_HOME /usr/local/jdk1.7.0_79
ENV JAVA8_HOME /usr/local/jdk1.8.0_66
ENV JAVA_HOME /usr/local/jdk1.7.0_79
ENV PATH $PATH:$JAVA_HOME/bin
