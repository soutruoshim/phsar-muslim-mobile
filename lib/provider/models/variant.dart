class Variant {
  int? index;
  int? quantity;

  Variant({this.index, this.quantity});

  Variant.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['quantity'] = this.quantity;
    return data;
  }
}