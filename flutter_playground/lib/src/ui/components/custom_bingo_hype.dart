import 'package:flutter/material.dart';
import 'package:auto_animated/auto_animated.dart'; //flutter pub add auto_animated [^3.1.0]

//Widget customizable para el bombo de bingo
class CustomBingoHype extends StatefulWidget {
  final List<Marble>? listMarbles;
  final double padding;
  final double height;
  final double width;
  final Color backgroundColor;
  final double? borderRadius;
  ///-----------INFO-----------
  ///
  ///Grupo 4 Semana 1
  ///
  ///Integrantes:
  ///* Caliva, Gaston Rafael
  ///* Pistan, Romano Renso
  ///* Rodriguez, Esteban Ernesto
  ///
  ///Este widget consiste en un contenedor donde se muestra una lista de bolillas [listMarbles], invertida ya que se necesita mostrar de izquierda a derecha.
  ///
  ///Tiene la posibilidad de darle un [height] y [width] al bolillero (o bombo) del bingo, además del color de fondo [backgroundColor] y el borde [borderRadius] del bolillero
  ///
  ///Cuenta con una animación para mostrar las bolillas que se ingresan
  ///
 const CustomBingoHype({
    Key? key,
    this.listMarbles,
    this.padding = 8,
    this.height = 60,
    this.width = double.infinity,
    this.backgroundColor = Colors.white,
    this.borderRadius,
  }) : super(key: key);


  @override
  State<CustomBingoHype> createState() => _CustomBingoHypeState();
}

class _CustomBingoHypeState extends State<CustomBingoHype>{
  double getSizeText(){
    return (widget.height - widget.padding * 2) / 2.8;
  }
  double getDiameterMarble(){
    return widget.height - widget.padding * 2;
  }
  double getBorderRadius(){
    return widget.height/2;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? getBorderRadius()),
      ),
      child: Padding(
        padding: EdgeInsets.all(widget.padding),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? getBorderRadius()),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: _listMarbles(getDiameterMarble()),
          ),
        ),
      ),
    );
  }
  //Crea el widget donde estarán las bolillas, a partir de una lista de bolillas
  _listMarbles(diameter) {
    return LiveList(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      reverse: true,
      itemCount: widget.listMarbles?.length ?? 0,
      itemBuilder: (context, index, animation) {
        return FadeTransition(
          opacity: animation,
          alwaysIncludeSemantics: true,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-0.2, 0),
              end: Offset.zero,
            ).animate(animation),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: diameter/12),
              child: _marble(
                number: widget.listMarbles![index].number,
                backgroundColor: widget.listMarbles?[index].color ?? Colors.grey,
                diameter: diameter,
                textSize: getSizeText(),
              ),
            ),
          ),
        );
      },
    );
  }
  //Crea la bolilla a partir del modelo Marble
  Widget _marble({
      double diameter = 20, 
      int number = 0, 
      double textSize = 12, 
      Color backgroundColor = Colors.amber,
      Color textColor = Colors.white,
      FontWeight fontWeight = FontWeight.bold,
      }) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      radius: diameter / 2,
      child: FittedBox(
        child: Text(
          "$number",
          style: TextStyle(
            color: textColor,
            fontSize: textSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}

//Modelo de la bolilla
class Marble {
  int number;
  Color? color;
  Marble({required this.number,this.color = Colors.grey});
}