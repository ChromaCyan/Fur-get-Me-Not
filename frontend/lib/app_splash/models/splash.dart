class OnBoards {
  final String text, image;

  OnBoards({required this.text, required this.image});
}

List<OnBoards> onBoardData = [
  OnBoards(
    text: 'This app helps potential adopters find a \n feline to adopt and give it a  \n new home!',
    image: "images/image1.png",
  ),
  OnBoards(
    text: "You can also keep track of your adopted pets \n and view their special care instructions.",
    image: "images/image2.png",
  ),
];