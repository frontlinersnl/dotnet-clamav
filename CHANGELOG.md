# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0]

- Updated Dockerfile to use `aspnet:8.0`
- Replaced `inforitnl` with `frontlinersnl`
- Added some extra logs to check the clam version

## [1.0.0]

- Made the dockerfile
  - Uses supervisor to start both clamd and freshclam
  - Entrypoint waits for supervisor to finish and then starts `dotnet DLL_PATH`, which defaults to /app/Api.dll
  