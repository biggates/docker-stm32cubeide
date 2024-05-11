# docker-stm32cubeide

## Usage

1. Run docker with your workspace mounted to `/workspace`

  ```bash
  $ docker run --rm -it -v {pwd}:/workspace biggates/stm32cubeide
  ```

2. Inside docker container：

  ```bash
  # import workspace to /tmp/stm-workspace
  $ stm32cubeide --launcher.suppressErrors -nosplash -application org.eclipse.cdt.managedbuilder.core.headlessbuild -data /tmp/stm-workspace -import /workspace

  # build all projects in workspace
  $ headless-build.sh -data /tmp/stm-workspace -cleanBuild all
  ```

## How to build

1. Download STM32CubeIDE in DEB format (should be `en.st-stm32cubeide_xxx_amd64.deb_bundle.sh.zip`) and put it in `assets`
2. Modify `docker-compose.yaml`, set `DEB_SH_NAME` and `STM32CUBEIDE_VERSION` values
3. Run `docker compose build`
