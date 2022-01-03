class UserProfile {
  String? staffId;
  String? name;
  String? role;
  String? profile;

  UserProfile({
    this.staffId,
    this.name,
    this.role,
    this.profile,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
        staffId: json['staffId'],
        name: json['userName'],
        role: json['userRole'],
        profile: json['userImage']);
  }
}
