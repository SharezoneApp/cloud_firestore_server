import 'package:cloud_firestore_server/src/internal/instance_resources.dart';

import 'package:cloud_firestore_server/src/query.dart';
import 'package:cloud_firestore_server/src/query_partition.dart';

/// A [CollectionGroup] refers to all documents that are contained in a
/// collection or subcollection with a specific collection ID.
@Deprecated('Unimplemented')
class CollectionGroup extends Query {
  @Deprecated('Unimplemented')
  CollectionGroup(
    InstanceResources instanceResources, {
    required String path,
  }) : super(instanceResources, path: path);

  /// Partitions a query by returning partition cursors that can be used to run
  /// the query in parallel. The returned cursors are split points that can be
  /// used as starting and end points for individual query invocations.
  ///
  /// dart```
  /// final query = firestore.collectionGroup('collectionId');
  /// await for (final partition of query.getPartitions(42)) {
  ///   final partitionedQuery = partition.toQuery();
  ///   final querySnapshot = await partitionedQuery.get();
  ///   print('Partition contained ${querySnapshot.length} documents');
  /// }
  /// ```
  ///
  /// [desiredPartitionCount] is the desired maximum number of
  /// partition points. The number must be strictly positive. The actual number
  /// of partitions returned may be fewer.
  @Deprecated('Unimplemented')
  Stream<QueryPartition> getPartitions(int desiredPartitionCount) async* {
    throw UnimplementedError();
  }
}
