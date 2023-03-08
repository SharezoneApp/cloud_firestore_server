import 'package:cloud_firestore_server/src/query.dart';

/// A split point that can be used in a query as a starting and/or end point for
/// the query results. The cursors returned by {@link #startAt} and {@link
/// #endBefore} can only be used in a query that matches the constraint of query
/// that produced this partition.
@Deprecated('Unimplemented')
class QueryPartition {
  @Deprecated('Unimplemented')
  QueryPartition(
    @Deprecated('Unimplemented') this.startAt,
    @Deprecated('Unimplemented') this.endBefore,
  );

  /// The cursor that defines the first result for this partition or `null`
  /// if this is the first partition. The cursor value must be
  /// destructured when passed to `startAt()` (for example with
  /// `query.startAt(...queryPartition.startAt)`).
  ///
  /// @example
  /// const query = firestore.collectionGroup('collectionId');
  /// for await (const partition of query.getPartitions(42)) {
  ///   let partitionedQuery = query.orderBy(FieldPath.documentId());
  ///   if (partition.startAt) {
  ///     partitionedQuery = partitionedQuery.startAt(...partition.startAt);
  ///   }
  ///   if (partition.endBefore) {
  ///     partitionedQuery = partitionedQuery.endBefore(...partition.endBefore);
  ///   }
  ///   const querySnapshot = await partitionedQuery.get();
  ///   console.log(`Partition contained ${querySnapshot.length} documents`);
  /// }
  ///
  /// @type {Array<*>}
  /// @return {Array<*>} A cursor value that can be used with {@link
  /// Query#startAt} or `undefined` if this is the first partition.
  @Deprecated('Unimplemented')
  final dynamic startAt;

  //// The cursor that defines the first result after this partition or
  /// `undefined` if this is the last partition.  The cursor value must be
  /// destructured when passed to `endBefore()` (for example with
  /// `query.endBefore(...queryPartition.endBefore)`).
  ///
  /// @example
  /// const query = firestore.collectionGroup('collectionId');
  /// for await (const partition of query.getPartitions(42)) {
  ///   let partitionedQuery = query.orderBy(FieldPath.documentId());
  ///   if (partition.startAt) {
  ///     partitionedQuery = partitionedQuery.startAt(...partition.startAt);
  ///   }
  ///   if (partition.endBefore) {
  ///     partitionedQuery = partitionedQuery.endBefore(...partition.endBefore);
  ///   }
  ///   const querySnapshot = await partitionedQuery.get();
  ///   console.log(`Partition contained ${querySnapshot.length} documents`);
  /// }
  ///
  /// @type {Array<*>}
  /// @return {Array<*>} A cursor value that can be used with {@link
  /// Query#endBefore} or `undefined` if this is the last partition.
  @Deprecated('Unimplemented')
  final dynamic endBefore;

  /// Returns a query that only encapsulates the documents for this partition.
  ///
  /// dart```
  /// final query = firestore.collectionGroup('collectionId');
  /// await for (final partition of query.getPartitions(42)) {
  ///   final partitionedQuery = partition.toQuery();
  ///   final querySnapshot = await partitionedQuery.get();
  ///   print(`Partition contained ${querySnapshot.length} documents`);
  /// }
  /// ```
  @Deprecated('Unimplemented')
  Query toQuery() {
    throw UnimplementedError();
  }
}
