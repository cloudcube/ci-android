FROM ubuntu:14.04
MAINTAINER JianyingLi <lijy91@foxmail.com>

ENV SWARM_VERSION=2.0 \
  GRADLE_VERSION=2.10 \
  MAVEN_VERSION=3.3.9 \
  ANDROID_VERSION=24 \
  ANDROID_SDK_VERSION=24.4.1 \
  GRADLE_HOME=/usr/share/gradle \
  MAVEN_HOME=/usr/share/maven \
  ANDROID_HOME=/opt/android-sdk-linux

ENV PATH $GRADLE_HOME/bin:$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH

RUN dpkg --add-architecture i386                                    && \
    apt-get update                                                  && \
    apt-get install -y wget unzip curl git                          && \
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


# 配置gradle环境变量
# install gradle 
RUN curl -L https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-all.zip > /usr/share/gradle-$GRADLE_VERSION-all.zip \
  && unzip -d /usr/share/ /usr/share/gradle-$GRADLE_VERSION-all.zip \
  && ln -s /usr/share/gradle-$GRADLE_VERSION /usr/share/gradle \
  && rm /usr/share/gradle-$GRADLE_VERSION-all.zip \
  && ln -s /usr/share/gradle/bin/gradle /usr/bin/gradle

# install maven
RUN curl -fsSL http://apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

# install android sdk
RUN curl -o /opt/android-sdk_r$ANDROID_SDK_VERSION-linux.tgz -L https://dl.google.com/android/android-sdk_r$ANDROID_SDK_VERSION-linux.tgz \
  && cd /opt && tar xzvf ./android-sdk_r$ANDROID_SDK_VERSION-linux.tgz \
  && rm android-sdk_r$ANDROID_SDK_VERSION-linux.tgz \
  && echo "y" | android update sdk --force --no-ui --all --filter platform-tools,build-tools-$ANDROID_VERSION.0.1,android-$ANDROID_VERSION,addon-google_apis-google-$ANDROID_VERSION,sys-img-x86-addon-google_apis-google-$ANDROID_VERSION,source-$ANDROID_VERSION,extra-android-m2repository,extra-google-m2repository \
  && mkdir -p /opt/android-sdk-linux/build-tools \
  && cd /opt/android-sdk-linux/build-tools 

# install android build tools
RUN cd /opt && curl -LO https://dl.google.com/android/repository/build-tools_r$ANDROID_VERSION-linux.zip \
  && unzip build-tools_r$ANDROID_VERSION-linux.zip \
  && rm build-tools_r$ANDROID_VERSION-linux.zip

# link build tools
ln -sf /opt/android-N/ /opt/android-sdk-linux/build-tools/24.0.0

# clean all cache to clean space
RUN apt-get purge -y unzip \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean \
  && apt-get -y autoremove



# # 安装 Android NDK
# RUN wget -q http://dl.google.com/android/ndk/android-ndk-r10e-linux-x86_64.bin && \
#     chmod a+x android-ndk-r10e-linux-x86_64.bin                                && \
#     ./android-ndk-r10e-linux-x86_64.bin -o/usr/local                           && \
#     rm android-ndk-r10e-linux-x86_64.bin

# # 配置 Android NDK 环境变量
# ENV NDK_HOME /usr/local/android-ndk-r10e
# ENV PATH $PATH:$NDK_HOME
