class OnBoardingContent {
  final String title;
  final String imageUrl;
  final String text;

  OnBoardingContent(
      {required this.title, required this.imageUrl, required this.text});
}

List<OnBoardingContent> pages = [
  OnBoardingContent(
      title: "Clean and Convenient",
      imageUrl: 'assets/animations/car3.json',
      text:
          "Tired of dirty and overloaded taxis, Get your Clean and comfortable ride with Simbula"),
  OnBoardingContent(
      title: "Elevate your status",
      imageUrl: 'assets/animations/car4.json',
      text: "Rent the car of your dreams and chill with the big boys."),
  OnBoardingContent(
      title: "Security Emphasis",
      imageUrl: 'assets/animations/car2.json',
      text:
          "We bring the free chill life to your doorstep and the most affordable prices"),
];
