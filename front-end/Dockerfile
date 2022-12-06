# Stage 1 - Install dependencies and build the app
FROM ubuntu:20.04 AS builder

RUN apt-get update
RUN apt-get install -y bash curl file git unzip xz-utils zip libglu1-mesa python3
RUN apt-get clean

# Clone the flutter repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set flutter path
# RUN /usr/local/flutter/bin/flutter doctor -v
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Change stable channel
RUN flutter channel stable

# Enable web capabilities
RUN flutter config --enable-web
RUN flutter upgrade
RUN flutter pub global activate webdev

# RUN flutter doctor -v

# Copy files to container and build
RUN mkdir /app
COPY . /app
WORKDIR /app
RUN flutter pub get
RUN flutter build web --web-renderer html

EXPOSE 5173
# make server startup script executable and start the web server
RUN ["chmod", "+x", "/app/server/server.sh"]

ENTRYPOINT [ "/app/server/server.sh"]