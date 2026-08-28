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

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      name: json['name']?.toString() ?? '',
      role: json['role']?.toString() ??
          json['category']?.toString() ??
          json['service']?.toString() ??
          '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ??
          json['phoneNumber']?.toString() ??
          '',
      rating: json['rating']?.toString() ??
          json['averageRating']?.toString() ??
          '0',
      reviews: json['reviews']?.toString() ??
          json['totalReviews']?.toString() ??
          '0',
      location: json['location']?.toString() ??
          json['address']?.toString() ??
          '',
      profileImage: json['profileImage']?.toString() ??
          json['profile_image']?.toString() ??
          json['image']?.toString() ??
          'assets/images/profile.png',
      jobsDone: json['jobsDone']?.toString() ??
          json['completedJobs']?.toString() ??
          json['total_jobs']?.toString() ??
          '0',
    );
  }

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
