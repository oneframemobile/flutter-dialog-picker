import 'package:dialog_picker/widgets/circle_checkbox_list_tile.dart';
import 'package:dialog_picker/model/dialog_picker_data_model.dart';
import 'package:dialog_picker/dialog_picker_style.dart';
import 'package:flutter/material.dart';

class DialogPicker<T> extends StatefulWidget {
  final String? title;
  final List<T> dataSource;
  final List<T>? selected;
  final Function(List<T> selected) onCompletion;
  final VoidCallback onCancel;
  final bool allowMultipleSelection;
  final bool allowSearchBarFilter;
  final DialogPickerStyle? style;
  final IconData? errorIcon;
  final String? errorDescription;
  final TextStyle? errorDescriptionStyle;
  final double? avatarRadiusSize;
  final String? cancelBtn;
  final String? okBtn;

  static DialogPicker<DialogPickerDataModel> builder({
    Key? key,
    String? title,
    required List<DialogPickerDataModel> dataSource,
    required Function(List<DialogPickerDataModel> selected) onCompletion,
    required VoidCallback onCancel,
    bool allowMultipleSelection = true,
    bool allowSearchBarFilter = true,
    DialogPickerStyle? style,
  }) =>
      DialogPicker._internal(
        key: key,
        title: title,
        dataSource: dataSource,
        onCompletion: onCompletion,
        onCancel: onCancel,
        allowMultipleSelection: allowMultipleSelection,
        allowSearchBarFilter: allowSearchBarFilter,
        style: style,
      );

  static DialogPicker<T> custom<T>(
          {Key? key,
          String? title,
          required List<T> dataSource,
          List<T> selected = const [],
          required Function(List<T> selected) onCompletion,
          required VoidCallback onCancel,
          bool allowMultipleSelection = true,
          bool allowSearchBarFilter = true,
          DialogPickerStyle? style,
          IconData? errorIcon,
          String? errorDescription,
          TextStyle? errorDescriptionStyle,
          double? avatarRadiusSize,
          String cancelBtn = "Kapat",
          String okBtn = "Tamam"}) =>
      DialogPicker._internal(
          key: key,
          title: title,
          dataSource: dataSource,
          selected: !allowMultipleSelection && selected.length > 1
              ? [selected.first]
              : selected,
          onCompletion: onCompletion,
          onCancel: onCancel,
          allowMultipleSelection: allowMultipleSelection,
          allowSearchBarFilter: allowSearchBarFilter,
          style: style,
          errorIcon: errorIcon,
          errorDescription: errorDescription,
          errorDescriptionStyle: errorDescriptionStyle,
          avatarRadiusSize: avatarRadiusSize,
          cancelBtn: cancelBtn,
          okBtn: okBtn);

  const DialogPicker._internal(
      {Key? key,
      this.title,
      required this.dataSource,
      this.selected,
      required this.onCompletion,
      required this.onCancel,
      required this.allowMultipleSelection,
      required this.allowSearchBarFilter,
      this.style,
      this.errorIcon,
      this.errorDescription,
      this.errorDescriptionStyle,
      this.avatarRadiusSize,
      this.cancelBtn,
      this.okBtn})
      : super(key: key);

  @override
  State<DialogPicker<T>> createState() => DialogPickerState<T>();
}

class DialogPickerState<T> extends State<DialogPicker<T>> {
  final _controller = TextEditingController();
  late List<T> _dataSource;
  late List<T> _filtered;
  late List<T>? _selected;
  bool _isLoading = false;

  @override
  void initState() {
    _dataSource = List.from(widget.dataSource);
    _filtered = List.from(widget.dataSource);
    _selected = widget.selected == null ? null : List.from(widget.selected!);
    super.initState();
  }

  bool _isSelected(T item) {
    if (item is DialogPickerDataModel) {
      return item.isSelected;
    } else {
      return _selected!.contains(item);
    }
  }

  String _title(T item) {
    if (item is DialogPickerDataModel) {
      return item.title;
    } else {
      return item.toString();
    }
  }

  void _toggle(T item) {
    if (!widget.allowMultipleSelection) {
      if (item is DialogPickerDataModel) {
        final list = _dataSource as List<DialogPickerDataModel>;
        for (var element in list) {
          element.isSelected = false;
        }
      } else {
        _selected!.clear();
      }
    }

    if (item is DialogPickerDataModel) {
      item.isSelected = !item.isSelected;
    } else {
      final removed = _selected!.remove(item);
      if (!removed) {
        _selected!.add(item);
      }
    }
  }

