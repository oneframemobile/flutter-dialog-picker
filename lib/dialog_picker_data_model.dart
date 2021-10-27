class DialogPickerDataModel {
  final num id;
  final String title;
  bool isSelected;

  DialogPickerDataModel({
    required this.id,
    required this.title,
    required this.isSelected,
  });

  @override
  bool operator ==(Object other) => identical(this, other) || other is DialogPickerDataModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
