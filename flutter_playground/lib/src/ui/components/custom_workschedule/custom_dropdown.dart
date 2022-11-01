// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_playground/src/models/work_area_model.dart';

// ignore: must_be_immutable
class DropdownCustom extends StatefulWidget {
  final List<WorkArea> items;
  final double paddingDropdown;
  final Color mainColor;
  late String textDropDown;
  final double dropdownMenuSize;
  final Function theSelected;
  final double height;
  final double widht;
  final double fontSize;
  final double iconSize;
  DropdownCustom({
    required this.items,
    this.textDropDown = "Seleccionar",
    this.mainColor = Colors.teal,
    this.paddingDropdown = 0,
    this.dropdownMenuSize = 150,
    required this.theSelected,
    this.height = 50,
    this.widht = 200,
    this.fontSize = 15,
    this.iconSize = 30,
  });

  @override
  State<DropdownCustom> createState() => _DropdownCustomState();
}

class _DropdownCustomState extends State<DropdownCustom> {
  @override
  Widget build(BuildContext context) {
    return _dropDown();
  }

  _dropDown() {
    return Container(
      padding: EdgeInsets.only(left: 10),
      height: widget.height,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: widget.mainColor, width: 2),
          borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.textDropDown,
            style: TextStyle(
              fontSize: widget.fontSize,
            ),
          ),
          IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.arrow_drop_down_sharp,
              size: widget.iconSize,
            ),
            onPressed: () {
              showDialog(
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (context) => _dropDownMenu());
            },
          ),
        ],
      ),
    );
  }

  Widget _dropDownMenu() {
    return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        content: Container(
          color: Colors.white,
          height: 200,
          width: widget.widht,
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 2, color: Colors.grey),
            itemCount: widget.items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        widget.theSelected(widget.items[index]);
                        widget.textDropDown = widget.items[index].name;
                      });
                    },
                    child: Text(widget.items[index].name)),
              );
            },
          ),
        ));
  }
}
