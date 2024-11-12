FROM nvcr.io/nvidia/pytorch:24.10-py3

# Let us install tzdata painlessly
ENV DEBIAN_FRONTEND=noninteractive

# Needed for string substitution
SHELL ["/bin/bash", "-c"]

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
