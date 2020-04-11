import './addressmodel.dart';
import './socialmediamodel.dart';

class CardModel {
  String name, designation, company, phone, email;
  AddressModel address;
  SocialMediaModel socialMediaModel;

  CardModel(
      {this.name,
      this.designation,
      this.company,
      this.phone,
      this.email,
      this.address,
      this.socialMediaModel});

  Map<String, dynamic> toJson() {
    Map address = this.address != null ? this.address.toJson() : null;
    Map socialMediaModel =
        this.socialMediaModel != null ? this.socialMediaModel.toJson() : null;

    return {
      'name': name,
      'designation': designation,
      'company': company,
      'phone': phone,
      'email': email,
      'address': address,
      'socialMediaModel': socialMediaModel,
    };
  }
}
