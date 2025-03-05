#!/bin/sh
set -e

echo "Activating feature 'dotfiles'"
echo "BOOTSTRAP: ${BOOTSTRAP}"


# The 'install.sh' entrypoint script is always executed as the root user.
#
# These following environment variables are passed in by the dev container CLI.
# These may be useful in instances where the context of the final
# remoteUser or containerUser is useful.
# For more details, see https://containers.dev/implementors/features#user-env-var
echo "The effective dev container remoteUser is '$_REMOTE_USER'"
echo "The effective dev container remoteUser's home directory is '$_REMOTE_USER_HOME'"

echo "The effective dev container containerUser is '$_CONTAINER_USER'"
echo "The effective dev container containerUser's home directory is '$_CONTAINER_USER_HOME'"
echo "Contents of .ssh directory:"
ls -alth $_CONTAINER_USER_HOME/.ssh/

# Install the YADM dotfiles manager
curl -fLo /usr/local/bin/yadm https://github.com/yadm-dev/yadm/raw/master/yadm
chmod a+x /usr/local/bin/yadm

# Add github host keys to known hosts
mkdir ~/.ssh
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

# # Clone my dotfiles repo using YADM and bootstrap my environment using
# bootstrap script
cd $HOME && /usr/local/bin/yadm clone --bootstrap git@github.com:kwrobert/dotfiles.git
