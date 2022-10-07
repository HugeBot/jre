FROM openjdk:18 AS build

WORKDIR /build

COPY jre-deps.info jre-deps.info

RUN jlink --verbose \
  --compress 2 \
  --strip-java-debug-attributes \
  --no-header-files \
  --no-man-pages \
  --output jre \
  --add-modules $(cat jre-deps.info)
  
FROM ubuntu:focal

COPY --from=build /build/jre /usr/lib/jvm/jre-huge

ENV JAVA_HOME=/usr/lib/jvm/jre-huge
