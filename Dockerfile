FROM ubuntu:16.04
MAINTAINER lijy91@foxmail.com

# apt
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y wget

# 安装 Java7
RUN wget -q --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz
RUN tar -xvzf jdk-7u79-linux-x64.tar.gz
RUN mv jdk1.7.0_79 /usr/local/jdk1.7.0_79

# 安装Java8
RUN wget -q --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u66-b17/jdk-8u66-linux-x64.tar.gz
RUN tar -xvzf jdk-8u66-linux-x64.tar.gz
RUN mv jdk1.8.0_66 /usr/local/jdk1.8.0_66

# 配置Java环境变量
ENV JAVA7_HOME /usr/local/jdk1.7.0_79
ENV JAVA8_HOME /usr/local/jdk1.8.0_66
ENV JAVA_HOME /usr/local/jdk1.7.0_79
ENV PATH $PATH:$JAVA_HOME/bin

# 安装Android SDK
RUN apt-get -y install libncurses5:i386 libstdc++6:i386 zlib1g:i386
RUN wget -q http://dl.google.com/android/android-sdk_r24.3.4-linux.tgz
RUN tar -xvzf android-sdk_r24.3.4-linux.tgz
RUN mv android-sdk-linux /usr/local/android-sdk

# 配置Android SDK环境变量
ENV ANDROID_HOME /usr/local/android-sdk
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:$ANDROID_HOME/build-tools/23.0.2

# 添加 SDK 软件包
RUN android list sdk --all
RUN echo yes | android update sdk --no-ui --all --filter platform-tools
RUN echo yes | android update sdk --no-ui --all --filter build-tools-23.0.2
RUN echo yes | android update sdk --no-ui --all --filter android-23,sysimg-23
RUN echo yes | android update sdk --no-ui --all --filter android-22,sysimg-22
RUN echo yes | android update sdk --no-ui --all --filter extra-android-m2repository
RUN echo yes | android update sdk --no-ui --all --filter extra-google-m2repository
RUN echo yes | android update sdk --no-ui --all --filter extra-android-support

# 安装 Android NDK
RUN wget -q http://dl.google.com/android/ndk/android-ndk-r10e-linux-x86_64.bin
RUN chmod a+x android-ndk-r10c-darwin-x86_64.bin
RUN ./android-ndk-r10c-darwin-x86_64.bin

# TODO: 安装Gradle

# 清理临时文件
RUN rm jdk-7u79-linux-x64.tar.gz
RUM rm -r jdk1.7.0_79
RUN rm jdk-8u66-linux-x64.tar.gz
RUN rm -r jdk1.8.0_66
RUN rm android-sdk_r24.3.4-linux.tgz
RUN rm -r android-sdk-linux
RUN rm android-ndk-r10c-darwin-x86_64.bin
