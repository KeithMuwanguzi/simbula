import 'package:some_ride/features/home/model/car.dart';

class CarService {
  List<Car> getCarList() {
    return <Car>[
      Car(
        "Land Rover",
        "Discovery",
        2580,
        "Weekly",
        [
          "assets/images/cars/land_rover_0.png",
          "assets/images/cars/land_rover_1.png",
          "assets/images/cars/land_rover_2.png",
        ],
      ),
      Car(
        "Alfa Romeo",
        "C4",
        3580,
        "Monthly",
        [
          "assets/images/cars/alfa_romeo_c4_0.png",
        ],
      ),
      Car(
        "Nissan",
        "GTR",
        1100,
        "Daily",
        [
          "assets/images/cars/nissan_gtr_0.png",
          "assets/images/cars/nissan_gtr_1.png",
          "assets/images/cars/nissan_gtr_2.png",
          "assets/images/cars/nissan_gtr_3.png",
        ],
      ),
      Car(
        "Acura",
        "MDX 2020",
        2200,
        "Monthly",
        [
          "assets/images/cars/acura_0.png",
          "assets/images/cars/acura_1.png",
          "assets/images/cars/acura_2.png",
        ],
      ),
      Car(
        "Chevrolet",
        "Camaro",
        3400,
        "Weekly",
        [
          "assets/images/cars/camaro_0.png",
          "assets/images/cars/camaro_1.png",
          "assets/images/cars/camaro_2.png",
        ],
      ),
      Car(
        "Ferrari",
        "Spider 488",
        4200,
        "Weekly",
        [
          "assets/images/cars/ferrari_spider_488_0.png",
          "assets/images/cars/ferrari_spider_488_1.png",
          "assets/images/cars/ferrari_spider_488_2.png",
          "assets/images/cars/ferrari_spider_488_3.png",
          "assets/images/cars/ferrari_spider_488_4.png",
        ],
      ),
      Car(
        "Ford",
        "Focus",
        2300,
        "Weekly",
        [
          "assets/images/cars/ford_0.png",
          "assets/images/cars/ford_1.png",
        ],
      ),
      Car(
        "Fiat",
        "500x",
        1450,
        "Weekly",
        [
          "assets/images/cars/fiat_0.png",
          "assets/images/cars/fiat_1.png",
        ],
      ),
      Car(
        "Honda",
        "Civic",
        900,
        "Daily",
        [
          "assets/images/cars/honda_0.png",
        ],
      ),
      Car(
        "Citroen",
        "Picasso",
        1200,
        "Monthly",
        [
          "assets/images/cars/citroen_0.png",
          "assets/images/cars/citroen_1.png",
          "assets/images/cars/citroen_2.png",
        ],
      ),
    ];
  }
}
