FROM openjdk:8-jdk

LABEL Description="Docker on Ubuntu 16.04 - with Android SDK"
LABEL OS="Ubuntu 16.04"

RUN apt update && \
    apt install -y wget bash unzip git && \
    apt clean
RUN wget -O android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip

ENV ANDROID_HOME /android-sdk
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV TERM dumb
ENV GRADLE_OPTS "-XX:+UseG1GC -XX:MaxGCPauseMillis=1000"

ENV ANDROID_NDK_HOME /ndk-bundle/android-ndk-r21
ENV ANDROID_NDK_VERSION r21
ENV NDK_URL="https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip"

# Download Android NDK
RUN mkdir "$ANDROID_NDK_HOME" \
    && cd "$ANDROID_NDK_HOME" \
    && curl -o ndk.zip $NDK_URL \
    && unzip ndk.zip \
    && rm ndk.zip

# add to PATH
ENV PATH ${PATH}:${ANDROID_NDK_HOME}

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD [ "/bin/bash" ]

RUN ./entrypoint.sh