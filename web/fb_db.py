import threading
import requests
import json
from flask import Flask, jsonify

from connect_firebase import connect

app = Flask(__name__)
requests_coll = connect('bed_requests')

delete_done = threading.Event()

# Create a callback on_snapshot function to capture changes
def on_snapshot(col_snapshot, changes, read_time):
    print(u'Callback received query snapshot.')
    for change in changes:
        if change.type.name == 'ADDED':
            print(f'New request: {change.document.id}')
            to_send = {"type":"new", "data": change.document.to_dict(), "id": change.document.id}
            x = requests.post(url='http://127.0.0.1:5000/updating', data=json.dumps(to_send))
        elif change.type.name == 'MODIFIED':
            print(f'Modified request: {change.document.id}')
            to_send = {"type":"modified", "data": change.document.to_dict(), "id": change.document.id}
            x = requests.post(url='http://127.0.0.1:5000/updating', data=json.dumps(to_send))
        elif change.type.name == 'REMOVED':
            print(f'Removed request: {change.document.id}')
            delete_done.set()

@app.route('/', methods=['GET', 'POST'])
def home():
    col_query = requests_coll.where(u'hid', u'==', u'WXoBQ6WgZyuMgKZ5NFmU')
    query_watch = col_query.on_snapshot(on_snapshot)
    return jsonify({"status":"fine"})

if __name__ == "__main__":
    app.run(debug=True, port=8080)
