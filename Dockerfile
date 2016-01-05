FROM ubuntu:16.04
MAINTAINER lijy91 <lijy91@foxmail.com>

# apt
RUN dpkg --add-architecture i386
RUN apt-get update \
  && apt-get install -y wget tree \
  && apt-get clean

# 安装 Java 7
RUN wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz \
  && tar -xvzf jdk-7u79-linux-x64.tar.gz -C /usr/local \
  && rm jdk-7u79-linux-x64.tar.gz

# 安装 Java 8
RUN wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u66-b17/jdk-8u66-linux-x64.tar.gz \
  && tar -xvzf jdk-8u66-linux-x64.tar.gz -C /usr/local \
  && rm jdk-8u66-linux-x64.tar.gz

# 配置 Java 环境变量
ENV JAVA7_HOME /usr/local/jdk1.7.0_79
ENV JAVA8_HOME /usr/local/jdk1.8.0_66
ENV JAVA_HOME /usr/local/jdk1.7.0_79
ENV PATH $PATH:$JAVA_HOME/bin

# 安装 Android SDK
RUN apt-get -y install libncurses5:i386 libstdc++6:i386 zlib1g:i386 \
  && wget http://dl.google.com/android/android-sdk_r24.3.4-linux.tgz \
  && tar -xvzf android-sdk_r24.3.4-linux.tgz -C /usr/local \
  && rm android-sdk_r24.3.4-linux.tgz \
  && apt-get clean

# 配置 Android SDK 环境变量
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:$ANDROID_HOME/build-tools/23.0.2

# 添加 Android SDK 软件包
RUN android list sdk --all

RUN echo yes | android update sdk --no-ui --all --filter platform-tools \
  && echo yes | android update sdk --no-ui --all --filter build-tools-23.0.2 \
  && echo yes | android update sdk --no-ui --all --filter android-23 \
  && echo yes | android update sdk --no-ui --all --filter android-22 \
  && echo yes | android update sdk --no-ui --all --filter extra-android-m2repository \
  && echo yes | android update sdk --no-ui --all --filter extra-google-m2repository \
  && echo yes | android update sdk --no-ui --all --filter extra-android-support

# 安装 Android NDK
RUN wget http://dl.google.com/android/ndk/android-ndk-r10e-linux-x86_64.bin \
  && chmod a+x android-ndk-r10e-linux-x86_64.bin \
  && ./android-ndk-r10e-linux-x86_64.bin -o/usr/local \
  && rm android-ndk-r10e-linux-x86_64.bin

# 配置 Android NDK 环境变量
ENV ANDROID_NDK_HOME /usr/local/android-ndk-r10e
ENV PATH $PATH:$ANDROID_NDK_HOME

# TODO: 安装Gradle

RUN tree -L 1 /usr/local/
RUN tree -L 1
