T fromJson<T>(
  Map<String, dynamic> json,
  T Function(Map<String, dynamic>) factory,
) {
  return factory(json);
}