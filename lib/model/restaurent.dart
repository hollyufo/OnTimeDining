class Restaurant {
    int id;
  String name;
  String imageUrl;
  String address;
  double rating;

  Restaurant({this.id, this.name, this.imageUrl, this.address, this.rating});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      address: json['address'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image_url': imageUrl,
        'address': address,
        'rating': rating,
      };
}
