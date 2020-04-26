class SocialMediaModel {
  String linkedin, facebook, github;

  SocialMediaModel({this.linkedin, this.facebook, this.github});

  Map toJson() =>
      {'linkedin': linkedin, 'facebook': facebook, 'github': github};
}
