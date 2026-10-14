/// Reads a list from a response body shaped like `[...]` or `{ "data": [...] }`.
List<Map<String, dynamic>> jsonList(dynamic body, {String key = 'data'}) {
  final dynamic raw = body is Map ? body[key] : body;
  return (raw as List<dynamic>).cast<Map<String, dynamic>>();
}

/// Reads an object from a response body shaped like `{...}` or `{ "data": {...} }`.
Map<String, dynamic> jsonMap(dynamic body, {String key = 'data'}) {
  if (body is Map && body[key] is Map) {
    return (body[key] as Map).cast<String, dynamic>();
  }
  return (body as Map).cast<String, dynamic>();
}
