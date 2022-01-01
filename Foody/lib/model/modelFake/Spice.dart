class Spice {
  int id = 0;
  String name = '';
  double price = 0.0;
  bool selected = false;

  Spice(this.id, this.name, this.price);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['selected'] = this.selected;

    return data;
  }

  Spice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    selected = json['selected'];
  }

}