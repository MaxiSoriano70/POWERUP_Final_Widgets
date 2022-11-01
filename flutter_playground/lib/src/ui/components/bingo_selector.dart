import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_playground/src/models/bingo_ticket_model.dart';
import 'custom_button_bingo.dart';

class BingoSelector extends StatefulWidget {
  final int maxQuantity;
  final List<BingoTicketModel> list;
  final Color color;
  final Function(List<int>)? shoppIt;

  ///==========Bingo Selector==========
  ///
  ///Integrantes:
  ///
  ///-Marín, Sofía
  ///
  ///-Reynaga, Rodrigo
  ///
  ///-Narvaez, Gustavo
  ///
  ///Con este widget se muestran los números de los cartones de un bingo disponibles
  ///para comprar. Por defecto se pueden elegir 3 cartones de forma manual o al azar,
  ///pudiendo modificarse esta cantidad si es necesario. Tener en cuenta esta cantidad
  ///no tiene que superar el número total de cartones.
  ///
  ///Tambien se puede customizar el color principal que llevarán los cartones, el
  ///selector y el botón para realizar el pago.

  BingoSelector({
    Key? key,
    required this.list,
    this.color = const Color(0xff0000b2),
    this.shoppIt,
    this.maxQuantity = 3,
  }) : super(key: key);

  @override
  State<BingoSelector> createState() => _BingoCartonState();
}

class _BingoCartonState extends State<BingoSelector> {
  Options currentOption = Options.manual;
  List<Widget> bingoCards = [];
  List<BingoTicketModel> randomBingoCards = [];
  List<int> selectedBingos = [];
  ScrollController scrollController = ScrollController();

  void addBingo(BingoTicketModel bingo) {
    setState(() {
      if (selectedBingos.contains(bingo.id)) {
        selectedBingos.remove(bingo.id);
      } else if (selectedBingos.length < widget.maxQuantity) {
        selectedBingos.add(bingo.id);
      }
    });
  }

  void onChangeOption(Options option) {
    setState(() {
      selectedBingos = [];
      currentOption = option;
      if (option == Options.random) {
        randomBingoCards = [];
        randomBingoCards = getRandomList();
        randomBingoCards.forEach((element) {
          addBingo(element);
        });
      }
    });
  }

  List<BingoTicketModel> getRandomList() {
    final random = Random();
    List<BingoTicketModel> list = [];
    int aux = 0;
    int quantity = widget.maxQuantity;
    int limit = widget.list.length;
    for (int i = 0; i < quantity; i++) {
      aux = random.nextInt(limit);
      while (list.contains(widget.list[aux])) {
        aux = random.nextInt(limit);
      }
      list.add(widget.list[aux]);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    bingoCards = [];
    (currentOption == Options.manual ? widget.list : randomBingoCards)
        .forEach((element) {
      bingoCards.add(_bingoButton(element));
    });

    return Container(
      width: 320,
      height: 500,
      color: const Color(0xffF5F5F5),
      child: Column(children: [
        _header(),
        const SizedBox(height: 20),
        SizedBox(
          width: 320,
          child: Row(
            children: [
              _optionButtons('Elegir mi cartón', Options.manual),
              const SizedBox(
                width: 15,
              ),
              _optionButtons('Selección aleatoria', Options.random),
            ],
          ),
        ),
        _pagesControl()
      ]),
    );
  }

  _header() {
    return Column(children: const [
      SizedBox(
        width: 320,
        height: 35,
        child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Comprar',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0),
            )),
      ),
      SizedBox(
        width: 320,
        child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Seleccione una de las siguientes opciones: ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5),
            )),
      ),
    ]);
  }

  Widget _optionButtons(String text, Options option) {
    return SizedBox(
      child: Row(
        children: [
          InkWell(
            onTap: () {
              onChangeOption(option);
            },
            child: Stack(alignment: Alignment.center, children: [
              Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white),
                ),
              ),
              Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                    color:
                    option == currentOption ? widget.color : Colors.white,
                    borderRadius: BorderRadius.circular(100)),
              ),
            ]),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(text,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5))
        ],
      ),
    );
  }

  Widget _pagesControl() {
    return IndexedStack(
      index: currentOption.index,
      children: [_manualOptionPage(), _randomOptionPage()],
    );
  }

  Widget _manualOptionPage() {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          _bingoCardList(),
          const SizedBox(
            height: 10,
          ),
          _counter(),
          const SizedBox(
            height: 15,
          ),
          CustomButtonBingo(
            text: 'Pagar',
            height: 35,
            backgroundColor: widget.color,
            textSize: 13,
            isEnabled: selectedBingos.isNotEmpty,
            onTap: () {
              widget.shoppIt!(selectedBingos);
            },
          )
        ],
      ),
    );
  }

  Widget _randomOptionPage() {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Wrap(
          direction: Axis.horizontal,
          spacing: 15,
          runSpacing: 15,
          children: bingoCards,
        ),
        const SizedBox(
          height: 15,
        ),
        CustomButtonBingo(
            text: 'Pagar',
            height: 35,
            backgroundColor: widget.color,
            textSize: 12,
            isEnabled: selectedBingos.isNotEmpty,
            onTap: () {
              widget.shoppIt!(selectedBingos);
            })
      ],
    );
  }

  Widget _bingoCardList() {
    return SizedBox(
      width: 320,
      height: 280,
      child: RawScrollbar(
        thumbVisibility: false,
        thickness: 5,
        controller: scrollController,
        thumbColor: Colors.transparent,
        radius: const Radius.circular(5),
        child: Theme(
          data: ThemeData(
            scrollbarTheme: const ScrollbarThemeData(
              //thickness: MaterialStatePropertyAll(4),
              //thumbVisibility: MaterialStatePropertyAll(false),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 15,
              runSpacing: 15,
              children: bingoCards,
            ),
          ),
        ),
      ),
    );
  }

  Widget _bingoButton(BingoTicketModel bingo) {
    bool isSelected = selectedBingos.contains(bingo.id);

    return InkWell(
      onTap: () {
        addBingo(bingo);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 150,
        height: 33,
        decoration: BoxDecoration(
          border: Border.all(color: widget.color),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? widget.color : Colors.white,
        ),
        child: Center(
          child: Text(
            'N° ${bingo.number}',
            style: TextStyle(
                color: isSelected ? Colors.white : widget.color,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
        ),
      ),
    );
  }

  Widget _counter() {
    return Material(
        elevation: 1,
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 320,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Cartones seleccionados',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${selectedBingos.length.toString()} / ${widget.maxQuantity}',
                  style: TextStyle(
                      color: widget.color,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ));
  }
}

enum Options {
  manual,
  random,
}