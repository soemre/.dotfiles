#!/bin/bash

# Configure Default Shell
sudo sh -c "which fish >> /etc/shells"
sudo chsh -s "$(which fish)"

