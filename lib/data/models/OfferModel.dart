class OfferModel {
  final String description;
  final int amount;
  final List<String> images;

  OfferModel({
    required this.description,
    required this.amount,
    required this.images,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      description: json['description']?.toString() ?? "",
      amount: int.tryParse(json['amount'].toString()) ?? 0,
      images: (json['images'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }

  OfferModel copyWith({
    String? description,
    int? amount,
    List<String>? images,
  }) {
    return OfferModel(
      description: description ?? this.description,
      amount: amount ?? this.amount,
      images: images ?? this.images,
    );
  }
}