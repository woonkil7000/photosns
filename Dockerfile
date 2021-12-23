FROM adoptopenjdk/openjdk11
COPY out/artifacts/PhotogramApplication_jar/ /tmp
WORKDIR /tmp
CMD java com.cos.photogram.PhotogramApplication