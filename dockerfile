FROM eclipse-temurin:17-alpine AS builder
RUN apk --no-cache add curl
WORKDIR /build
COPY ./ ./
# Download BungeeCore
RUN curl https://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar -o BungeeCord.jar
WORKDIR /build/modules
# Download modules
RUN curl https://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/module/cmd-alert/target/cmd_alert.jar -o cmd_alert.jar &&\
    curl https://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/module/cmd-find/target/cmd_find.jar -o cmd_find.jar &&\
    curl https://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/module/cmd-kick/target/cmd_kick.jar -o cmd_kick.jar &&\
    curl https://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/module/cmd-list/target/cmd_list.jar -o cmd_list.jar &&\
    curl https://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/module/cmd-send/target/cmd_send.jar -o cmd_send.jar &&\
    curl https://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/module/cmd-server/target/cmd_server.jar -o cmd_server.jar &&\
    curl https://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/module/reconnect-yaml/target/reconnect_yaml.jar -o reconnect_yaml.jar

FROM eclipse-temurin:17-alpine
WORKDIR /opt/bungee
COPY --from=builder /build/ ./
CMD ["java", "-jar", "BungeeCord.jar"]