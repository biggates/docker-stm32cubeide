# docker-stm32cubeide

## Disclaimer

This project provides a method for encapsulating STM32CubeIDE within a Docker container. The purpose of this project is to facilitate development environments and does NOT distribute STM32CubeIDE or any of its components.

## Usage

1. Run docker with your workspace mounted to `/workspace`. Assume your project name is: "Project"

  ```bash
  $ docker run --rm -it -v {pwd}:/workspace biggates/stm32cubeide
  ```

2. Inside docker container：

  ```bash
  # import workspace to /tmp/stm-workspace, clean and build it
  $ headless-build.sh -data /tmp/stm-workspace -import /workspace -no-indexer -cleanBuild "Project/Release"
  ```

## How to build

1. Download STM32CubeIDE in DEB format (should be `en.st-stm32cubeide_xxx_amd64.deb_bundle.sh.zip`) and put it in `assets`
2. Modify `docker-compose.yaml`, set `DEB_SH_NAME` and `STM32CUBEIDE_VERSION` values
3. Run `docker compose build`
