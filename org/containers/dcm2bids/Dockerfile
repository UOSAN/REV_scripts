# To "login" to the container:
# docker run -ti < container >

FROM stackbrew/debian:jessie

ARG DEBIAN_FRONTEND=noninteractive

# Install any needed packages
RUN apt-get update -qq && \
	apt-get install -qy --no-install-recommends \
	git \
	python3 \
	python-pip

RUN cd / && git clone https://github.com/cbedetti/Dcm2Bids.git && cd Dcm2Bids

RUN pip install dcm2bids


# Set the working directory to dcm2Bids
WORKDIR /Dcm2Bids