class SaleProduct{
  final int? id;
  final int? saleId;
  final int? customerId;
  final int? productId;
  final String? productName;
  final double? price;
  final int? count;
  final double? total;

  const SaleProduct({required this.id, required this.saleId, required this.customerId, required this.productId, required this.productName ,required this.price , required this.count, required this.total});

  factory SaleProduct.fromJson(Map<String, dynamic> json) =>SaleProduct(
      id: json['id'], saleId: json ['saleId'],customerId: json['customerId'], productId: json['productId'], productName: json['productName'], price: double.parse(json['price'].toString()), count: json['count'], total: double.parse(json['total'].toString())
  );

  Map<String,dynamic> toJson()=>{
    'id':id,
    'saleId':saleId,
    'customerId': customerId,
    'productId': productId,
    'productName': productName,
    'price': price,
    'count': count,
    'total': total
  };
}