import 'dart:io';

import 'package:cloud_firestore_server/cloud_firestore_server.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

// Easier to read in tests:
// ignore_for_file: prefer_function_declarations_over_variables

/// Returns the credentials for the live Firestore test database from the
/// environment variable FIRESTORE_CREDENTIALS.
/// This method is called to run the remote tests on Github Actions.
/// The credentials are passed via Action Secrets.
/// Locally the remote tests can be skipped via
/// `dart --no-sound-null-safety test --exclude-tags remote`.
ServiceAccountCredentials getCredentialsFromEnvironment() {
  final _creds = Platform.environment['FIRESTORE_CREDENTIALS'];
  if (_creds == null) {
    throw ArgumentError(
        'The environment variable "FIRESTORE_CREDENTIALS" does not have the firestore service account credentials. This environment variable is usually provided via Github Secrets.\n'
        'If you develop locally you should run only the tests that dont need the credentials. You can do this by running "dart --no-sound-null-safety test --exclude-tags remote".');
  }
  return ServiceAccountCredentials.fromJson(_creds);
}

Future<void> main() async {
  /// We seperate both as the remote tests can only be run on Github Actions as
  /// locally one might not have the necessary credentials.
  group('(using Emulator)', () {
    runTests((innerClient) => Firestore.internal(
          url: 'http://localhost:8080/',
          innerClient: innerClient,
        ));
  }, tags: 'emulator');
  group('(using remote Firestore)', () {
    runTests((innerClient) => Firestore.newInstance(
          credentials: getCredentialsFromEnvironment(),
          innerClient: innerClient,
        ));
  }, tags: 'remote');
}

void runTests(
    Future<Firestore> Function(SpyingClient innerClient) setupFirestore) {
  group('innerClient', () {
    late Firestore firestore;
    late SpyingClient innerClient;

    setUp(() async {
      innerClient = SpyingClient(http.Client());
      firestore = await setupFirestore(innerClient);
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

    /// The query method is a custom implementation we have to test seperately
    /// from the implementation of the googleapis package.
    /// The query implementation is custom made as after 3 years the bug that
    /// querying with the googleapis package does not work is still not fixed :(
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
