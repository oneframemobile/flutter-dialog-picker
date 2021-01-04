import 'package:dialog_picker/model/dialog_picker_data_model.dart';

class ListHelper {
  static Future<List<String>> getStringList() async {
    List<String> listDataSource = new List();
    listDataSource.add("Cherry");
    listDataSource.add("Apricots");
    listDataSource.add("Banana");
    listDataSource.add("Blueberry");
    listDataSource.add("Orange");
    listDataSource.add("Apple");
    listDataSource.add("Grapes");
    listDataSource.add("Guava");
    return listDataSource;
  }

  static Future<List<DialogPickerDataModel>> getObjectList() async {
    List<DialogPickerDataModel> listDataSource = new List();
    listDataSource.add(new DialogPickerDataModel(0, "Cherry", "Cherry", false));
    listDataSource.add(new DialogPickerDataModel(1, "Apricots", "Cherry", false));
    listDataSource.add(new DialogPickerDataModel(2, "Banana", "Cherry", false));
    listDataSource.add(new DialogPickerDataModel(3, "Blueberry", "Cherry", false));
    listDataSource.add(new DialogPickerDataModel(4, "Orange", "Cherry", false));
    listDataSource.add(new DialogPickerDataModel(5, "Cherry", "Cherry", false));
    listDataSource.add(new DialogPickerDataModel(6, "Apple", "Cherry", false));
    listDataSource.add(new DialogPickerDataModel(7, "Grapes", "Cherry", false));
    listDataSource.add(new DialogPickerDataModel(8, "Guava", "Cherry", false));
    return listDataSource;
  }
}
