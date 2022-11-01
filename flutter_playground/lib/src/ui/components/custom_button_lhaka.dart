import 'package:flutter/material.dart';

class CustomButtonLhaka extends StatelessWidget {
  String? text;
  Color textColor;
  IconData? iconData;
  String? iconPath;
  Color? iconColor;
  Color? backgroundColor;
  Color? borderColor;
  Function? onTap;
  bool isEnabled;
  EdgeInsets padding;
  TextStyle? textStyle;
  ButtonStyle? _buttonStyle;
  ///==========Custom Button LHAKA==========
  ///
  ///Grupo 1 Semana 1
  ///
  ///Integrantes:
  ///
  ///-Alvarez Yapura, Victoria
  ///
  ///-Herrera, Camila
  ///
  ///-Reynaga, Rodrigo
  ///
  ///
  ///Crea un botón rectangular elevado con los bordes redondeados,
  ///el widget recibe los parametros text para definir el texto e iconData o iconPath que definen el icono, iconData tiene prioridad sobre iconPath.
  ///
  /// El boton puede ser desactivado mediante el parametro isEnabled, y cuando es presionado ejecuta la funcion definida en el parametro onTap
  ///
  ///Los parametros backgroundColor, borderColor, padding modifican el aspecto del boton
  ///los parametros textColor y textStyle modifican la apariencia del texto, el color definido en textStyle tiene prioridad sobre textColor
  ///cuando se define el parametro textStyle solo se puede modificar los parametros color, fontSize, fontWeight, fontStyle y letterSpacing del texto
  CustomButtonLhaka(
      {Key? key,
        this.text,
        this.iconData,
        this.iconPath,
        this.iconColor,
        this.backgroundColor = Colors.blue,
        this.borderColor,
        this.onTap,
        this.isEnabled = true,
        this.textColor = Colors.white,
        this.padding = const EdgeInsets.only(left: 8,right:8, top: 6, bottom: 6),
        this.textStyle}) : super(key: key) {

    if(isEnabled == false){
      textColor = Colors.white;
      iconColor = Colors.white;
      borderColor = Colors.transparent;
    }
    iconColor ??= textColor;
    borderColor ??= backgroundColor;

    if(textStyle == null ){
      textStyle = TextStyle(color: textColor);
    }
    else {
     textStyle =  TextStyle(color: textStyle!.color ?? textColor,fontSize: textStyle!.fontSize, fontWeight:textStyle!.fontWeight,fontStyle:textStyle!.fontStyle,letterSpacing: textStyle!.letterSpacing);
    }
    _buttonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 8,
      side:  BorderSide(color: borderColor!, width: 2),
      backgroundColor: backgroundColor,
      padding:const  EdgeInsets.all(2),
      minimumSize:Size.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: isEnabled ? onTap== null? ()=>{} : ()=>onTap!() : null,
        style: _buttonStyle,
        child: Padding(
          padding: padding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _icon(),
              _separator(),
              _text(),
            ],
          ),
        ));
  }

  _icon() {
    return iconData == null
        ? iconPath == null
        ? const SizedBox.shrink()
        : ImageIcon(AssetImage(iconPath!), color: iconColor,)
        : Icon(iconData, color: iconColor,size: textStyle!.fontSize,);
  }

  _separator() {
    if ((iconPath != null || iconData != null) && text != null) {
      return const SizedBox(width: 10,);
    }
    else {
      return const SizedBox.shrink();
    }
  }

  _text() {
    return text != null
        ? Text(text!, style: textStyle)
        : const SizedBox.shrink();
  }
}
