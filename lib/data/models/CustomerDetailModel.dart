

class CustomerDetailModel {
  final String name;
  final String subCategory;
  final String description;
  final String amount;
  final String date;
  final String time;
  final String location;
  final List<String> images;

  CustomerDetailModel({
    required this.name,
    required this.subCategory,
    required this.description,
    required this.amount,
    required this.date,
    required this.time,
    required this.location,
    required this.images,
  });

  factory CustomerDetailModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailModel(
      name: json['name'] ?? '',
      subCategory: json['sub_category'] ?? '',
      description: json['description'] ?? '',
      amount: json['amount'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      location: json['location'] ?? '',
      images: List<String>.from(json['images'] ?? []),
    );
  }
}