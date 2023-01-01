class Inner{
  final int? id;
  final String customerId;
  final String productId;
  final String price;
  final String name;
  final String phone;
  late int count = 0;
  late double total = 0;

  Inner({required this.id, required this.customerId, required this.productId, required this.price ,required this.name , required this.phone, required this.count, required this.total});

  factory Inner.fromJson(Map<String, dynamic> json) => Inner(
      id: json['id'], customerId: json['customerId'], productId: json['productId'], price: json['price'], name: json['name'], phone: json['phone'], count: 0, total: 0
  );

  Map<String,dynamic> toJson()=>{
    'id':id,
    'customerId': customerId,
    'productId': productId,
    'price': price,
    'name': name,
    'phone': phone
  };
}