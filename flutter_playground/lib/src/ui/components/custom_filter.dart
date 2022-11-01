import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_button_lhaka.dart';

class CustomFilter extends StatefulWidget {
  final Color color;
  final List<FilterItem>? items;
  final Function(List<int>)? onTap;

  ///==========Custom Filter==========
  ///
  ///Grupo 1 Semana 2
  ///
  ///Integrantes:
  ///
  ///- Reynaga, Rodrigo
  ///
  ///- Paz Gerez, Leonel
  ///
  ///- Soriano, Maximiliano
  ///
  ///
  /// Crea un widget que muestra una lista de elementos con switch que pueden activarse y deseactivarse y devuelve una lista de los elementos activados.
  ///
  /// Recibe una lista del modelo FilterItem en el parametro items.
  /// Puede definir color por medio del parametro color y
  /// recibe una Funcion por medio del parametro onTap para manipular la lista de elementos activos.
  ///
  ///

  const CustomFilter(
      {Key? key, this.color = Colors.cyan, this.items, this.onTap})
      : super(key: key);

  @override
  State<CustomFilter> createState() => _CustomFilterState();
}

class _CustomFilterState extends State<CustomFilter> {
  ScrollController scrollController = ScrollController();
  List<int> actives = [];
  void getActiveFilters() {
    for (var element in widget.items!) {
      if (element.isActive) {
        actives.add(element.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(data: ThemeData(scrollbarTheme: const ScrollbarThemeData(
        thickness: MaterialStatePropertyAll(5),
        thumbColor: MaterialStatePropertyAll(Colors.transparent)
    )), child: _alertDialogCustom());
  }

  _alertDialogCustom() {
    return AlertDialog(
      title: _header(),
      titlePadding: const EdgeInsets.symmetric(horizontal: 35),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      icon: _buttonClose(),
      iconPadding: const EdgeInsets.only(top: 8, right: 8),
      content:
      SizedBox(
        height: 450,
        width: 300,
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return _listFilter(setState);
            }),
      ),
      contentPadding: const EdgeInsets.all(15),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 25),
      actions: [
        CustomButtonLhaka(
          backgroundColor: widget.color,
          text: 'Aceptar',
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
          onTap: () {
            getActiveFilters();
            widget.onTap!(actives);
            //Navigator.pop(context);
          },
        ),
      ],
    );
  }

  _buttonClose() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [CloseButton()],
    );
  }

  _header() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      child: const Padding(
        padding: EdgeInsets.only(bottom: 12.0),
        child: Text(
          'Filtros',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }

  _listFilter(StateSetter setState) {
    return RawScrollbar(
      controller: scrollController,
      thumbVisibility: true,
      thickness: 5,
      thumbColor: widget.color,
      trackVisibility: true,
      trackColor: Colors.grey,
      trackRadius: const Radius.circular(5),
      radius: const Radius.circular(5),
      child: ListView.builder(
          controller: scrollController,
          itemBuilder: (context, index) =>
              _cellFilter(widget.items![index], setState),
          itemCount: widget.items!.length),
    );
    // );
  }

  _cellFilter(FilterItem item, StateSetter setState) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Container(
        padding: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: item.iconBackgroundColor,
                  child: Icon(
                    item.icon,
                    size: 23,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  item.title,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            CupertinoSwitch(
                activeColor: widget.color,
                value: item.isActive,
                onChanged: (bool value) {
                  setState(() {
                    item.onChange();
                  });
                }),
          ],
        ),
      ),
    );
  }

}

class FilterItem {
  int id;
  String title;
  bool isActive;
  IconData icon;
  Color iconBackgroundColor;
  FilterItem(
      {required this.id,
        required this.title,
        required this.icon,
        this.isActive = false,
        this.iconBackgroundColor = Colors.lightGreenAccent});

  void onChange() {
    isActive = !isActive;
  }
}
