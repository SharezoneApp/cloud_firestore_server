#!/bin/bash
set -e

echo "This is not yet implemented. See https://github.com/SharezoneApp/cloud_firestore_server/issues/3"
exit 1

cd cloud_firestore_server
dart pub get
dart test