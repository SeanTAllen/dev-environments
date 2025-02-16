FROM alpine:3.21 AS builder

RUN apk add --update --no-cache \
  atuin \
  binutils-gold \
  build-base \
  clang \
  cmake \
  git \
  ninja

# Build rego-cpp v0.4.6
RUN git clone --branch v0.4.6 https://github.com/microsoft/rego-cpp.git \
  && cd rego-cpp \
  && mkdir build \
  && cd build \
  && cmake .. --preset release-clang \
  && ninja install \
  && cd dist/lib/ \
  && cp `clang --print-file-name='libstdc++.a'` libstdcpp.a \
  && echo "create librego-standalone.a" > standalone.mri \
  && echo "addlib libstdcpp.a" >> standalone.mri \
  && echo "addlib libjson.a" >> standalone.mri \
  && echo "addlib libre2.a" >> standalone.mri \
  && echo "addlib librego.a" >> standalone.mri \
  && echo "addlib libsnmalloc-new-override.a" >> standalone.mri \
  && echo "addlib libyaml.a" >> standalone.mri \
  && echo "save" >> standalone.mri \
  && echo "end" >> standalone.mri \
  && ar -M < standalone.mri \
  && cp librego-standalone.a /usr/local/lib

FROM ghcr.io/seantallen/dev-environment-develop-with-pony:latest

LABEL org.opencontainers.image.source="https://github.com/seantallen/dev-environments"

COPY --from=builder /rego-cpp/build/dist/lib/librego-standalone.a /usr/local/lib/librego-standalone.a
