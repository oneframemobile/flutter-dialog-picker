class DialogPickerDataModel {
  late final num id;
  late final String title;
  late bool isSelected;
  late final String imageUrl;

  DialogPickerDataModel({
    required this.id,
    required this.title,
    required this.isSelected,
    required this.imageUrl,
  });

  DialogPickerDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ?? "";
    imageUrl = json['imageUrl'] ?? "";
    isSelected = json['isSelected'] ?? false;
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is DialogPickerDataModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
