#!/usr/bin/env python3
"""
Provides some stats about Nginx logs stored in MongoDB.
"""
from pymongo import MongoClient

def log_stats(mongo_collection):
    total_logs = mongo_collection.count_documents({})
    print("{} logs".format(total_logs))

    methods = ["GET", "POST", "PUT", "PATCH", "DELETE"]
    print("Methods:")
    for method in methods:
        count = mongo_collection.count_documents({"method": method})
        print("\tmethod {}: {}".format(method, count))

    status_checks = mongo_collection.count_documents({"method": "GET", "path": "/status"})
    print("{} status check".format(status_checks))

    print("IPs:")
    pipeline = [
        {"$group": {"_id": "$ip", "count": {"$sum": 1}}},
        {"$sort": {"count": -1}},
        {"$limit": 10}
    ]

    top_ips = mongo_collection.aggregate(pipeline)

    for ip_info in top_ips:
        ip = ip_info["_id"]
        count = ip_info["count"]
        print("\t{}: {}".format(ip, count))

if __name__ == "__main__":
    client = MongoClient('mongodb://127.0.0.1:27017')
    logs_collection = client.logs.nginx

    log_stats(logs_collection)
