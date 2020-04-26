import './addressmodel.dart';
import './socialmediamodel.dart';

class CardModel {
  String firstname, lastname, position, company, phoneno, email;
  AddressModel address;
  SocialMediaModel socials;

  CardModel(
      {this.firstname,
      this.lastname,
      this.position,
      this.company,
      this.phoneno,
      this.email,
      this.address,
      this.socials});

  CardModel.fromJson(Map<String, dynamic> json)
      : firstname = json['first_name'],
        lastname = json['last_name'],
        position = json['position'],
        company = json['company'],
        phoneno = json['phone_no'],
        email = json['email'],
        address = new AddressModel(
            addr1: json['address']['addr1'],
            addr2: json['address']['addr2'],
            city: json['address']['city'],
            country: json['address']['country'],
            state: json['address']['state'],
            zip: json['address']['zip']),
        socials = new SocialMediaModel(
            linkedin: json['socials']['linkedin'],
            facebook: json['socials']['facebook'],
            github: json['socials']['github']);

  Map<String, dynamic> toJson() {
    Map address = this.address != null ? this.address.toJson() : null;
    Map socials = this.socials != null ? this.socials.toJson() : null;

    return {
      'first_name': firstname,
      'last_name': lastname,
      'position': position,
      'company': company,
      'phone_no': phoneno,
      'email': email,
      'address': address,
      'socials': socials,
    };
  }
}
