class CarModel {
  final String id;
  final String ownerId;
  final String brand;
  final String model;
  final String maxSpeed;
  final String imageUrl;
  final String transmission;
  final String price;
  final String availability;

  CarModel({
    required this.id,
    required this.ownerId,
    required this.brand,
    required this.model,
    required this.maxSpeed,
    required this.imageUrl,
    required this.transmission,
    required this.price,
    required this.availability,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['licensePlate'] ?? '',
      ownerId: json['id'] ?? '',
      brand: json['brand'] ?? '',
      model: json['model'] ?? '',
      transmission: json['transmission'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      maxSpeed: json['maxSpeed'] ?? '',
      price: json['price'] ?? '',
      availability: json['availability'] ?? '',
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
    };
  }
}
