FROM alpine:3.21

LABEL org.opencontainers.image.source="https://github.com/seantallen/dev-environments"

# Do basic user and group setup
RUN addgroup -g 107 docker \
  && addgroup -g 1000 sean \
  && adduser -s /usr/bin/fish -D -u 1000 -G sean sean \
  && addgroup sean wheel \
  && addgroup sean docker \
  && echo "sean:" | chpasswd

# Install docs so that any tools that come later will install there's
RUN apk add --update --no-cache \
  docs

# Install shells first for any tools get clever about installing shell specific completions
RUN apk add --update --no-cache \
  bash \
  fish

# Everything else
RUN apk add --update --no-cache \
  binutils-gold \
  build-base \
  clang \
  curl \
  delta \
  doas \
  git \
  gnupg \
  less \
  libressl-dev \
  lldb \
  make \
  nmap-ncat \
  openssh \
  pcre2-dev \
  pinentry-tty \
  vim

# vim not vi
RUN ln -fs /usr/bin/vim /usr/bin/vi

# Allow me to use doas
RUN echo "permit persist :wheel" >> /etc/doas.d/doas.conf

WORKDIR /tmp

RUN wget https://github.com/atuinsh/atuin/releases/download/v18.4.0/atuin-x86_64-unknown-linux-musl.tar.gz \
 && tar -xvf atuin-x86_64-unknown-linux-musl.tar.gz \
 && mv atuin-x86_64-unknown-linux-musl/atuin /usr/local/bin/

# Pretty shell prompt
RUN wget https://starship.rs/install.sh \
  && sh install.sh -y

USER sean

# Install nightly pony tools for user 'sean'
ENV PATH="/home/sean/.local/share/ponyup/bin:$PATH"

RUN sh -c "$(curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/ponylang/ponyup/latest-release/ponyup-init.sh)" \
 && ponyup update ponyc nightly \
 && ponyup update corral nightly \
 && ponyup update changelog-tool nightly

# To get pinentry working on MacOS and Linux I had to put a link in a
# special location
RUN mkdir ~/bin \
  && ln -s /usr/bin/pinentry-tty ~/bin/pinentry-tty

USER root

RUN rm -rf /tmp/*


