class AddressModel {
  String addr1;
  String addr2;
  String city;
  String state;
  String country;
  int zip;

  AddressModel(
      {this.addr1, this.addr2, this.city, this.state, this.country, this.zip});

  Map toJson() => {
        'addr1': addr1,
        'addr2': addr2,
        'city': city,
        'state': state,
        'country': country,
        'zip': zip
      };
}
