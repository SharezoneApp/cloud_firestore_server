#!/bin/bash
set -e

cd cloud_firestore_server
dart pub get
dart --no-sound-null-safety test --tags remote