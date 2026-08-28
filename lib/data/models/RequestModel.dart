class RequestModel {
  final String name;
  final String location;
  final String rating;
  final String price;
  final String desc;

  RequestModel({
    required this.name,
    required this.location,
    required this.rating,
    required this.price,
    required this.desc,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      rating: json['rating'] ?? '',
      price: json['price'] ?? '',
      desc: json['desc'] ?? '',
    );
  }
}