  void _filter() {
    setState(() {
      final search = _controller.value.text.trim().toLowerCase();
      if (search.isEmpty) {
        _filtered = _dataSource.toList();
      } else {
        _filtered = _dataSource
            .where(
                (element) => _title(element).toLowerCase().contains(search))
            .toList();
      }
    });
  }

  List<T> _selections() =>
      _dataSource.where((element) => _isSelected(element)).toList();

  @override
  Widget build(BuildContext context) {
    final style = widget.style;
    final system = Theme.of(context);

    return Dialog(
      backgroundColor:
          style?.backgroundColor ?? system.dialogTheme.backgroundColor,
      elevation: style?.elevation ?? system.dialogTheme.elevation,
      shape: style?.shape ?? system.dialogTheme.shape,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.title != null)
            Container(
              decoration: BoxDecoration(
                  color: style?.headerColor ?? system.colorScheme.primary),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: Text(
                widget.title!,
                style:
                    style?.titleTextStyle ?? system.dialogTheme.titleTextStyle,
              ),
            ),
          if (widget.allowSearchBarFilter)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _controller,
                onChanged: (_) => _filter(),
                style: style?.searchTextStyle,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: style?.iconColor?.withOpacity(.05),
                  border:
                      const UnderlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      const UnderlineInputBorder(borderSide: BorderSide.none),
                  prefixIcon: Icon(
                    Icons.search,
                    color: style?.iconColor ?? system.iconTheme.color,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: style?.iconColor ?? system.iconTheme.color,
                    ),
                    onPressed: () {
                      _controller.text = "";
                      _filter();
                    },
                  ),
                ),
              ),
            ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filtered.isEmpty
                    ? Center(child: dataSourceEmpty(system, style))
                    : ListView.builder(
                        itemCount: _filtered.length,
                        itemBuilder: (contex, index) {
                          final item = _filtered.elementAt(index);
                          return Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: itemRow(item, system, style),
                          );
                        },
                      ),
          ),
          Divider(
              color: style == null
                  ? null
                  : ThemeData(brightness: widget.style!.brightness)
                      .iconTheme
                      .color
                      ?.withOpacity(0.2)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text(
                  widget.cancelBtn!,
                  style: style?.buttonTheme ?? system.textTheme.button,
                ),
                onPressed: widget.onCancel,
              ),
              TextButton(
                child: Text(widget.okBtn!),
                onPressed: () {
                  final selections = _selections();
                  widget.onCompletion(selections);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemRow(item, system, style) {
    double avatarSize =
        widget.avatarRadiusSize != null ? widget.avatarRadiusSize! : 18;

    return Row(
      children: [
        item.imageUrl != null && item.imageUrl.isNotEmpty
            ? CircleAvatar(
                backgroundColor: Colors.grey,
                radius: avatarSize,
                child: ClipOval(
                  child: Image.network(
                    item.imageUrl!,
                    fit: BoxFit.cover,
                    width: avatarSize * 2,
                    height: avatarSize * 2,
                  ),
                ),
              )
            : Container(
                margin: EdgeInsets.fromLTRB(
                    widget.avatarRadiusSize != null
                        ? widget.avatarRadiusSize! * 2
                        : 0, 0, 0, 0),
              ),
        Expanded(
            child: CircleCheckboxListTile(
            activeColor: widget.style != null ? system.colorScheme.primary : null,
            fillColor: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return system.colorScheme.primary;
              }

              return ThemeData(brightness: style?.brightness ?? system.brightness)
                  .iconTheme
                  .color!; // the color when checkbox is selected;
            }),
            title: Text(
              _title(item),
              style: style?.contentTextStyle != null
                  ? system.textTheme.bodyText1!.merge(style!.contentTextStyle)
                  : system.dialogTheme.contentTextStyle,
            ),
            value: _isSelected(item),
            onChanged: (value) => setState(() => _toggle(item)),
        ))
      ],
    );
  }

  Widget dataSourceEmpty(system, style) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(widget.errorIcon),
        Text(
          widget.errorDescription != null
              ? widget.errorDescription!
              : "Oops! Something went wrong.",
          style: widget.errorDescriptionStyle != null
              ? system.textTheme.bodyText1!.merge(widget.errorDescriptionStyle)
              : system.dialogTheme.contentTextStyle
        )
      ],
    );
  }

  void update(List<T> newSource) {
    setState(() {
      _dataSource = newSource;
      _filter();
    });
  }

  void startLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  void stopLoading() {
    setState(() {
      _isLoading = false;
    });
  }
}
