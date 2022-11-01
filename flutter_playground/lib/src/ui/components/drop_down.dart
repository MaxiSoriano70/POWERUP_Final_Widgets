// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../models/drop_down_info.dart';
///--- INFO ---
///
///Integrantes:
///             Fernández,  Carlos Agustín.
///
///             Coronel, Benjamin leonel.
///
///             Rodriguez, Esteban Ernesto.
///
/// Este widget tiene el propósito de mostrar información de un bingo como:
/// Día de sorteo, dias restantes, imagen, costo y detalles del mismo. El widget cuenta con la funcionalidad de seleccionar como favorito un bingo en específico. Cuenta con ExpansionTile para mostrar detalles del bingo. Tambien ocupa un DateTime para obtener una fecha y calcular los dias restantes.
///
/// El mismo recive un modelo (DropDownInfo) para poder encapsular la información.
///
/// Dependiendo de los parámetros especificados en el modelo la vista del widget será reducida a lo que especifique.
///
/// Limitaciones: Al contenerlo en una Row o Column, se debe envolver el widget en un SizedBox y especificar el ancho (width), sin especificar la altura (height). Las imágenes solo pueden ser especificadas por medio de un assets.

class DropDown extends StatefulWidget {
  DropDownInfo info;
  Function(bool isFavorite)? onFavoritismChange;
  ///--- INFO ---
  ///
  ///Integrantes:
  ///             Fernández,  Carlos Agustín.
  ///
  ///             Coronel, Benjamin leonel.
  ///
  ///             Rodriguez, Esteban Ernesto.
  ///
  /// Este widget tiene el propósito de mostrar información de un bingo como:
  /// Día de sorteo, dias restantes, imagen, costo y detalles del mismo. El widget cuenta con la funcionalidad de seleccionar como favorito un bingo en específico. Cuenta con ExpansionTile para mostrar detalles del bingo. Tambien ocupa un DateTime para obtener una fecha y calcular los dias restantes.
  ///
  /// El mismo recive un modelo (DropDownInfo) para poder encapsular la información.
  ///
  /// Dependiendo de los parámetros especificados en el modelo la vista del widget será reducida a lo que especifique.
  ///
  /// Limitaciones: Al contenerlo en una Row o Column, se debe envolver el widget en un SizedBox y especificar el ancho (width), sin especificar la altura (height). Las imágenes solo pueden ser especificadas por medio de un assets.
  DropDown({
    super.key,
    required this.info,
    this.onFavoritismChange,
  });

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  bool isExpanded = false;
  late bool isFavorite;
  late String formattedDate;

  @override
  void initState() {
    isFavorite = widget.info.isFavorite;
    if (widget.info.date != null) {
      formattedDate = DateFormat('dd/MM/yyyy kk:mm').format(widget.info.date!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Banner(),
            _ExpansionTile(context),
          ],
        ),
      ),
    );
  }

  _ExpansionTile(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        onExpansionChanged: (value) {
          setState(() {
            isExpanded = value;
          });
        },
        textColor: Colors.black,
        iconColor: Colors.black,
        collapsedTextColor: Colors.black,
        collapsedIconColor: Colors.black,
        trailing: _Trailing(),
        title: Row(
          children: [
            Icon(widget.info.leadingIcon),
            const SizedBox(width: 5),
            Text(widget.info.title),
          ],
        ),
        children: [
          _Text(),
        ],
      ),
    );
  }

  _Text() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        widget.info.info,
        style: TextStyle(
            fontSize: widget.info.infoSize,
            color: const Color.fromARGB(255, 107, 107, 107)),
      ),
    );
  }

// animacoin de flecha
  _Trailing() {
    return AnimatedRotation(
      turns: isExpanded ? 0.5 : 0,
      duration: const Duration(milliseconds: 200),
      child: const Icon(
        Icons.arrow_drop_down,
        size: 50,
        color: Colors.black,
      ),
    );
  }

  _Banner() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Padding(),
          _TopText(),
          _Image(),
          _BottomText(),
          _Divider(),
        ],
      ),
    );
  }

  _BottomText() {
    return (widget.info.price == null || widget.info.bingoName == null)
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.info.price!,
                style: TextStyle(
                  fontSize: widget.info.priceTextSize,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 1, 17, 112),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.info.bingoName!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: widget.info.bingoDateTextSize,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
  }

  _Image() {
    return widget.info.image == null
        ? const SizedBox.shrink()
        : Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  widget.info.image!,
                  fit: BoxFit.contain,
                  scale: 0.01,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
  }

  _TopText() {
    return widget.info.date == null
        ? const SizedBox.shrink()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ("Faltan " +
                            widget.info.date!
                                .difference(DateTime.now())
                                .inDays
                                .toString() +
                            " días"),
                        style: TextStyle(
                          color: const Color.fromARGB(255, 1, 17, 112),
                          fontWeight: FontWeight.bold,
                          fontSize: widget.info.remainingDaysTextSize,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Sortea " + formattedDate + "hrs.",
                        style:
                            TextStyle(fontSize: widget.info.bingoDateTextSize),
                      ),
                    ],
                  ),
                  SizedBox.square(
                    dimension: widget.info.favouriteButtonSize,
                    child: _FavoriteButton(),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
  }

  _FavoriteButton() {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
          if (widget.onFavoritismChange != null) {
            widget.onFavoritismChange!(isFavorite);
          }
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Visibility(
            visible: isFavorite,
            child: Icon(
              Icons.star_rounded,
              color: Colors.amber,
              size: 23 * (widget.info.favouriteButtonSize / 40),
            ),
          ),
          Icon(
            Icons.star_border_rounded,
            color: Colors.black,
            size: 33 * (widget.info.favouriteButtonSize / 40),
          ),
        ],
      ),
    );
  }

  _Padding() {
    return (widget.info.date == null &&
            widget.info.image == null &&
            widget.info.price == null)
        ? const SizedBox.shrink()
        : const SizedBox(height: 20);
  }

  _Divider() {
    return (widget.info.date == null &&
            widget.info.image == null &&
            widget.info.price == null)
        ? const SizedBox.shrink()
        : const Divider(color: Colors.black);
  }
}
