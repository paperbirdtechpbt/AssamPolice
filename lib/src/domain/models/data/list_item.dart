class ListItem {
  ListItem({
    required this.icon,
    required this.name,
  });

  ListItem.fromMap(dynamic json) {
    icon = json['icon'];
    name = json['name'];
  }

  String? icon;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['icon'] = icon;
    map['name'] = name;
    return map;
  }
}
