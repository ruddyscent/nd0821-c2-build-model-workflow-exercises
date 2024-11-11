FROM nvcr.io/nvidia/pytorch:24.10-py3

# Let us install tzdata painlessly
ENV DEBIAN_FRONTEND=noninteractive

# Needed for string substitution
SHELL ["/bin/bash", "-c"]

COPY requirements.txt /tmp/pip-tmp/

RUN python -m pip install --upgrade pip \
 && pip install --upgrade --no-cache-dir --root-user-action=ignore -r /tmp/pip-tmp/requirements.txt \
 && rm -rf /tmp/pip-tmp
