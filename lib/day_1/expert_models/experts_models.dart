import 'dart:convert';

class ExpertsModels {
  final String professionName;
  final String category;
  final String description; // Atribut Baru
  final String iconName; // Atribut Baru

  ExpertsModels({
    required this.professionName,
    required this.category,
    required this.description,
    required this.iconName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'profession_name': professionName,
      'category': category,
      'description': description,
      'icon_name': iconName,
    };
  }

  factory ExpertsModels.fromMap(Map<String, dynamic> map) {
    return ExpertsModels(
      professionName: map['profession_name'] as String? ?? 'Unknown',
      category: map['category'] as String? ?? 'General',
      description: map['description'] as String? ?? 'No description available.',
      iconName: map['icon_name'] as String? ?? 'work',
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpertsModels.fromJson(String source) =>
      ExpertsModels.fromMap(json.decode(source) as Map<String, dynamic>);
}
