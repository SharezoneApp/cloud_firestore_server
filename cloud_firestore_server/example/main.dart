import 'package:cloud_firestore_server/cloud_firestore_server.dart';
// ignore_for_file: avoid_print

Future<void> main() async {
  final credentials =
      ServiceAccountCredentials.fromPath('my-service-account.json');
  final firestore = await Firestore.newInstance(credentials: credentials);

  final document = await firestore.collection('Chats').doc('my-msg-123').get();
  final msg = document.get('messageText');
  print(msg);
}
