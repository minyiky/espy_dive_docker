FROM ubuntu:20.04 AS base

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London

RUN apt-get update && \
    apt-get install -y libgtk-3-dev libsdl2-dev x11-xserver-utils parallel libfreetype-dev librlottie-dev build-essential libffi-dev pkg-config autoconf autogen libtool && \
    apt-get install -y libreadline-dev libsdl2-2.0-0 python3.8

FROM base AS micropython

COPY ./micropython ./micropython

RUN make -C ./micropython/ports/unix deplibs
RUN make -C ./micropython/mpy-cross VARIANT=dev
RUN make -C ./micropython/ports/unix VARIANT=dev

ENV PATH="/micropython/ports/unix:${PATH}"

FROM micropython AS application

COPY ./gui.py ./gui.py
COPY ./imports.py ./imports.py

# RUN ./micropython/ports/unix/micropython-dev imports.py
CMD micropython-dev gui.py
