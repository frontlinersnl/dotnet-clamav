# dotnet-clamav

[![logo](./logo.jpg)](https://inforit.nl)

Docker image to run dotnet software with clamav installed and running

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
