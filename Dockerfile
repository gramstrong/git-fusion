FROM ubuntu:14.04

ARG GITP4PASSWD

# Initial update
RUN  apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

# Import the Perforce package signing key
RUN wget -q http://package.perforce.com/perforce.pubkey -O- | sudo apt-key add -

# Add the Perforce package repository
RUN touch /etc/apt/sources.list.d/perforce.list \
  && echo "deb http://package.perforce.com/apt/ubuntu trusty release" >> /etc/apt/sources.list.d/perforce.list

# Update the package repository 
RUN apt-get update

# Install git fusion and set password for git service account
RUN apt-get --assume-yes install helix-git-fusion \
  && echo "git:${GITP4PASSWD}" | chpasswd
