# dotnet-clamav

[![logo](./logo.jpg)](https://inforit.nl)

Docker image to run dotnet software with clamav installed and running.

## Instructions

1. update dockerfile
2. build local version:

    ```sh
    docker build -t inforitnl/dotnet-clamav .
    ```

3. push new version to dockerhub:

    ```sh
    docker push inforitnl/dotnet-clamav
    ```

4. tag and push again (optional but recommended):

    ```sh
    docker tag inforitnl/dotnet-clamav inforitnl/dotnet-clamav:1
    docker push inforitnl/dotnet-clamav:1
    ```

## Usage

```sh
FROM inforitnl/dotnet-clamav
```

## scripts

| Command | Description                         |
| ------- | ----------------------------------- |
| build   | build the container with latest tag |
| push    | pushes the container                |

## Testing

Build an image from the Dockerfile.

```sh
docker build . -t frontliners/virus-scanner
```

To test the running of the image, you're able to use the `entrypoint.sh` file.

```sh
entrypoint.sh
```

## More information

### Dockerfile

The Dockerfile is used to create a Docker image for running a .NET application along with ClamAV antivirus and supervisord for process management.

Let's break it down step by step:

1. **FROM mcr.microsoft.com/dotnet/aspnet:6.0**: This line specifies the base image to use for the Docker image. It's using the .NET ASP.NET runtime version 8.0 provided by Microsoft's container registry.

2. **COPY entrypoint.sh /entrypoint.sh**: Copies a script named `entrypoint.sh` from the local directory to the root directory inside the container.

3. **COPY ./supervisord.conf /etc/supervisor/conf.d/supervisor.conf**: Copies a configuration file named `supervisord.conf` from the local directory to `/etc/supervisor/conf.d/supervisor.conf` inside the container.

4. **RUN apt-get update && apt-get install --no-install-recommends -y ...**: Installs necessary packages inside the container. This includes ClamAV, ClamAV daemon, supervisor, wget, and net-tools. It updates the package lists, installs the specified packages, cleans up the package cache, and removes unnecessary files.

5. **RUN mkdir /var/run/clamav && chown clamav:clamav /var/run/clamav && chmod 750 /var/run/clamav**: Creates a directory `/var/run/clamav` and sets the ownership to user `clamav` and group `clamav`. It also sets the permissions to `750`.

6. **RUN sed -i 's/^Foreground .*$/Foreground true/g' /etc/clamav/clamd.conf && ...**: Updates ClamAV configuration files. It modifies the configuration to run ClamAV daemon and freshclam in the foreground and configures the TCP socket to listen on port 3310.

7. **RUN mkdir -p "/app"** and **WORKDIR /app**: Creates a directory `/app` inside the container and sets it as the working directory.

8. **ENTRYPOINT [ "/bin/bash", "/entrypoint.sh" ]**: Specifies the command to run when the container starts. In this case, it runs `/entrypoint.sh` script using `/bin/bash`.

The `entrypoint.sh` script likely contains the logic to start the .NET application and supervise ClamAV processes using supervisord.

