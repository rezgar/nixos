FROM ubuntu:bionic

RUN apt-get update && apt-get install -y \
                                  wget \
                                  libxi-dev \
                                  libx11-dev \ 
                                  libx11-xcb-dev \
                                  libgl1-mesa-glx \
                                  libpulse-dev \
                                  libnss3 \
                                  libxcomposite-dev \
                                  libxcursor-dev \
                                  libxtst-dev \
                                  libfontconfig \
                                  libxrandr-dev \
                                  libasound2 \
                                  libegl1-mesa libegl1 \
				  xdg-utils

RUN wget -O timedoctor.run https://s3.amazonaws.com/sfproc-downloads/3.0.79/linux/ubuntu-18.04/interactive/timedoctor2-setup-3.0.79-linux-x86_64.run
RUN chmod +x timedoctor.run
RUN ./timedoctor.run --mode unattended
RUN rm timedoctor.run
