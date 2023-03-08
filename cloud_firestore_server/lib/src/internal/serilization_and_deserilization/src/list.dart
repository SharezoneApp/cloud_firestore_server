typedef ObjectListBuilder<T> = T Function(dynamic decodedMapValue);

/// Beispiel:
///
/// Primitive Daten:
/// ```
/// return AssignedUserArrays(
///   //...
///   // `allAssignedUids` ist hier einfach nur eine Liste an Strings.
///    allAssignedUids: decodeList(map['allAssignedUids'], (it) => it) ?? [],
///   //...
///  );
/// ```
///
/// "Komplexe"-Objekte:
/// ```
/// return AbgabeDto(
///   //...
///   abgabedateien: decodeList(data['submissionFiles'],
///       (it) => HochgeladeneAbgabedateiDto.fromData(it ?? {})),
///   //...
/// );
/// ```
List<T> decodeList<T>(dynamic data, ObjectListBuilder<T> builder) {
  if (data == null) return [];
  final originaldata = data as List<dynamic>;
  return originaldata.map((dynamic value) => builder(value)).toList();
}
