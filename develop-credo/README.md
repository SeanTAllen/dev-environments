# Develop with Pony

Containerized environment for developing [seantallen-org/credo](https://github.com/seantallen-org/credo). The environment is Alpine Linux based. This allows me to easily compile credo so that statically to musl libc. This is important to me because I want to be able to run my programs on any Linux system without having to worry about what libc is installed.

Includes all additional dependencies for building credo. At the moment, that is only [rego-cpp](https://github.com/microsoft/rego-cpp).
