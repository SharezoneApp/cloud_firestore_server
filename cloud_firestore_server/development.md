Tests are currently using the firebase emulator.

To run the emulator you need to install the [Firebase CLI](https://firebase.google.com/docs/cli).  

If you haven't already donwload the Firestore Emulator:
```
$ firebase setup:emulators:firestore
```

Now you can run the emulator using: 
```
$  firebase emulators:start --only firestore
```

Now you can run the tests using:
```
$ dart --no-sound-null-safety test
```