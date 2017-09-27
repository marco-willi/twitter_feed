FROM ubuntu:16.04
RUN apt-get update && apt-get install -y \
    python3-pip
RUN pip3 install --upgrade pip
RUN pip3 install tweepy pymongo
RUN mkdir /data
WORKDIR /code
CMD ["python3", "main.py"]
