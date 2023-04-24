class Language {
  String name;
  String icon;

  Language({
    required this.name,
    required this.icon,
});
  factory Language.fromJson(Map<String,dynamic> json){
    return Language(
        name: json['name'],
        icon: json['icon']);
  }
}
