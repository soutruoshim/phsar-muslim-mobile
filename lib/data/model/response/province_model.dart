class Province {
  String? id;
  String? type;
  String? code;
  String? khmerName;
  String? name;

  Province({this.id, this.type, this.code, this.khmerName, this.name});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    code = json['code'];
    khmerName = json['khmer_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['code'] = this.code;
    data['khmer_name'] = this.khmerName;
    data['name'] = this.name;
    return data;
  }
}