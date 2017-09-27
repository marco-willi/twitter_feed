from __future__ import absolute_import, print_function

from tweepy.streaming import StreamListener
from tweepy import OAuthHandler
from tweepy import Stream
from credentials import consumer_key, consumer_secret,\
                        access_token, access_token_secret
from pymongo import MongoClient
import json


class MongoDBListener(StreamListener):
    """ A listener handles tweets that are received from the stream.
    This is a mongo db listener, that extracts tweets as json and saves them
    in the mongo db collection
    """
    def __init__(self, collection):
        self.collection = collection

    def on_data(self, data):
        json_dict = json.loads(data)
        self.collection.insert_one(json_dict)
        print("Added tweet to db..")

    def on_error(self, status):
        print(status)


if __name__ == '__main__':

    # Database
    client = MongoClient('mongodb', 27017)
    db = client['tweets']
    raw_tweets_collection = db['raw_tweets']

    l = MongoDBListener(raw_tweets_collection)
    auth = OAuthHandler(consumer_key, consumer_secret)
    auth.set_access_token(access_token, access_token_secret)

    stream = Stream(auth, l)
    stream.filter(track=['chipotle'])
