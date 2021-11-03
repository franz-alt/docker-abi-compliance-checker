#!/bin/bash

LGREEN='\033[1;32m'
NC='\033[0m' # No Color

printf "${LGREEN}\n"

printf "Info:\n\n"

printf "To Generate an ABI/API report execute 'generate_report.sh'.\n\n"

printf "Example:\n\n";

printf "generate_report.sh --libname mylib --old_lib mylib.so.1.0 --old_ver 1.0 --new_lib mylib.so.1.1 --new_ver 1.1\n"

printf "${NC}\n"

/bin/bash
