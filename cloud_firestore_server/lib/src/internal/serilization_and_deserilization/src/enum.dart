T? enumFromString<T>(List<T> values, dynamic json, {T? orElse}) => json != null
    ? values.firstWhere(
        (it) =>
            '$it'.split(".")[1].toLowerCase() == json.toString().toLowerCase(),
        orElse: orElse != null ? () => orElse : null,
      )
    : orElse;

String enumToString<T>(T value) => value.toString().split('.')[1];
