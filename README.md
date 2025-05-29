# docker-stm32cubeide

[![Badge](https://img.shields.io/docker/v/biggates/stm32cubeide?logo=docker&label=biggates%2Fstm32cubeide)](https://hub.docker.com/r/biggates/stm32cubeide)

## Disclaimer

This project provides a method for encapsulating STM32CubeIDE within a Docker container. The purpose of this project is to facilitate development environments and does NOT distribute STM32CubeIDE or any of its components.

## Usage

1. Run docker with your workspace mounted to `/workspace`.

  ```bash
  $ docker run --rm -it -v {pwd}:/workspace biggates/stm32cubeide:1.18.1
  ```

2. Run `headless-build.sh` inside docker container. Assume your project name is "Project"：

  ```bash
  # import workspace to /tmp/stm-workspace, clean and build it
  $ headless-build.sh -data /tmp/stm-workspace -import /workspace -no-indexer -cleanBuild "Project/Release"
  ```

## headless-build.sh

`headless-build.sh` is a shortcut to `stm32cubeide -application org.eclipse.cdt.managedbuilder.core.headlessbuild`

```bash
root:/# headless-build.sh --help
Usage: /opt/st/stm32cubeide_1.18.1/stm32cubeide -data <workspace> -application org.eclipse.cdt.managedbuilder.core.headlessbuild [ OPTIONS ]

   -data       {/path/to/workspace}
   -remove     {[uri:/]/path/to/project}
   -removeAll  {[uri:/]/path/to/projectTreeURI} Remove all projects under URI
   -import     {[uri:/]/path/to/project}
   -importAll  {[uri:/]/path/to/projectTreeURI} Import all projects under URI
   -build      {project_name_reg_ex{/config_reg_ex} | all}
   -cleanBuild {project_name_reg_ex{/config_reg_ex} | all}
   -markerType Marker types to fail build on {all | cdt | marker_id}
   -no-indexer Disable indexer
   -verbose    Verbose progress monitor updates
   -printErrorMarkers Print all error markers
   -I          {include_path} additional include_path to add to tools
   -include    {include_file} additional include_file to pass to tools
   -D          {prepoc_define} addition preprocessor defines to pass to the tools
   -E          {var=value} replace/add value to environment variable when running all tools
   -Ea         {var=value} append value to environment variable when running all tools
   -Ep         {var=value} prepend value to environment variable when running all tools
   -Er         {var} remove/unset the given environment variable
   -T          {toolid} {optionid=value} replace a tool option value in each configuration built
   -Ta         {toolid} {optionid=value} append to a tool option value in each configuration built
   -Tp         {toolid} {optionid=value} prepend to a tool option value in each configuration built
   -Tr         {toolid} {optionid=value} remove a tool option value in each configuration built
               Tool option values are parsed as a string, comma separated list of strings or a boolean based on the options type
```

## How to build

1. Download STM32CubeIDE in DEB format (should be `en.st-stm32cubeide_xxx_amd64.deb_bundle.sh.zip`) and put it in `assets`
2. Modify `docker-compose.yaml`, set `DEB_SH_NAME` and `STM32CUBEIDE_VERSION` values
3. Run `docker compose build`

## References

- https://gnu-mcu-eclipse.github.io/advanced/headless-builds/
