// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_playground/src/ui/components/custom_button_bingo.dart';

class TutorialComponent extends StatefulWidget {
  late List<TutorialInstructionModel> tutorialItem;
  late Color? backgroundColor;
  late Color? primaryColor;
  late Color? secondaryColor;
  Widget pageDestiny;
  late Color? instructionColor;
  double? fontSizeTitle;
  double? fontSizeInstruction;
  double? height;
  double? width;
  double? buttonWidth;
  double? buttonHeight;

  ///---------------INFO--------------
  ///
  ///Grupo 6 Semana 2
  ///
  ///Equipo :
  ///
  ///Alvarez Yapura, Victoria
  ///
  ///Álvarez, Díaz, Benjamín
  ///
  ///Narvaez Gustavo Gabriel
  ///
  ///
  ///TutorialComponent es un widget el cual tiene la capacidad de informar,
  ///sus principales características son la navegación a través de su contenido
  ///y salto hacia una nueva pagina, su lista de contenido y flexibilidad de estilo.
  ///
  ///Es requerido por parámetro una lista de TutorialInstruction,
  ///una pagina de destino (pageDestiny) la cual se accederá una vez que se recorra o se salte el contenido.
  ///
  ///Además se  recibe como parámetros opcionales las siguientes propiedades las cuales modifican el color de fondo del widget
  ///y su tamaño (backgroundColor, height (alto) y width (ancho)),
  ///apariencia de los Titulos ( fontSizeTitle, primaryColor),
  ///apariencia de las instrucciones (fontSizeInstruction y instructionColor),
  ///apariencia de los botones( buttonWidth, buttonHeight y paddingButton).
  TutorialComponent({
    Key? key,
    required this.tutorialItem,
    this.backgroundColor = Colors.white,
    this.primaryColor = Colors.teal,
    this.secondaryColor = Colors.grey,
    required this.pageDestiny,
    this.instructionColor = Colors.black,
    this.fontSizeTitle = 20,
    this.fontSizeInstruction = 14,
    this.height = 650,
    this.width = 350,
    this.buttonWidth = 150,
    this.buttonHeight = 30,
  }) : super(key: key);

  @override
  State<TutorialComponent> createState() => _TutorialComponentState();
}

class _TutorialComponentState extends State<TutorialComponent> {
  int indexPosition = 0;

  List<Widget> _pageIndicatorModule() {
    List<Widget> list = [];
    for (int i = 0; i < widget.tutorialItem.length; i++) {
      list.add(i <= indexPosition
          ? _pageIndicatorCell(true)
          : _pageIndicatorCell(false));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    return Center(
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: widget.backgroundColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 10.0,
              spreadRadius: 2.0,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 25,
            right: 25,
            top: 5,
            bottom: 5,
          ),
          child: _content(),
        ),
      ),
    );
  }

  Widget _content() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _pageIndicatorModule(),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: IndexedStack(
              index: indexPosition,
              children: buildContent(),
            ),
          ),
          Expanded(flex: 1, child: _buttonModule())
        ]);
  }

  Widget _pageIndicatorCell(bool isActive) {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: isActive ? 5 : 8,
        width: isActive
            ? 200 / widget.tutorialItem.length
            : 100 / widget.tutorialItem.length,
        decoration: BoxDecoration(
            color: isActive ? widget.primaryColor : widget.secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
      ),
    );
  }

  List<Widget> buildContent() {
    List<Widget> contentList = [];
    for (int i = 0; i < widget.tutorialItem.length; i++) {
      contentList.add(_showsContent());
    }
    return contentList;
  }

  Widget _showsContent() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        child: Column(children: [
          Expanded(
              flex: 3,
              child: Image.asset(
                widget.tutorialItem[indexPosition].image,
                fit: BoxFit.cover,
                scale: 0.01,
              )),
          const SizedBox(height: 30),
          Expanded(
              flex: 1,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: _text(
                      widget.tutorialItem[indexPosition].title,
                      widget.primaryColor,
                      widget.fontSizeTitle,
                      FontWeight.bold),
                ),
              )),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: _text(
                    widget.tutorialItem[indexPosition].instruction,
                    widget.instructionColor,
                    widget.fontSizeInstruction,
                    FontWeight.normal),
              ))
        ]),
      ),
    );
  }

  Widget _text(
      String text, Color? color, double? fontSize, FontWeight? fontWeight) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }

  Widget _buttonModule() {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          indexPosition != 0
              ? Expanded(
                  flex: 3,
                  child: CustomButtonBingo(
                    isEnabled: true,
                    onTap: () => _loadPreviousWidget(),
                    text: 'Volver',
                    height: widget.buttonHeight!,
                    width: widget.buttonWidth! - 60 / 2,
                    backgroundColor: widget.backgroundColor!,
                    textColor: Colors.red,
                  ),
                )
              : Expanded(
                  flex: 3,
                  child: CustomButtonBingo(
                    onTap: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return widget.pageDestiny;
                      }))
                    },
                    text: 'Skip',
                    textColor: Colors.red,
                    height: widget.buttonHeight!,
                    width: widget.buttonWidth! - 60 / 2,
                    backgroundColor: widget.backgroundColor!,
                  ),
                ),
          const Expanded(flex: 1, child: SizedBox()),
          indexPosition < widget.tutorialItem.length - 1
              ? Expanded(
                  flex: 3,
                  child: CustomButtonBingo(
                    onTap: () => _loadNextWidget(),
                    text: 'Continuar',
                    textColor: Colors.white,
                    height: widget.buttonHeight!,
                    width: widget.buttonWidth! - 60 / 2,
                  ),
                )
              : Expanded(
                  flex: 3,
                  child: CustomButtonBingo(
                    onTap: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return widget.pageDestiny;
                      }))
                    },
                    text: 'Terminar',
                    textColor: Colors.white,
                    height: widget.buttonHeight!,
                    width: widget.buttonWidth! - 60 / 2,
                  ),
                )
        ]));
  }

  void _loadNextWidget() {
    if (indexPosition < widget.tutorialItem.length - 1) {
      setState(() {
        indexPosition++;
      });
    } else {
      setState(() {
        indexPosition = 0;
      });
    }
  }

  void _loadPreviousWidget() {
    if (indexPosition <= widget.tutorialItem.length) {
      setState(() {
        indexPosition--;
      });
    } else {
      setState(() {
        indexPosition = 0;
      });
    }
  }
}

class TutorialInstructionModel {
  final String image;
  final String title;
  final String instruction;

  TutorialInstructionModel(
      {required this.image, required this.title, required this.instruction});
}
