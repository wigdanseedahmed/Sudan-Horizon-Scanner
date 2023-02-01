class ProfileModel {
  String? name;
  String? username;
  String? jobTitle;
  String? DOB;
  String? titleLine;
  String? about;

  ProfileModel(
      {this.DOB,
      this.about,
      this.name,
      this.jobTitle,
      this.titleLine,
      this.username});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        DOB: json['DOB'] as String,
        about: json['about'] as String,
        name: json['name'] as String,
        jobTitle: json['profession'] as String,
        titleLine: json['titleline'] as String,
        username: json['username'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'username': username,
        'profession': jobTitle,
        'DOB': DOB,
        'titleline': titleLine,
        'about': about,
      };
}
