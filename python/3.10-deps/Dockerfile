FROM python:3.10.14-bookworm as base

# Silence configuration prompts
ENV DEBIAN_FRONTEND noninteractive

ENV PYTHONUNBUFFERED 1

ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

# Install prerequisite packages
RUN apt-get update -q && \
    apt-get install -y --no-install-recommends \
    automake \
    binutils \
    build-essential \
    curl \
    gcc \
    gdal-bin \
    gfortran \
    ghostscript \
    git \
    libatlas-base-dev \
    libbz2-dev \
    libffi-dev \
    libjpeg-dev \
    libmemcached-dev \
    libpcre3 \
    libpcre3-dev \
    libpq-dev \
    libproj-dev \
    libreadline-dev \
    libssl-dev \
    libtool \
    libxml2-dev \
    libxslt1-dev \
    locales \
    memcached \
    netcat-traditional \
    openssh-client \
    pkg-config \
    software-properties-common \
    zlib1g-dev \
    && sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && dpkg-reconfigure locales && useradd -G tty -m appuser \
    && apt-get remove -y python3 \
    # Fix CVE-2022-40897, CVE-2023-50782, CVE-2024-26130, CVE-2023-0286
    && /usr/local/bin/python3.10 -m pip install --upgrade setuptools==70.2.0 pip==24.1.1 cryptography==42.0.8 \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Generate and set en_US.UTF-8 locale
RUN
USER appuser

RUN curl https://pyenv.run | bash

ENV HOME /home/appuser
ENV PYENV_ROOT="$HOME/.pyenv"
ENV PATH $PYENV_ROOT/versions/3.10.14/bin:$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN pyenv install 3.10.14 && pyenv global 3.10.14 && pyenv rehash \
  && /home/appuser/.pyenv/versions/3.10.14/bin/pip install --upgrade pip==24.1.1 setuptools==70.2.0

CMD ["python"]
