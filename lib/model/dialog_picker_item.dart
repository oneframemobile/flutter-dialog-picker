class DialogPickerItem {
  int index;
  String title;
  String key;
  bool isSelected = false;

  DialogPickerItem({int index, String title, String key, bool isSelected}) {
    this.index = index;
    this.title = title;
    this.key = key;
    this.isSelected = isSelected;
  }

  DialogPickerItem.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    title = json['title'];
    key = json['key'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['title'] = this.title;
    data['key'] = this.key;
    data['isSelected'] = this.isSelected;
    return data;
  }
}
