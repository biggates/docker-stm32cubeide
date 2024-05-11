FROM busybox as prepare

ARG DEB_SH_NAME

COPY assets/${DEB_SH_NAME} /tmp/stm32cubeide-installer.sh.zip

RUN unzip -p /tmp/stm32cubeide-installer.sh.zip > /tmp/stm32cubeide-installer.sh && rm /tmp/stm32cubeide-installer.sh.zip

FROM ubuntu:22.04 as runtime

LABEL org.opencontainers.image.authors="Xiaoyu Guo <biggates2010@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update \
    && apt-get -y -f install --no-install-recommends \
        libusb-1.0.0 \
        udev \
        libncurses5 \
        libpython2.7 \
        libwebkit2gtk-4.0 \
    && rm -rf /var/lib/apt/lists/*

# Install STM32 Cube IDE

ARG STM32CUBEIDE_VERSION
ENV LICENSE_ALREADY_ACCEPTED=1
ENV SETUP_NOCHECK=1

ENV PATH="${PATH}:/opt/st/stm32cubeide_${STM32CUBEIDE_VERSION}"

COPY --from=prepare --chmod=755 /tmp/stm32cubeide-installer.sh /tmp

# Install STM32 Cube IDE and delete installer
RUN /tmp/stm32cubeide-installer.sh --quiet && \
    rm /tmp/stm32cubeide-installer.sh
