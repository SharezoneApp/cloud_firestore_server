A Firestore library for your backend.
Similar to the Firestore library in Firebase Admin.

Currently is only used internally, we don't know yet when and if we have time to expand this library to make it fully usable.

Most of the interfaces exposed by the Firestore "Admin" library are exposed here but not implemented. There will probably still be breaking changes in the Future.
Everything not implemented is marked as deprecated.
If any Interface is not marked deprecated, it **does not** mean that it is fully implemented.
Experiment for yourself there may not be documentation on what works and what does not.

There are no tests. No guarantees that anything works. Use at your own risk. 

In the future we might expand this library to be fully usable and publish it on pub.

## Usage

A simple usage example:

```dart
import 'package:cloud_firestore_server/cloud_firestore_server.dart';

Future<void> main() async {
  final credentials =
      ServiceAccountCredentials.fromPath('my-service-account.json');
  final firestore = await Firestore.newInstance(credentials: credentials);

  final document = await firestore.collection('Chats').doc('my-msg-123').get();
  final msg = document.get('messageText');
  print(msg);
}
```

To add this package to your Dart project:
```yaml
  cloud_firestore_server:
    git:
      url: https://github.com/SharezoneApp/cloud_firestore_server.git
      path: 'cloud_firestore_server'
      # You should write a commit id here so that breaking changes on master don't break your code.
      ref: 4d4be3cc972ca9fcea2c4ce92a432496ad146461f
```
