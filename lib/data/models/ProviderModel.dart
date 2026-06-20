class ProviderModel {
  final String name;
  final String role;
  final String email;
  final String phone;
  final String rating;
  final String reviews;
  final String location;
  final String profileImage;
  final String jobsDone;

  ProviderModel({
    required this.name,
    required this.role,
    required this.email,
    required this.phone,
    required this.rating,
    required this.reviews,
    required this.location,
    required this.profileImage,
    required this.jobsDone,
  });

  ProviderModel copyWith({
    String? name,
    String? role,
    String? email,
    String? phone,
    String? rating,
    String? reviews,
    String? location,
    String? profileImage,
    String? jobsDone,
  }) {
    return ProviderModel(
      name: name ?? this.name,
      role: role ?? this.role,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      location: location ?? this.location,
      profileImage: profileImage ?? this.profileImage,
      jobsDone: jobsDone ?? this.jobsDone,
    );
  }
}
