class AddressData {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final GeoData geo;

  AddressData(
      {required this.street,
      required this.suite,
      required this.city,
      required this.zipcode,
      required this.geo});

  factory AddressData.fromJson(Map<String, dynamic> json) {
    return AddressData(
      street: json['street'],
      suite: json['suite'],
      city: json['city'],
      zipcode: json['zipcode'],
      geo: GeoData.fromJson(json['geo']),
    );
  }
}

class GeoData {
  final String lat;
  final String lng;

  GeoData({required this.lat, required this.lng});

  factory GeoData.fromJson(Map<String, dynamic> json) {
    return GeoData(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}

class CompanyData {
  final String name;
  final String catchPhrase;
  final String bs;

  CompanyData(
      {required this.name, required this.catchPhrase, required this.bs});

  factory CompanyData.fromJson(Map<String, dynamic> json) {
    return CompanyData(
      name: json['name'],
      catchPhrase: json['catchPhrase'],
      bs: json['bs'],
    );
  }
}

class UserData {
  final int id;
  final String name;
  final String username;
  final String email;
  final AddressData address;
  final String phone;
  final String website;
  final CompanyData company;
  bool isFavorite;

  UserData({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
    this.isFavorite = false,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      address: AddressData.fromJson(json['address']),
      phone: json['phone'],
      website: json['website'],
      company: CompanyData.fromJson(json['company']),
    );
  }
}
