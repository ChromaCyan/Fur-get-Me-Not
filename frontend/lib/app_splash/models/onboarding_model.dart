class OnBoards {
  final String text, image;

  OnBoards({required this.text, required this.image});
}

List<OnBoards> onBoardData = [
  OnBoards(
    text: "Welcome to Fur-get-Me-Not!\nYour solid partner in pet adoption.",
    image: "images/fur_get_me_not_color_only.png",
  ),
  OnBoards(
    text: "Become an Adopter and look for your first or next\nfurry companion, listed for adoption by an adoptee.\n\nOr become an Adoptee and list your\nfurbaby for adoption to be adopted by adopters",
    image: "images/adopter_adoptee.png",
  ),
  OnBoards(
    text: "Adopters and Adoptees may chat\nand communicate with each other for\na further connection and for a smoother transaction.",
    image: "images/chat_splash.png",
  ),
];
