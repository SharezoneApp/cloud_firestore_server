class FieldPathType {
  final String fieldPath;
  const FieldPathType(this.fieldPath);

  static const FieldPathType documentId = FieldPathType('__name__');
}
