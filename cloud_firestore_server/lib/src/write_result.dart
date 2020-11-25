import 'package:cloud_firestore_server/cloud_firestore_server.dart';

class WriteResult {
  /// The write time as set by the Firestore servers.
  /// This attribute is nullable as we do not seem to get the Write Time back
  /// from the googleapis Firestore-Api. We may get it if we use the
  /// GRPC-library in the future.
  final Timestamp? writeTime;

  WriteResult({this.writeTime});
}
