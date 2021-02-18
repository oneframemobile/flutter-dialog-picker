import 'package:dialog_picker/model/dialog_picker_item.dart';
import 'package:flutter/material.dart';

import 'notch_widget.dart';

class DialogPickerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DialogPickerWidgetState();
  final String title;
  List<String> dataSource;
  final Function(int, String) selected;

  DialogPickerWidget({
    Key key,
    this.title,
    this.dataSource,
    this.selected,
  }) : super(key: key);
}

class DialogPickerWidgetState extends State<DialogPickerWidget> with SingleTickerProviderStateMixin {
  List<DialogPickerItem> _dataSource;
  DialogPickerItem selectedItem;


  reloadData(List<String> dataSource) {
   /* setState(() {
      currentDataSource = ValueNotifier(dataSource);
    });*/
  }

  @override
  void initState() {
    super.initState();
    _dataSource = getConvertedData();
  }

  @override
  Widget build(BuildContext context) {
    return mainContent;
  }

  Widget get mainContent {
    return FractionallySizedBox(
      heightFactor: 1,
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: kToolbarHeight,
              ),
              NotchWidget(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  widget.title ?? "",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 4),
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  //controller: _profileViewModel.searchController,
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green.shade800, width: 1.0),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(24.0),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green.shade400, width: 1.0),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(24.0),
                      ),
                    ),
                    labelText: "Ara",
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                    isDense: true,
                  ),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (term) {
                    /* setState(() {
                    _profileViewModel.search(term);
                    if (_profileViewModel.citiesTmp.length != 0 && _profileViewModel.isCity) {
                      list = _profileViewModel.citiesTmp;
                    }
                    else if (_profileViewModel.counties.length != 0 && !_profileViewModel.isCity) {
                      list = _profileViewModel.countiesTmp;
                    }
                    else if(isCity){
                      list = _profileViewModel.cities;
                    }
                    else{
                      list = _profileViewModel.counties;
                    }
                  });*/
                  },
                ),
              ),
              Expanded(
                child: Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: _dataSource.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          /* if (!isMultiSelect) {
                          selected(index);
                        } else {
                          setState(() {
                            addSelectedList(index);
                          });
                        }*/

                          setState(() {
                            _dataSource.forEach((item) {
                              item.isSelected = false;
                            });
                            _dataSource[index].isSelected = !_dataSource[index].isSelected;
                            selectedItem = new DialogPickerItem(index: index, key: widget.dataSource[index], title: widget.dataSource[index], isSelected: true);
                          });
                        },
                        child: ListTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(widget.dataSource[index], style: TextStyle(color: Colors.white)),
                                  _dataSource[index].isSelected
                                      ? Icon(
                                          Icons.play_arrow,
                                          size: 16,
                                          color: Colors.white,
                                        )
                                      : Container()
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Container(
                                color: Colors.grey.shade800,
                                height: 1,
                              ),
                              SizedBox(
                                height: index == _dataSource.length - 1 ? 60 : 0,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.black,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        if (selectedItem != null) widget.selected(selectedItem.index, selectedItem.title);
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                        child: Text(
                          "Complete",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),
                        ),
                      ),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }

  List<DialogPickerItem> getConvertedData() {
    List<DialogPickerItem> dataSource = new List();
    for (int i = 0; i < widget.dataSource.length; i++) {
      dataSource.add(new DialogPickerItem(index: i, key: widget.dataSource[i], title: widget.dataSource[i], isSelected: false));
    }


    return dataSource;
  }
}
