# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.2.0] - 2020-10-19

### Added

- `deploy-gcp-site` script to push a local folder to a GCP bucket
- handle `SPECIFIC_SERVICE_TAG` on `tower.bash`

## [2.1.0] - 2020-07-17

### Added

- `check-env-vars` script to validate that all environment variables used on your PHP code are declared in a .env file

## [2.0.0] - 2020-07-17

### Added

- `publish` script to push a local Docker image to GCR
- `docker-login` script to configure the Docker login helper for GCP
- `version` script to create CalVer tags based on existing repository tags
- `tower.bash` script to trigger a job to start automatic deployment with AWX

[Unreleased]: https://github.com/olivierlacan/keep-a-changelog/compare/2.2.0...HEAD
[2.2.0]: https://github.com/arquivei/pipeline-image/compare/2.2.0...2.1.0
[2.1.0]: https://github.com/arquivei/pipeline-image/compare/2.1.0...2.0.0
[2.0.0]: https://github.com/arquivei/pipeline-image/releases/tag/2.0.0


