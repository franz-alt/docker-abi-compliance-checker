ABICC With Docker
=================

Dockerfile executing a tool for checking backward binary and source-level compatibility of a C/C++ library.

Contents
--------

1. [ About      ](#about)
2. [ Install    ](#install)
3. [ Usage      ](#usage)
4. [ License    ](#license)

About
-----

The tool [ABICC](https://github.com/lvc/abi-compliance-checker/) developed by Andrey Ponomarenko analyzes changes in API/ABI that may break binary or source-code compatibility of a C/C++ library. This could be very useful to decide if a new version of a library is fully compatible with its previous version or if compatibility is broken and a new major number of the library has to be set.

ABICC needs some additional tools to work properly. To avoid installing several dependencies ABICC requires a Dockerfile should install and configure all these dependencies and provide an easy to use script to generate a compatibility report.

Installation
------------

Create the Docker image with the command:

    docker build -t docker-abicc:1.0 .

Usage
-----

Execute the Docker image and use a volume at your host machine where your libraries are located.

Example:

    docker run -v /my-host-directory:/data --rm -it docker-abicc:1.0

After this a bash will be opened at /data directory. Here you should find your libraries.

You can generate a report with the generate_report.sh script that needs following informations:
- name of the library
- filename of the old library
- filename of the new library
- version of the old library
- version of the new library

Example:

    generate_report.sh --libname mylib --old_lib mylib.so.1.0 --old_ver 1.0 --new_lib mylib.so.1.1 --new_ver 1.1

License
-------

Copyright (c) 2021 Franz Alt

This project is distributed under the [MIT License](https://opensource.org/licenses/MIT), see [LICENSE](./LICENSE) for more information.
