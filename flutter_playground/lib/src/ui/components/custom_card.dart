import 'package:flutter/material.dart';
import 'package:flutter_playground/src/models/bingo_ticket_model.dart';
import 'package:flutter_playground/src/ui/components/custom_button_bingo.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatefulWidget {
  final BingoTicketModel bingo;
  final Function stateFavorite;
  final Function shareIt;
  final Function shoppIt;

  /// ---- INFO ----
  ///
  /// Grupo: Apaza, Celina ; Herrera, Camila ; Marín Sofía.
  ///
  /// Con este widget se puede mostrar la información de un bingo en una card personalizada.
  /// La card cuenta con un botón para añadir a favoritos y otro para compartir.
  /// El título y la fecha son datos requeridos.
  ///
  /// Además, cuenta con la posibilidad de mostrar un botón para comprar si es que se le añade un precio.

  const CustomCard({Key? key,
    required this.shoppIt,
    required this.stateFavorite,
    required this.shareIt,
    required this.bingo})
      : super(key: key);

  getModel(){
    return bingo;
  }

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {

  void isFavorite() {
    setState(() {
      widget.bingo.setIsFavorite(!(widget.bingo.getIsFavorite()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            _image(),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                              child: _dataCard()),
                        ),
                        _buttons(),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 25,
                    child: _isButtonVisible(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _image(){
    childImage(){
      if(widget.bingo.getImageUrl() != ""){
        return SizedBox(
            width: 125,
            height: 125,
            child: Image.network(widget.bingo.getImageUrl(), fit: BoxFit.fill)
        );
      } else {
        return const SizedBox(
            width: 125,
            height: 125,
            child: Icon(Icons.image_not_supported_outlined, size: 50,)
        );
      }
    }
    return Padding(
        padding: const EdgeInsets.only(right:15.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: childImage(),
        )
    );
  }

  Widget _dataCard(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.bingo.getName(),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: const TextStyle( fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.grey ),
        ),
        const SizedBox(height: 5),
        Text(DateFormat("dd/MM - yyyy").format(widget.bingo.getDate()),
          style: const TextStyle(
              fontSize: 18.0,
              //fontWeight: FontWeight.bold,
              color: Colors.grey
          ),
          textAlign: TextAlign.left,),
        //const SizedBox(height: 35.0,),
        const SizedBox(height: 5),
        Text(widget.bingo.getPrice() != 0 ? '\u0024${widget.bingo.getPrice().round()}' : " ",
          style: const TextStyle(color: Color(0xff0000b2), fontSize: 18, fontWeight: FontWeight.bold,),),
      ],
    );
  }

  Widget _buttons(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buttonFavorite(),
        const SizedBox(height: 10,),
        _buttonShare(),
      ],
    );
  }

  Widget _buttonFavorite() {
    Widget icon() {
      if (widget.bingo.getIsFavorite()) {
        return const Icon(Icons.star, color: Colors.amber,size: 23,);
      }else{
        return const Icon(Icons.star_border, color: Colors.grey, size: 23);
      }
    }
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(32),
      child: InkWell(
          borderRadius:BorderRadius.circular(32) ,
          onTap:(){
            isFavorite();
            widget.stateFavorite(widget.bingo);
          },
          child:SizedBox(
            //padding: EdgeInsets.all(1),
            width: 32,
            height: 32,
            child: icon(),
          )
      ),
    );
  }

  Widget _buttonShare() {
    return Material(
      elevation: 3,
      borderRadius:BorderRadius.circular(32) ,
      child: InkWell(
          onTap: (){
            widget.shareIt(widget.bingo);
          },
          borderRadius: BorderRadius.circular(32) ,
          child: const SizedBox(width: 32, height: 32,
            child: Icon(Icons.share_outlined,color: Colors.grey,size: 23,),
          )
      ),
    );
  }

  Widget _isButtonVisible() {
    return widget.bingo.getPrice() != 0 ? CustomButtonBingo(
      onTap: (){
        widget.shoppIt(widget.bingo);
      },
      text: "Comprar",
      backgroundColor: const Color(0xff0000b2),
    ): const SizedBox.shrink();
  }
}