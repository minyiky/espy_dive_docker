FROM ubuntu

RUN apt-get update && \
    apt-get install -y libgtk-3-dev libsdl2-dev x11-xserver-utils parallel libfreetype-dev librlottie-dev

RUN make -C micropython/mpy-cross
RUN make -C micropython/ports/unix

RUN ports/unix/micropython gui.py
