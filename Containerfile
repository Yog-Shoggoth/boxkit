FROM registry.fedoraproject.org/fedora-toolbox:latest

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="yog_shoggoth"

COPY extra-packages /
RUN dnf -y upgrade && \
    dnf -y install $(</extra-packages)
RUN rm /extra-packages

RUN dnf copr enable -y errornointernet/packages && \
    dnf -y install yazi

RUN dnf install -y \
    "https://github.com/twpayne/chezmoi/releases/download/v2.55.0/chezmoi-2.55.0-x86_64.rpm" \
    dnf install -y \
    chezmoi

RUN   ln -fs /bin/sh /usr/bin/sh && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update
     
