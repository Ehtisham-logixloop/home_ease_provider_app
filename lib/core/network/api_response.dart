class ApiResponse {
  final bool success;
  final int statusCode;
  final String message;
  final dynamic data;

  ApiResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  bool get isUnauthorized => statusCode == 401;
  bool get isNotFound => statusCode == 404;
  bool get isServerError => statusCode >= 500;

  List<T> parseList<T>(T Function(Map<String, dynamic>) fromJson) {
    if (data == null) return <T>[];
    if (data is List) {
      return (data as List)
          .map((e) => e is Map<String, dynamic>
              ? fromJson(e)
              : fromJson(<String, dynamic>{}))
          .toList();
    }
    if (data is Map<String, dynamic>) {
      final listKey = data['data'];
      if (listKey is List) {
        return listKey
            .map((e) => e is Map<String, dynamic>
                ? fromJson(e)
                : fromJson(<String, dynamic>{}))
            .toList();
      }
    }
    return <T>[];
  }

  T? parseObject<T>(T Function(Map<String, dynamic>) fromJson) {
    if (data == null) return null;
    if (data is Map<String, dynamic>) {
      return fromJson(data as Map<String, dynamic>);
    }
    return null;
  }
}
