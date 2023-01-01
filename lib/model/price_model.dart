class Prices{
  final int? id;
  final String customerId;
  final String productId;
  final String  price;

  const Prices({required this.id, required this.customerId, required this.productId, required this.price });

  factory Prices.fromJson(Map<String, dynamic> json) =>Prices(
      id: json['id'], customerId: json['customerId'], productId: json['productId'], price: json['price']
  );

  Map<String,dynamic> toJson()=>{
    'id':id,
    'customerId': customerId,
    'productId': productId,
    'price': price
  };
}