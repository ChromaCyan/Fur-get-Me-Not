class CarouselItem {
  final String text;
  final String image;

  CarouselItem({
    required this.text,
    required this.image,
  });
}

List<CarouselItem> carouselData = [
  CarouselItem(
    text: 'Find a feline to adopt and take home!',
    image: 'images/image2.png',
  ),
  CarouselItem(
    text: 'Chat and communicate with adoption shelters!',
    image: 'images/image1.png',
  ),
  CarouselItem(
    text: 'You should adopt a pet now!',
    image: 'images/image3.png',
  ),
];
