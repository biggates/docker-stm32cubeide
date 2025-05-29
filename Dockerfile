# Stage 1: extract installer
FROM busybox AS prepare

ARG DEB_SH_ZIP_NAME

COPY assets/${DEB_SH_ZIP_NAME} /tmp/stm32cubeide-installer.sh.zip 

RUN unzip -p /tmp/stm32cubeide-installer.sh.zip > /tmp/stm32cubeide-installer.sh && rm /tmp/stm32cubeide-installer.sh.zip

# Stage 2: install STM32CubeIDE
FROM ubuntu:24.04 AS install

ENV DEBIAN_FRONTEND=noninteractive

# ARG for mirror selection
ARG MIRROR

# Check if MIRROR is set to 1 and run sed command accordingly
RUN if [ "$MIRROR" = "1" ]; then \
        sed -i 's|http://archive.ubuntu.com/ubuntu/|http://mirrors.aliyun.com/ubuntu/|g; s|http://security.ubuntu.com/ubuntu/|http://mirrors.aliyun.com/ubuntu/|g' /etc/apt/sources.list.d/ubuntu.sources; \
    fi

# Install required dependencies to pass installer check
RUN apt-get update \
    && apt-get -y -f install --no-install-recommends \
        libusb-1.0.0 \
        udev \
    && rm -rf /var/lib/apt/lists/*

# Install STM32 Cube IDE

ARG STM32CUBEIDE_VERSION
ENV LICENSE_ALREADY_ACCEPTED=1
ENV SETUP_NOCHECK=1

ENV PATH="${PATH}:/opt/st/stm32cubeide_${STM32CUBEIDE_VERSION}"

COPY --from=prepare --chmod=755 /tmp/stm32cubeide-installer.sh /tmp

# Install STM32 Cube IDE and delete installer
RUN /tmp/stm32cubeide-installer.sh --quiet

# Stage 3: copy runtime
FROM ubuntu:24.04 AS runtime

LABEL org.opencontainers.image.authors="Xiaoyu Guo <biggates2010@gmail.com>"

ARG STM32CUBEIDE_VERSION
ENV PATH="${PATH}:/opt/st/stm32cubeide_${STM32CUBEIDE_VERSION}"

COPY --from=install /opt/st /opt/st
