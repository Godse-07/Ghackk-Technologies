// class Webtoon {
//   final String title;
//   final String imageUrl;
//   final String description;
//   double rating;

//   Webtoon({
//     required this.title,
//     required this.imageUrl,
//     required this.description,
//     this.rating = 0.0,
//   });

// }

List<Webtoon> top50Manhwa = [
  Webtoon(
    title: 'Solo Leveling',
    imageUrl: 'assests/Solo.jpg',
    description: 'A world where hunters exist to hunt monsters.',
    rating: 4.8,
  ),
  Webtoon(
    title: 'Tower of God',
    imageUrl: 'assests/Tower.jpg',
    description: 'A boy embarks on a journey to ascend a mysterious tower.',
    rating: 4.7,
  ),
  Webtoon(
    title: 'The Beginning After The End',
    imageUrl: 'assests/The_Beginning_After_The_End.jpg',
    description: 'Reincarnated king Arthur Leywin fights for his loved ones.',
    rating: 4.6,
  ),
  Webtoon(
    title: 'Lore Olympus',
    imageUrl: 'assests/Lore_Olympus.jpg',
    description: 'A modern retelling of the myth of Hades and Persephone.',
    rating: 4.5,
  ),
  Webtoon(
    title: 'Omniscient Reader',
    imageUrl: 'assests/Omniscient_Reader.jpg',
    description: 'Kim Dokja finds himself in the middle of a story he\'s read.',
    rating: 4.4,
  ),
  Webtoon(
    title: 'Eleceed',
    imageUrl: 'assests/Eleceed.jpg',
    description:
        'Jiwoo, with his lightning reflexes, fights mysterious powers.',
    rating: 4.3,
  ),
  Webtoon(
    title: 'The God of High School',
    imageUrl: 'assests/The_God_of_High_School.jpg',
    description: 'High school students fight in a tournament to become gods.',
    rating: 4.2,
  ),
  Webtoon(
    title: 'Noblesse',
    imageUrl: 'assests/Noblesse.jpg',
    description: 'A noble vampire wakes up after centuries of slumber.',
    rating: 4.1,
  ),
  Webtoon(
    title: 'The Boxer',
    imageUrl: 'assests/The_Boxer.jpg',
    description: 'A boy with no emotions rises through the boxing world.',
    rating: 4.0,
  ),
  Webtoon(
    title: 'Hardcore Leveling Warrior',
    imageUrl: 'assests/Hardcore_Leveling_Warrior.jpg',
    description:
        'A top player faces challenges after losing everything in a VR game.',
    rating: 3.9,
  ),
  Webtoon(
    title: 'Unordinary',
    imageUrl: 'assests/Unordinary.jpg',
    description:
        'In a world where superpowers define status, John is powerless.',
    rating: 3.8,
  ),
  Webtoon(
    title: 'The Legendary Moonlight Sculptor',
    imageUrl: 'assests/The_Legendary_Moonlight_Sculptor.jpg',
    description: 'A young man plays a VR game to pay off his family\'s debt.',
    rating: 3.7,
  ),
  Webtoon(
    title: 'Bastard',
    imageUrl: 'assests/Bastard.jpg',
    description:
        'A high school student with a serial killer father tries to escape.',
    rating: 3.6,
  ),
  Webtoon(
    title: 'Sweet Home',
    imageUrl: 'assests/Sweet_Home.jpg',
    description: 'A loner teenager must fight against horrifying monsters.',
    rating: 3.5,
  ),
  Webtoon(
    title: 'Windbreaker',
    imageUrl: 'assests/Windbreaker.jpg',
    description: 'A high school biker gains notoriety in street racing.',
    rating: 3.4,
  ),
  Webtoon(
    title: 'Lookism',
    imageUrl: 'assests/Lookism.jpg',
    description: 'A bullied high schooler wakes up with a handsome new body.',
    rating: 3.3,
  ),
  Webtoon(
    title: 'The Gamer',
    imageUrl: 'assests/The_Gamer.jpg',
    description: 'A boy discovers his world has become a video game.',
    rating: 3.2,
  ),
  Webtoon(
    title: 'Cheese in the Trap',
    imageUrl: 'assests/Cheese_in_the_Trap.jpg',
    description:
        'A college student navigates the complexities of relationships.',
    rating: 3.1,
  ),
  Webtoon(
    title: 'True Beauty',
    imageUrl: 'assests/True_Beauty.jpg',
    description: 'A girl becomes famous for her beauty after learning makeup.',
    rating: 3.0,
  ),
  Webtoon(
    title: 'The Villainess Turns the Hourglass',
    imageUrl: 'assests/The_Villainess_Turns_the_Hourglass.jpg',
    description: 'Aria returns to the past to change her tragic future.',
    rating: 2.9,
  ),
  // Add 30 more webtoons similarly to complete the list
];

class Webtoon {
  final String title;
  final String description;
  final String imageUrl;
  final double rating;

  Webtoon({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'rating': rating,
    };
  }

  static Webtoon fromMap(Map<String, dynamic> map) {
    return Webtoon(
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      rating: map['rating'],
    );
  }
}
