#!/bin/bash

readonly TAG_PREFIX="\e[0;37m["
readonly TAG_SUFFIX="\e[0;37m]\e[0m"
readonly TAG_STATUS="$TAG_PREFIX\e[1;34mSTATUS$TAG_SUFFIX";
readonly TAG_SKIP="$TAG_PREFIX\e[1;33mSKIPPING$TAG_SUFFIX";
readonly TAG_FAIL="$TAG_PREFIX\e[1;31mFAILED$TAG_SUFFIX";
readonly TAG_DONE="$TAG_PREFIX\e[1;32mDONE$TAG_SUFFIX";

readonly PATH_TO_SCRIPTS="$(dirname $0)/scripts"
readonly ABSOLUTE_PATH=$(realpath $(dirname $0))
readonly SRC_DIR="src";

readonly DEFAULT_SHELL="fish";
