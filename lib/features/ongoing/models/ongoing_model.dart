class CarOnModel {
  final String id;
  final String ownerId;
  final String brand;
  final String model;
  final String maxSpeed;
  final String imageUrl;
  final String transmission;
  final String price;
  final String availability;
  final bool isPaid;

  CarOnModel({
    required this.id,
    required this.ownerId,
    required this.brand,
    required this.model,
    required this.maxSpeed,
    required this.imageUrl,
    required this.transmission,
    required this.price,
    required this.availability,
    required this.isPaid,
  });

  factory CarOnModel.fromJson(Map<String, dynamic> json) {
    return CarOnModel(
      id: json['licensePlate'] ?? '',
      ownerId: json['id'] ?? '',
      brand: json['brand'] ?? '',
      model: json['model'] ?? '',
      transmission: json['transmission'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      maxSpeed: json['maxSpeed'] ?? '',
      price: json['price'] ?? '',
      availability: json['availability'] ?? '',
      isPaid: json['isPaid'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ownerId': ownerId,
      'brand': brand,
      'model': model,
      'transmission': transmission,
      'imageUrl': imageUrl,
      'maxSpeed': maxSpeed,
      "price": price,
      "availability": availability,
      "isPaid": isPaid,
    };
  }
}
