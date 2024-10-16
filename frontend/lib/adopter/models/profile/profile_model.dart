class User {
  final String imagePath;
  final String name;
  final String role;
  final String bio;
  final String email;
  final String address;
  
  // final bool isDarkMode;

  const User({
    required this.imagePath,
    required this.name,
    required this.role,
    required this.bio,
    required this.email,
    required this.address,
    // required this.isDarkMode,
  });
}
// The data being displayed on the profile screen
class UserPreferences {
  static const myUser = User(
    imagePath:'images/bogart_the_explorer.jpg',
    name: 'Bogart the Explorer',
    role: 'Adopter',
    bio: 'Live to protect wild life.',
    email: "bugartdaexplorer@gmail.com",
    address: "Davao City, Davao del Sur",
  );
}