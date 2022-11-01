import '../../enums/enum_type.dart';
import 'custom_button_bingo.dart';
import 'package:flutter/material.dart';

class PopUp extends StatefulWidget {
  PopUpCardtype state;
  ///---INFO---
  ///
  /// Equipo: Chaile, Micaela ; Martearena, Iván ; Pistan, Renso
  ///
  /// Este widget consiste en una ventana emergente que se presenta centrada por encima del contenido
  /// de la vista actual. Recibe por parámetro un estado (por el momento correcto/incorrecto) que determina
  /// los colores y textos que se mostrarán,además de dos funciones, una al presionar el botón en la parte
  /// inferior del widget y otra al cerrarlo.
  ///
  /// Los colores que se presentan estan establecidos por defecto, pueden cambiarse.
  PopUp({
    Key? key,
    required this.state,
    this.correctColor = Colors.teal,
    this.errorColor = Colors.red,
    this.onAccept,
    this.onClose,
  }) : super(key: key);
  final Function? onAccept;
  final Function? onClose;
  final Color correctColor;
  final Color errorColor;

  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  late Color color;
  late Icon icon;
  late String text;
  late String buttonText;
  _state(PopUpCardtype state) {
    switch (state) {
      case PopUpCardtype.incorrect:
        color = widget.errorColor;
        icon = const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
          size: 35,
        );
        text = "Esta por abandonar la partida. \n Después puede reanudarla";
        buttonText = "Entendido";
        break;

      case PopUpCardtype.correct:
        color = widget.correctColor;
        icon = const Icon(
          Icons.check_rounded,
          color: Colors.teal,
          size: 40,
        );
        text = "Se han guardado\n los cambios";
        buttonText = "Aceptar";
        break;
      default:
        break;
    }
    return _popUpCard();
  }

  @override
  Widget build(BuildContext context) {
    return _state(widget.state);
  }

  _popUpCard() {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: (_popUpContent()),
    );
  }

  _popUpContent() {
    double height = MediaQuery.of(context).size.height / 3.4;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: height,
        width: height * 1.25,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  color: color,
                  height: height / 4,
                  width: double.infinity,
                ),
                SizedBox(
                  height: height / 8,
                  width: double.infinity,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                  alignment: Alignment.center,
                  height: height * 0.3,
                  width: double.infinity,
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, bottom: 20, top: 20),
                  alignment: Alignment.center,
                  height: height / 3.1,
                  width: double.infinity,
                  child: CustomButtonBingo(
                    text: buttonText,
                    backgroundColor: color,
                    textSize: 15,
                    onTap: () {
                      if (widget.onAccept != null) {
                        widget.onAccept!();
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                )
              ],
            ),
            Positioned(
              top: 25,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                          spreadRadius: 5,
                          offset: Offset(4, 4))
                    ]),
                height: height / 4,
                width: height / 4,
                child: Center(child: icon),
              ),
            ),
            Positioned(
              right: 0.5,
              top: 0.5,
              child: CloseButton(
                onPressed: () {
                  if (widget.onClose != null) {
                    widget.onClose!();
                    Navigator.maybePop(context);
                  } else {
                    Navigator.maybePop(context);
                  }
                },
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
