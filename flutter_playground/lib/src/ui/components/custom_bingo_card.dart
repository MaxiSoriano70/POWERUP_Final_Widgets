import 'package:flutter/material.dart';

class CustomButton{
  String? _number;
  bool? _itsPressed;
  Color? _defaultBackgroundColor;
  Color? _pressedBackgroundColor;
  Color? _textColor;

  CustomButton(String number, Color defaultBackgroundColor, Color pressedBackgroundColor, Color textColor){
    _number = number;
    _itsPressed = false;
    _defaultBackgroundColor = defaultBackgroundColor;
    _pressedBackgroundColor = pressedBackgroundColor;
    _textColor = textColor;
  }

  String get number => _number!;
  set number(String number){
    _number = number;
  }

  bool get itsPressed => _itsPressed!;
  set itsPressed(bool value){
    _itsPressed = value;
  }

  Color get defaultBackgroundColor => _defaultBackgroundColor!;
  set defaultBackgroundColor (Color color){
    _defaultBackgroundColor = color;
  }

  Color get pressedBackgroundColor => _pressedBackgroundColor!;
  set pressedBackgroundColor (Color color){
    _pressedBackgroundColor = color;
  }

  Color get textColor => _textColor!;
  set textColor (Color color){
    _textColor = color;
  }

  void _hasBeenPressed(Color defaultBackgroundColor, Color pressedBackgroundColor){
    if (_itsPressed == false){
      _itsPressed = true;
      _defaultBackgroundColor = pressedBackgroundColor;
      _textColor = Colors.white;
    } else {
      _itsPressed = false;
      _defaultBackgroundColor = defaultBackgroundColor;
      _textColor = Colors.black;
    }
  }
}

class BingoCard extends StatefulWidget {
  final List<int> numbersList;
  final Color letterCardColor;
  final Color defaultBgNumberColor;
  final Color pressedBgNumberColor;
  final Color textColor;
  final Color cardColor;

  ///----INFO----
  ///
  /// Equipo: Chaile, Micaela ; Marín, Sofía ; Soriano, Maximiliano
  ///
  /// Este widget consiste en un cartón de bingo, está diseñado para recibir una lista de hasta 35 números,
  /// en caso de recibir una cantidad menor, los casilleros serán autocompletados mediante guiones.
  ///
  /// Todos los colores de los elementos se encuentran establecidos por defecto, pueden ser cambiados.

  const BingoCard({

    Key? key,
    required this.numbersList,
    this.letterCardColor = const Color(0xff09857d),
    this.defaultBgNumberColor = const Color(0xffada9a6),
    this.pressedBgNumberColor = const Color(0xffa4243b),
    this.textColor = Colors.black,
    this.cardColor = Colors.white
  }) : super(key: key);

  void listBuilder(List<CustomButton> list){
    for(int i=0;i<35;i++){
      if(i>=numbersList.length){
        var aux = CustomButton("-",defaultBgNumberColor,pressedBgNumberColor,Colors.black);
        list.add(aux);
      }
      else{
        var aux = CustomButton(numbersList[i].toString(),defaultBgNumberColor,pressedBgNumberColor,Colors.black);
        list.add(aux);
      }
    }
  }

  @override
  State<BingoCard> createState() => _BingoCardState();
}


class _BingoCardState extends State<BingoCard> {
  List<CustomButton> customButtonList=[];

  @override
  // ignore: must_call_super
  void initState() {
    widget.listBuilder(customButtonList);
  }

  void _checkColorButton(CustomButton button){
    if(button._number!="-"){
      button._hasBeenPressed(widget.defaultBgNumberColor,widget.pressedBgNumberColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _bingoCard(customButtonList);
  }

  Widget _bingoCard( List<CustomButton> customButtonList) {
    double width= MediaQuery.of(context).size.width;
    return Material(
      elevation: 25,
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.all(width*0.072/2),
          width: width,
          height: width * 0.64,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: widget.cardColor,),
          child: Row (children: [
            _wordBingo(width),
            SizedBox(width: width * 0.035, height: width * 0.64),
            _gridViewNumbers(width, customButtonList),
          ],),
        ),
      ),
    );
  }

  Widget _wordBingo(double width){
    List <String> word = ["B", "I", "N", "G", "0"];
    return SizedBox(
      width: width * 0.084,
      height: width * 0.64,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        itemCount: word.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: (width*0.072/2),
            mainAxisSpacing: width*0.072/2
        ),
        itemBuilder: (context, index){
          return _letterCard(width, word[index]);
        },
      ),
    );
  }

  Widget _letterCard(double width, String text){
    return Container(
      width: width*0.072,
      height: width*0.072,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.letterCardColor,),
      child: Center(
        child: Text(text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: width*0.036),),
      ),
    );
  }

  Widget _gridViewNumbers(double width, List<CustomButton> customButtonList){
    return SizedBox(
      width: width * 0.808,
      height: width * 0.64,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        itemCount: customButtonList.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: (width*0.072/2),
            mainAxisSpacing: width*0.072/2
        ),
        itemBuilder: (context, index){
          return _cardNumber(customButtonList[index],width);
        },
      ),
    );
  }

  Widget _cardNumber(CustomButton button,double width){
    return InkWell(
      onTap: (){
        setState(() {
          _checkColorButton(button);
        });
      },
      child: Container(
        width: width*0.072,
        height: width*0.072,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: button._defaultBackgroundColor,),
        child: Center(
          child: Text(button._number.toString(),
            style: TextStyle(color: button._textColor, fontWeight: FontWeight.bold, fontSize: width*0.036),),
        ),
      ),
    );
  }
}