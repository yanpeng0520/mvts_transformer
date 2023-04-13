# Base python 3.8 Image
FROM python:3.8

# Update packages and install core software
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y git git-lfs gpgconf curl \
            libgit2-dev

# Install python packages
RUN pip install --upgrade pip
RUN pip install -r failsafe_requirements.txt

# Deploy a nice prompt
RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes


EXPOSE 22

ADD ssh_keys.tar.gz /tmp/
RUN mkdir -p /root/.ssh \
    && mv /tmp/ssh_keys/authorized_keys /root/.ssh/authorized_keys \
    && chown root:root /root/.ssh/authorized_keys \
    && rm -rf /tmp/ssh_keys ssh_keys.tar.gz