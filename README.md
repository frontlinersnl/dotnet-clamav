[![logo](./logo.png)](https://frontliners.nl)

# dotnet-clamav

Docker image to run dotnet software with clamav installed and running

## Instructions

1. update dockerfile
2. build local version:

    ```sh
    docker build -t frontliners/dotnet-clamav .
    ```

3. push new version to dockerhub:

    ```sh
    docker push frontliners/dotnet-clamav
    ```

4. tag and push again (optional but recommended):

    ```sh
    docker tag frontliners/dotnet-clamav frontliners/dotnet-clamav:2
    docker push frontliners/dotnet-clamav:2
    ```

## Usage

```sh
FROM frontliners/dotnet-clamav
```

## scripts

| Command | Description                         |
| ------- | ----------------------------------- |
| build   | build the container with latest tag |
| push    | pushes the container                |
