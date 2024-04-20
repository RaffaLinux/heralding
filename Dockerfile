FROM debian:bullseye-slim as base


# Install dependencies
COPY requirements.txt requirements.txt
RUN apt update
RUN apt install vlan net-tools ethtool iproute2 iputils-ping traceroute python3 python3-pip -y
RUN apt install procps -y
RUN apt-get install python3-pip python3-dev build-essential libssl-dev libffi-dev -y
RUN apt-get update && apt-get install -y libpq-dev gcc \
    && pip install --user --no-cache-dir -r requirements.txt 
# Install Heralding
RUN pip install heralding
COPY ./heralding/heralding.yml /usr/local/lib/python3.9/dist-packages/heralding/heralding.yml
COPY ./heralding/heralding.yml heralding.yml

CMD ["heralding" ]
#EXPOSE 21 22 23 25 80 110 143 443 465 993 995 1080 2222 3306 3389 5432 5900
