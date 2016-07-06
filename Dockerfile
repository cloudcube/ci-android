FROM ubuntu:14.04
MAINTAINER JianyingLi <lijy91@foxmail.com>

RUN dpkg --add-architecture i386                                    && \
    apt-get update                                                  && \
    apt-get install -y wget                                         && \
    apt-get install -y libncurses5:i386 libstdc++6:i386 zlib1g:i386 && \
    apt-get clean

# 安装 Java 7
RUN wget -q --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz && \
    tar -xzf jdk-7u79-linux-x64.tar.gz -C /usr/local && \
    rm jdk-7u79-linux-x64.tar.gz && \
# 安装 Java 8
    wget -q --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u77-b03/jdk-8u77-linux-x64.tar.gz && \
    tar -xzf jdk-8u77-linux-x64.tar.gz -C /usr/local && \
    rm jdk-8u77-linux-x64.tar.gz

# 配置 Java 环境变量
ENV JAVA7_HOME /usr/local/jdk1.7.0_79
ENV JAVA8_HOME /usr/local/jdk1.8.0_77
ENV JAVA_HOME /usr/local/jdk1.7.0_79
ENV PATH $PATH:$JAVA_HOME/bin

# 安装 Android SDK
RUN wget -q http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && \
    tar -xzf android-sdk_r24.4.1-linux.tgz -C /usr/local              && \
    rm android-sdk_r24.4.1-linux.tgz

# 配置 Android SDK 环境变量
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:$ANDROID_HOME/build-tools/23.0.3

RUN echo yes | android update sdk --no-ui --all --filter platform-tools             && \
    echo yes | android update sdk --no-ui --all --filter build-tools-23.0.3         && \
    echo yes | android update sdk --no-ui --all --filter android-23                 && \
    echo yes | android update sdk --no-ui --all --filter android-22                 && \
    echo yes | android update sdk --no-ui --all --filter extra-android-m2repository && \
    echo yes | android update sdk --no-ui --all --filter extra-google-m2repository  && \
    echo yes | android update sdk --no-ui --all --filter extra-android-support

# 安装配置gradle  
RUN wget -q https://services.gradle.org/distributions/gradle-2.10-all.zip && \
    unzip -o -d /usr/local/gradle gradle-2.10-all.zip && \
    rm gradle-2.10-all.zip

# 配置gradle环境变量
ENV GRADLE_HOME /usr/local/gradle/gradle-2.10
ENV PATH $PATH:$GRADLE_HOME/bin

# # 安装 Android NDK
# RUN wget -q http://dl.google.com/android/ndk/android-ndk-r10e-linux-x86_64.bin && \
#     chmod a+x android-ndk-r10e-linux-x86_64.bin                                && \
#     ./android-ndk-r10e-linux-x86_64.bin -o/usr/local                           && \
#     rm android-ndk-r10e-linux-x86_64.bin

# # 配置 Android NDK 环境变量
# ENV NDK_HOME /usr/local/android-ndk-r10e
# ENV PATH $PATH:$NDK_HOME
