class AddressModel {
  int? id;
  int? customerId;
  String? contactPersonName;
  String? addressType;
  String? address;
  String? city;
  String? zip;
  String? phone;
  String? createdAt;
  String? updatedAt;
  String? state;
  String? country;
  String? latitude;
  String? longitude;
  int? isBilling;
  String? guestId;
  String? email;

  AddressModel(
      {this.id,
        this.customerId,
        this.contactPersonName,
        this.addressType,
        this.address,
        this.city,
        this.zip,
        this.phone,
        this.createdAt,
        this.updatedAt,
        this.state,
        this.country,
        this.latitude,
        this.longitude,
        this.isBilling,
        this.guestId,
        this.email,
      });

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    contactPersonName = json['contact_person_name'];
    addressType = json['address_type'];
    address = json['address'];
    city = json['city'];
    zip = json['zip'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    state = json['state'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isBilling = json['is_billing'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['contact_person_name'] = contactPersonName;
    data['address_type'] = addressType;
    data['address'] = address;
    data['city'] = city;
    data['zip'] = zip;
    data['phone'] = phone;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['state'] = state;
    data['country'] = country;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['is_billing'] = isBilling;
    data['guest_id'] = guestId;
    data['email'] = email;
    return data;
  }
}

class District {
  String? id;
  String? type;
  String? code;
  String? khmerName;
  String? name;
  String? provinceId;

  District(
      {this.id,
        this.type,
        this.code,
        this.khmerName,
        this.name,
        this.provinceId});

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    code = json['code'];
    khmerName = json['khmer_name'];
    name = json['name'];
    provinceId = json['province_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['code'] = this.code;
    data['khmer_name'] = this.khmerName;
    data['name'] = this.name;
    data['province_id'] = this.provinceId;
    return data;
  }
}

class Commune {
  String? id;
  String? type;
  String? code;
  String? khmerName;
  String? name;
  String? provinceId;
  String? districtId;

  Commune(
      {this.id,
        this.type,
        this.code,
        this.khmerName,
        this.name,
        this.provinceId,
        this.districtId});

  Commune.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    code = json['code'];
    khmerName = json['khmer_name'];
    name = json['name'];
    provinceId = json['province_id'];
    districtId = json['district_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['code'] = this.code;
    data['khmer_name'] = this.khmerName;
    data['name'] = this.name;
    data['province_id'] = this.provinceId;
    data['district_id'] = this.districtId;
    return data;
  }
}