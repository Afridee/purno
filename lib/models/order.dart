import 'customer.dart'; // Assuming the Customer model is in this file

class Order {
  final String orderId;
  final double totalAmount;
  final String status; // e.g., "Fulfilled", "Pending", "Returned"
  final Customer customer; // Using the Customer model here
  final String paymentMethod; // e.g., "Card", "Cash"
  final String cardDetails; // e.g., "**** 0141"
  final String cardNetwork; // e.g., "MasterCard", "Visa"
  final String posMachineUsed; // e.g., "BRAC Bank POS"
  final String fulfillmentType; // e.g., "Delivery", "Pickup"
  final String fulfilledBy; // e.g., "PandaGo"
  final DateTime orderPlacedAt;
  final DateTime? fulfilledAt; // Optional
  final String? deliveryLocation; // Optional
  final List<OrderProduct> products; // List of products in the order
  final double discount;
  final double transactionFee;
  final double netPayable;

  Order({
    required this.orderId,
    required this.totalAmount,
    required this.status,
    required this.customer,
    required this.paymentMethod,
    required this.cardDetails,
    required this.cardNetwork,
    required this.posMachineUsed,
    required this.fulfillmentType,
    required this.fulfilledBy,
    required this.orderPlacedAt,
    this.fulfilledAt,
    this.deliveryLocation,
    required this.products,
    required this.discount,
    required this.transactionFee,
    required this.netPayable,
  });

  // Convert JSON to Order object
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      totalAmount: json['totalAmount'].toDouble(),
      status: json['status'],
      customer: Customer.fromJson(json['customer']), // Parse customer JSON
      paymentMethod: json['paymentMethod'],
      cardDetails: json['cardDetails'],
      cardNetwork: json['cardNetwork'],
      posMachineUsed: json['posMachineUsed'],
      fulfillmentType: json['fulfillmentType'],
      fulfilledBy: json['fulfilledBy'],
      orderPlacedAt: DateTime.parse(json['orderPlacedAt']),
      fulfilledAt: json['fulfilledAt'] != null
          ? DateTime.parse(json['fulfilledAt'])
          : null,
      deliveryLocation: json['deliveryLocation'],
      products: (json['products'] as List)
          .map((productJson) => OrderProduct.fromJson(productJson))
          .toList(),
      discount: json['discount'].toDouble(),
      transactionFee: json['transactionFee'].toDouble(),
      netPayable: json['netPayable'].toDouble(),
    );
  }

  // Convert Order object to JSON
  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'totalAmount': totalAmount,
      'status': status,
      'customer': customer.toJson(), // Serialize customer object
      'paymentMethod': paymentMethod,
      'cardDetails': cardDetails,
      'cardNetwork': cardNetwork,
      'posMachineUsed': posMachineUsed,
      'fulfillmentType': fulfillmentType,
      'fulfilledBy': fulfilledBy,
      'orderPlacedAt': orderPlacedAt.toIso8601String(),
      'fulfilledAt': fulfilledAt?.toIso8601String(),
      'deliveryLocation': deliveryLocation,
      'products': products.map((product) => product.toJson()).toList(),
      'discount': discount,
      'transactionFee': transactionFee,
      'netPayable': netPayable,
    };
  }
}


class OrderProduct {
  final String productName;
  final String category; // e.g., "Fruits & Vegetables"
  final double price;
  final double quantity; // In kg or pieces
  final String unitType; // "kg" or "pieces"

  OrderProduct({
    required this.productName,
    required this.category,
    required this.price,
    required this.quantity,
    required this.unitType,
  });

  // Convert JSON to OrderProduct object
  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      productName: json['productName'],
      category: json['category'],
      price: json['price'].toDouble(),
      quantity: json['quantity'].toDouble(),
      unitType: json['unitType'],
    );
  }

  // Convert OrderProduct object to JSON
  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'category': category,
      'price': price,
      'quantity': quantity,
      'unitType': unitType,
    };
  }
}
