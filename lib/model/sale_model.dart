class Sale{
  final int? id;
  final int? customerId;
  final String customerName;
  final double? total;
  final DateTime? createdAt;

  Sale({required this.id, required this.customerId, required this.customerName, required this.total , this.createdAt});

  factory Sale.fromJson(Map<String, dynamic> json) =>Sale(
      id: json['id'], customerId: json['customerId'], customerName: json['customerName'], total: double.parse(json['total'].toString()) , createdAt: json['createdAt']
  );

  Map<String,dynamic> toJson()=>{
    'id':id,
    'customerId': customerId,
    'customerName': customerName,
    'total': total,
    'createdAt': createdAt,
  };
}