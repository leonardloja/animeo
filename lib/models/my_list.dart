class MyList {
  MyList({
    required this.id,
    required this.name,
    required this.releasedDate,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String releasedDate;
  final String imageUrl;

  factory MyList.fromJson(Map<String, dynamic> json) => MyList(
        id: json['id'] as String,
        name: json['name'] as String,
        releasedDate: json['releasedDate'] as String,
        imageUrl: json['imageUrl'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'releasedDate': releasedDate,
        'imageUrl': imageUrl,
      };
}
