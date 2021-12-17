FROM ubuntu:20.04 AS base

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London

RUN apt-get update && \
    apt-get install -y libgtk-3-dev libsdl2-dev x11-xserver-utils parallel libfreetype-dev librlottie-dev build-essential

FROM base AS micropython

COPY ./micropython ./micropython

RUN make -C ./micropython/mpy-cross
RUN make -C ./micropython/ports/unix

FROM micropython

COPY ./gui.py ./gui.py
COPY ./imports.py ./imports.py

# RUN ./micropython/ports/unix/micropython-dev imports.py
# RUN ./micropython/ports/unix/micropython gui.py
