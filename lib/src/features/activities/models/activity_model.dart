class ActivityModel {
  const ActivityModel({
    required this.id,
    required this.name,
    required this.iconCodePoint,
    required this.iconFontFamily,
    this.iconFontPackage,
    required this.type,
    this.uid,
  });

  final String id;
  final String name;
  final int iconCodePoint;
  final String iconFontFamily;
  final String? iconFontPackage;
  final String type;
  final String? uid;

  factory ActivityModel.fromMap(String id, Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data');
    }

    return ActivityModel(
      id: id,
      name: data['name'],
      iconCodePoint: data['iconCodePoint'],
      iconFontFamily: data['iconFontFamily'],
      iconFontPackage: data['iconFontPackage'],
      type: data['type'],
      uid: data['uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'iconCodePoint': iconCodePoint,
      'iconFontFamily': iconFontFamily,
      'iconFontPackage': iconFontPackage,
      'type': type,
      'uid': uid,
    };
  }
}
