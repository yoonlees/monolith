FROM ubuntu:14.04

RUN apt-get -y update

RUN apt-get -y install \
  git \
  wget \
  python-dev \
  python-virtualenv \
  libffi-dev \
  libssl-dev

WORKDIR /root

ENV PRODUCT monolith

RUN wget https://bootstrap.pypa.io/get-pip.py \
  && python get-pip.py

WORKDIR interstella

RUN virtualenv ${PRODUCT}

WORKDIR ${PRODUCT}

RUN bin/pip install --upgrade pip && \
    bin/pip install requests[security]

#[TODO]: Copy monolith.py and requirements file into container image
COPY ./requirements.txt .
COPY ./monolith.py .

#[TODO]: Install dependencies listed in the requirements.txt file using pip
RUN bin/pip install -r requirements.txt

#[TODO]: Specify a listening port for the container
EXPOSE 5000

#[TODO]: Run the monolith.py as the final step. We want this container to run as an executable. Looking at ENTRYPOINT for this?
ENTRYPOINT bin/python monolith.py

