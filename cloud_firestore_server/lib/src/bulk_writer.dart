// ignore: deprecated_member_use
/// Options to configure throttling on [BulkWriter]
class BulkWriterOptions {
  static const defaultInitialOpsPerSecond = 500;

  final bool throttlingEnabled;
  final int initialOpsPerSecond;
  final int? maxOpsPerSecond;

  BulkWriterOptions.disableThrottling()
      : throttlingEnabled = false,
        initialOpsPerSecond = defaultInitialOpsPerSecond,
        maxOpsPerSecond = null;

  // ignore: deprecated_member_use
  /// Enables throttling of the [BulkWriter].
  ///
  /// [initialOpsPerSecond] describes the initial maximum number of operations
  /// per second allowed by the throttler. If this field is not set, the default
  /// is 500 operations per second.
  ///
  /// [maxOpsPerSecond] describes the maximum number of operations per second
  /// allowed by the throttler. If this field is set, the throttler's allowed
  /// operations per second does not ramp up past the specified operations per
  /// seconds.
  /// If this field is not set the maximum of operations per second will not be
  /// limited.
  BulkWriterOptions.enableThrottling({
    this.initialOpsPerSecond = defaultInitialOpsPerSecond,
    this.maxOpsPerSecond,
  }) : throttlingEnabled = true {
    if (initialOpsPerSecond.isNegative) {
      throw ArgumentError.value(
          initialOpsPerSecond, 'initialOpsPerSecond', "can't be negative");
    }
    if (maxOpsPerSecond != null) {
      if (maxOpsPerSecond!.isNegative) {
        throw ArgumentError.value(
            maxOpsPerSecond, 'maxOpsPerSecond', "can't be negative");
      }
      if (initialOpsPerSecond > maxOpsPerSecond!) {
        throw ArgumentError(
            "initialOpsPerSecond ($initialOpsPerSecond) can't be higher than maxOpsPerSecond ($maxOpsPerSecond)");
      }
    }
  }
}

@Deprecated(
    'Unimplemented - There neeeds to be some discussion how a good native Dart Api would look like.')
class BulkWriter {}
