import 'dart:convert';

class Mountain {
  final int id;
  final String name;
  final String category;
  final double rating;
  final String imageUrl;

  Mountain({
    required this.id,
    required this.name,
    required this.category,
    required this.rating,
    required this.imageUrl,
  });

  factory Mountain.fromJson(Map<String, dynamic> json) {
    return Mountain(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      rating: (json['rating'] as num).toDouble(),
      imageUrl: json['imageUrl'],
    );
  }
}

class MountainService {
  final List<Map<String, dynamic>> mounts = [
    {
      "id": 0,
      "name": "Lake Louise",
      "category": "Mountains",
      "rating": 4.3,
      "imageUrl":
          "https://images.pexels.com/photos/417074/pexels-photo-417074.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    },
    {
      "id": 1,
      "name": "Mount Norquay",
      "category": "Mountains",
      "rating": 4.4,
      "imageUrl":
          "https://images.pexels.com/photos/747964/pexels-photo-747964.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    },
    {
      "id": 2,
      "name": "Mount Yamnuska",
      "category": "Mountains",
      "rating": 4.5,
      "imageUrl":
          "https://images.pexels.com/photos/147411/italy-mountains-dawn-daybreak-147411.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    },
  ];

  List<Mountain> parseMounts(String responseBody) {
    final parsed = jsonDecode(responseBody) as List<dynamic>;

    return parsed
        .map((json) => Mountain.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<Mountain>> fetchMounts() async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network delay
    return parseMounts(jsonEncode(mounts));
  }
}