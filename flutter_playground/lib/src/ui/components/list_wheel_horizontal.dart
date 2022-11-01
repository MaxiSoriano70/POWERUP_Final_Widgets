import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_playground/src/ui/components/custom_button_bingo.dart';

class ListWheelHorizontal extends StatefulWidget{
  late double? heightCard;
  late List<Cards> listCards;
  late Color? textColor;
  late double? fontSize;
  late Color? colorCard;

  /// ------INFO------
  ///
  /// Equipo: Álvarez, Díaz, Benjamín ; Coronel, Benjamín, Leonel ; Martearena Iván Alejandro
  ///
  /// Este widget es una lista horizontal con información de las ciudades donde se realizan los bingos
  // tiene una imagen, un título de ciudad, y un botón para ver los bingos que se juegan dentro de esa ciudad.
  // Este widget recibe una lista de Cards las cuales reciben una imagen que puede ser pasada por ruta,
  // se puede setear: el tamaño de las tarjetas, el color de las mismas, el tamaño y el color del texto.

  ListWheelHorizontal({
    Key? key,
    required double? height,
    required List<Cards> cards,
    this.textColor = Colors.black,
    this.fontSize = 15,
    this.colorCard = Colors.white
  }) : super(key: key){
    heightCard = height;
    listCards = cards;
  }

  @override
  State<ListWheelHorizontal> createState() => _ListWheelState(heightCard, listCards);

}

class _ListWheelState extends State<ListWheelHorizontal> {
  late double? heightCard;
  late List<Cards> listCards;
  _ListWheelState(double? height, List<Cards> cards){
    listCards = cards;
    if(height != null){
      heightCard = height;
    }
    else{
      heightCard = 400;
    }
  }

  final _controller = PageController(
    viewportFraction: 0.5,
    keepPage: true
  );

  double currentPage = 0.0;

  void _listener(){
    setState(() {
      currentPage = _controller.page!;
    });
  }

  @override
  void initState(){
    super.initState();
    _controller.addListener(_listener);
  }

  @override
  void dispose(){
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  //int _index =0;
  @override
  Widget build(BuildContext context) {
    double? opacity;
    return Center(
      child: SizedBox(
        height: heightCard, // card height
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: PageView.builder(
            itemCount: listCards.length,
            controller: _controller,
            itemBuilder: (_, i) {
              if(i == currentPage){
                opacity = 1;
                return Transform.scale(
                    scale: 1,
                    child: cardBuilder(listCards[i].directoryImage, listCards[i].textCard, listCards[i].actionButton, opacity!)
                );
              }else if(i < currentPage){
                opacity = max(1 - (currentPage - i), 0.8);
                return Transform.scale(
                    scale: max(1 - (currentPage - i), 0.8),
                    child: cardBuilder(listCards[i].directoryImage, listCards[i].textCard, listCards[i].actionButton, opacity!)
                );
              }else{
                opacity = max(1 - (i - currentPage), 0.8);
                listCards[i].opacity = opacity!;
                return Transform.scale(
                    scale: max(1 - (i - currentPage), 0.8),
                    child: cardBuilder(listCards[i].directoryImage, listCards[i].textCard, listCards[i].actionButton, opacity!)
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget cardBuilder(String directoryImage, String textCard, Function()? actionButton, double opacity){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 8,
            ),
          ],
          color: widget.colorCard,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
            children:[
              Flexible(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: ClipRRect(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20) ),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(directoryImage),
                            opacity: opacity,
                          )
                      ),
                    ),
                  ),
                ),
              ),
              const Flexible(
                flex: 1,
                child: SizedBox(
                  height: 10,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 5),
                  child: Text(textCard, style: TextStyle(color: widget.textColor, fontSize: widget.fontSize),)),
              const Expanded(
                flex: 1,
                child: SizedBox(
                  height: 5,
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                  child: CustomButtonBingo(
                    onTap: (){
                      actionButton;
                    },
                    text: 'Ver bingos',
                    textColor: Colors.white,
                    backgroundColor: Colors.green, textSize: 15,),
                ),
              )
            ]
        ),
      ),
    );
  }

}

class Cards{
  late String directoryImage;
  late String textCard;
  late double opacity;
  late dynamic actionButton;

  Cards({
    Key? key,
    required String directory,
    required String text,
    required Function()? action}){
    directoryImage = directory;
    textCard = text;
    actionButton = action;
  }
}

