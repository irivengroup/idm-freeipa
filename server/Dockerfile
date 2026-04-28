FROM rockylinux:9

ENV container=docker

# Pas de `dnf -y update` ici : sur Docker Desktop, il rend le build fragile.
# On active CRB, on nettoie le cache, puis on installe uniquement les paquets nécessaires.
RUN dnf -y install dnf-plugins-core && \
    (dnf config-manager --set-enabled crb || true) && \
    dnf -y clean all && \
    dnf -y makecache && \
    dnf -y install --allowerasing \
      ipa-server \
      ipa-server-dns \
      bind-dyndb-ldap \
      openssh-server \
      openssh-clients \
      sudo \
      chrony \
      procps-ng \
      iproute \
      net-tools \
      hostname \
      which \
      vim-minimal \
      less \
      nmap-ncat \
      curl && \
    dnf clean all

RUN mkdir -p /etc/systemd/system/named.service.d && \
    systemctl mask dev-hugepages.mount sys-fs-fuse-connections.mount || true && \
    systemctl unmask named httpd ipa-custodia ipa-dnskeysyncd || true

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY boot.sh /usr/local/bin/boot.sh
COPY freeipa-bootstrap.service /etc/systemd/system/freeipa-bootstrap.service
COPY named.service.d/override.conf /etc/systemd/system/named.service.d/override.conf

RUN chmod 0755 /usr/local/bin/entrypoint.sh /usr/local/bin/boot.sh && \
    systemctl enable sshd && \
    systemctl enable freeipa-bootstrap.service

VOLUME ["/data"]

CMD ["/usr/local/bin/boot.sh"]
