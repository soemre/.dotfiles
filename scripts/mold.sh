#!/bin/bash

sudo mv /usr/bin/ld /usr/bin/ld-backup

sudo ln -s /usr/bin/mold /usr/bin/ld
