FROM ubuntu:20.04

WORKDIR /app

RUN useradd -ms /bin/bash app-user && \
    apt update && \
    apt install -y curl && \
    curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh && \
    bash nodesource_setup.sh && \
    apt install -y nodejs && \
    chown -R app-user:app-user /app


COPY --chown=app-user:app-user ./app docker-entrypoint.sh /app/

USER app-user

ENTRYPOINT [ "./docker-entrypoint.sh" ]