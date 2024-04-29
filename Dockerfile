FROM mcr.microsoft.com/dotnet/aspnet:8.0

# copy local files to container
COPY entrypoint.sh /entrypoint.sh
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisor.conf

# install clamav
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    clamav clamav-daemon supervisor wget net-tools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# update Permission
RUN mkdir /var/run/clamav && \
    chown clamav:clamav /var/run/clamav && \
    chmod 750 /var/run/clamav

# update the configuration (port)
RUN sed -i 's/^Foreground .*$/Foreground true/g' /etc/clamav/clamd.conf && \
    echo "TCPSocket 3310" >> /etc/clamav/clamd.conf && \
    sed -i 's/^Foreground .*$/Foreground true/g' /etc/clamav/freshclam.conf

RUN mkdir -p "/app"
WORKDIR /app

ENTRYPOINT [ "/bin/bash", "/entrypoint.sh" ]
