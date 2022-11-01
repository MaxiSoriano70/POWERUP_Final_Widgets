import 'package:flutter/material.dart';
import 'package:flutter_playground/src/enums/enum_type.dart';
import 'package:flutter_playground/src/ui/components/custom_pop_up.dart';


class MySecondPage extends StatefulWidget {
  MySecondPage({Key? key, required this.title}) : super(key: key);
  PopUpCardtype last_touched = PopUpCardtype.correct;
  final String title;
  @override
  State<MySecondPage> createState() => MySecondPageState();
}

class MySecondPageState extends State<MySecondPage> {
  void _save() {
    showDialog(
        context: context,
        builder: (context) {
          return PopUp(
            state: widget.last_touched,
            onClose: (){
              print('chau');
            },
            onAccept: (){
              print('ok');
            },
          );
          //return PopUpCard();
        });
  }

  @override
  Widget build(BuildContext context) {
    Touch(PopUpCardtype a) {
      widget.last_touched = a;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(children: [
          Row(children: [
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  Touch(PopUpCardtype.incorrect);
                });
              },
              backgroundColor: Colors.red,
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  Touch(PopUpCardtype.correct);
                });
              },
              backgroundColor: Colors.green,
            ),
          ]),
          /* CustomButton(
            text: "Aceptar",
          ),*/

          MaterialButton(
            onPressed: _save,
            padding: const EdgeInsets.all(12),
            color: Colors.blueAccent,
            child: Text("Guardar"),
          ),

        ]),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  onAccept(){
    print('aceptado');
  }
  onClose(){
    print('cerrado');
  }
}
