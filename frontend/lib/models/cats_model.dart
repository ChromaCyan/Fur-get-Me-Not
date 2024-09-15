import 'package:flutter/material.dart';
List<String> categories = [
  'Cats',
  'Dogs',
];

class Cat {
  final Color color;
  final String name, location, sex, image, description;
  final double age, weight;
  final bool fav;
  final Owner owner;

  Cat({
    required this.fav,
    required this.image,
    required this.color,
    required this.description,
    required this.name,
    required this.location,
    required this.sex,
    required this.age,
    required this.weight,
    required this.owner,
  });
}

List<Cat> cats = [
  Cat(
    fav: true,
    color: const Color(0xffffd690),
    name: 'Amber',
    description: desc,
    location: 'Thornridge, Chicago',
    sex: 'Male',
    age: 2.1,
    weight: 4.5,
    image: 'images/pet-cat2.png',
    owner: owners[0],
  ),
  Cat(
    fav: false,
    color: const Color(0xffcaeda1),
    name: 'Volderak the Elderich Horror',
    description: desc,
    location: 'Siak, Riau',
    sex: 'Male',
    age: 1.1,
    image: 'images/pet-cat2.png',
    weight: 2.2,
    owner: owners[1],
  ),
  Cat(
    fav: true,
    color: const Color(0xffa4e1ff),
    name: 'Cleo',
    image: 'images/pet-cat1.png',
    description: desc,
    location: 'Pekanbaru, Riau',
    sex: 'Male',
    age: 1.4,
    weight: 3.4,
    owner: owners[2],
  ),
  Cat(
    fav: true,
    color: const Color(0xfffa9191),
    image: 'images/pet-cat2.png',
    name: 'Milo',
    description: desc,
    location: 'Kampar, Riau',
    sex: 'Female',
    age: 1.1,
    weight: 3.2,
    owner: owners[0],
  ),
  Cat(
    fav: false,
    color: const Color(0xffffd690),
    name: 'Leo',
    description: desc,
    location: 'Dumai, Riau',
    sex: 'Male',
    age: 2.1,
    weight: 4.5,
    image: 'images/pet-cat1.png',
    owner: owners[0],
  ),
];
String desc =
    'This cat is a domestic species of small carnivorous mammal. It is the only domesticated species in the family Felidae and is often reffered to as the domestic cat to distinguish it from the wild members of the family. A cat can either be a house cat, a farm cat or a feral cat, the latter rangers freely and avoids human contacts. Domestic cats are valued by humans for companionship and their ability to kill redonts. About 60 cat breeds are recognized by various cat registries.';

class Owner {
  final String name, image;

  Owner({required this.name, required this.image});
}

List<Owner> owners = [
  Owner(
    name: 'Bogart Adoption',
    image: 'images/business_logo.png',
  ),
  Owner(
    name: 'Bogart Adoption',
    image: 'images/business_logo.png',
  ),
  Owner(
    name: 'Bogart Adoption',
    image: 'images/business_logo.png',
  ),
];