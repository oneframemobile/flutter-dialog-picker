class DialogPickerDataModel {
  int id;
  String title;
  String identity;
  bool isSelected = false;

  DialogPickerDataModel(int id, String title, String identity, bool isSelected) {
    this.id = id;
    this.title = title;
    this.identity = identity;
    this.isSelected = isSelected;
  }

  DialogPickerDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    identity = json['identity'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['identity'] = this.identity;
    data['isSelected'] = this.isSelected;
    return data;
  }
}
