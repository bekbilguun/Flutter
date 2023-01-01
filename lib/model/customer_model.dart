class Customers{
  final int? id;
  final String name;
  final String phone;

  const Customers({required this.name, required this.phone, required this.id });

  factory Customers.fromJson(Map<String, dynamic> json) =>Customers(
      name: json['name'], phone: json['phone'], id: json['id']
  );

  Map<String,dynamic> toJson()=>{
    'id':id,
    'name': name,
    'phone': phone
  };
}

