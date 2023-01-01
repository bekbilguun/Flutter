class Products{
  final int? id;
  final String name;
  final String barcode;

  const Products({required this.name, required this.barcode, required this.id });

  factory Products.fromJson(Map<String, dynamic> json) =>Products(
      name: json['name'], barcode: json['barcode'], id: json['id']
  );

  Map<String,dynamic> toJson()=>{
    'id':id,
    'name': name,
    'barcode': barcode
  };
}