import 'package:cloud_firestore_server/cloud_firestore_server.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

// Easier to read in tests:
// ignore_for_file: prefer_function_declarations_over_variables

Future<void> main() async {
  group('innerClient', () {
    late Firestore firestore;
    late SpyingClient innerClient;

    setUp(() async {
      innerClient = SpyingClient(http.Client());
      firestore = await Firestore.internal(
        url: 'http://localhost:8080/',
        innerClient: innerClient,
      );
    });
    test(
        'passed to Firestore.internal using googleapis gets the requests sent to the Firestore backend.',
        () async {
      final requestsBefore = List.from(innerClient.sentRequests);
      await firestore.doc('col/doc').get().ignoreResultAndExceptions();
      final requestsAfter = List.from(innerClient.sentRequests);

      expect(requestsBefore, isEmpty);
      expect(requestsAfter, hasLength(1));
    });

    /// Here I test my own method implementation because after more than 3 years
    /// the bug that querying with the googleapis package does not work is still
    /// not fixed :(
    /// https://github.com/dart-lang/googleapis/issues/25
    test(
        'passed to Firestore.internal using own query implementation gets the requests sent to the Firestore backend.',
        () async {
      final requestsBefore = List.from(innerClient.sentRequests);
      await firestore
          .collection('col')
          .where('foo', isEqualTo: 'bar')
          .get()
          .ignoreResultAndExceptions();
      final requestsAfter = List.from(innerClient.sentRequests);

      expect(requestsBefore, isEmpty);
      expect(requestsAfter, hasLength(1));
    });
  });
}

extension on Future {
  /// Ignores the given result or if the Future throws.
  /// Always returns a successful Future.
  ///
  /// In the tests we just care that the Firestore method has used the http
  /// Client. We don't care if it was successful or failing.
  Future<void> ignoreResultAndExceptions() async {
    try {
      await this;
      // ignore: empty_catches
    } catch (e) {}
  }
}

class SpyingClient extends http.BaseClient {
  final http.Client delegate;
  final List<http.BaseRequest> sentRequests = [];

  SpyingClient(this.delegate);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    sentRequests.add(request);
    return delegate.send(request);
  }
}
