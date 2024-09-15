class OnBoards {
  final String text, image;

  OnBoards({required this.text, required this.image});
}

List<OnBoards> onBoardData = [
  OnBoards(
    text: 'This app helps pet owners keep track of their pets \n care routines—like medical records, \n vaccination schedules',
    image: "images/image1.png",
  ),
  OnBoards(
    text: "You can also find a feline to take home and adopt \n from our adoption list.",
    image: "images/image2.png",
  ),
  OnBoards(
    text: "We show the easy way to adopt pet. \nJust stay at home with us.",
    image: "images/image3.png",
  ),
];