#!/bin/bash
set -e

cd ./cloud_firestore_server
pub get
# To make pub global work
export PATH="$PATH":"$HOME/.pub-cache/bin"
pub global activate tuneup
# TODOs should be Tickets - not TODO comments.
tuneup check . --fail-on-todos