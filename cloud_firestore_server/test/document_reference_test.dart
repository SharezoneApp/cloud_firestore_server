import 'package:cloud_firestore_server/cloud_firestore_server.dart';
import 'package:test/test.dart';

void main() {
  group('DocumentReference', () {
    test('.path example test', () async {
      final firestore = await Firestore.internal();

      final path = firestore
          .collection('letters')
          .doc('my-letter-123')
          .collection('revisions')
          .doc('my-revision-3')
          .path;

      expect(path, 'letters/my-letter-123/revisions/my-revision-3');
    });
  });
}
