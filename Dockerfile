FROM ubuntu:22.04

# Let us install tzdata painlessly
ENV DEBIAN_FRONTEND=noninteractive

# Needed for string substitution
SHELL ["/bin/bash", "-c"]

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update \
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get -y install --no-install-recommends \
    python3 \
    python3-pip \
    python-is-python3 \
    wget

COPY requirements.txt /tmp/pip-tmp/

RUN python -m pip install --upgrade pip \
 && pip install --upgrade --no-cache-dir --root-user-action=ignore -r /tmp/pip-tmp/requirements.txt \
 && rm -rf /tmp/pip-tmp

RUN mkdir -p ~/miniconda3 \
 && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh \
 && bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3 \
 && rm ~/miniconda3/miniconda.sh \
 && source ~/miniconda3/bin/activate \
 && conda init --all
