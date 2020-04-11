class AddressModel {
  String street;
  String city;
  String state;
  String country;
  String zipcode;

  AddressModel(
      {this.street, this.city, this.state, this.country, this.zipcode});

  Map toJson() => {
        'street': street,
        'city': city,
        'state': state,
        'country': country,
        'phone': zipcode
      };
}
