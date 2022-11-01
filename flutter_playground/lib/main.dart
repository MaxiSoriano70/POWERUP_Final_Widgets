import 'package:flutter/material.dart';
import 'package:flutter_playground/second_page.dart';
import 'package:flutter_playground/src/models/bingo_ticket_model.dart';
import 'package:flutter_playground/src/models/drop_down_info.dart';
import 'package:flutter_playground/src/models/employee_model.dart';
import 'package:flutter_playground/src/models/person_search_model.dart';
import 'package:flutter_playground/src/models/salary_model.dart';
import 'package:flutter_playground/src/models/task_model.dart';
import 'package:flutter_playground/src/models/work_area_model.dart';
import 'package:flutter_playground/src/ui/components/bingo_selector.dart';
import 'package:flutter_playground/src/ui/components/custom_bingo_card.dart';
import 'package:flutter_playground/src/ui/components/custom_bingo_hype.dart';
import 'package:flutter_playground/src/ui/components/custom_button_bingo.dart';
import 'package:flutter_playground/src/ui/components/custom_button_lhaka.dart';
import 'package:flutter_playground/src/ui/components/custom_card.dart';
import 'package:flutter_playground/src/ui/components/custom_counter_and_price_calculator.dart';
import 'package:flutter_playground/src/ui/components/custom_filter.dart';
import 'package:flutter_playground/src/ui/components/custom_login_user.dart';
import 'package:flutter_playground/src/ui/components/custom_workschedule/custom_workschedule.dart';
import 'package:flutter_playground/src/ui/components/drop_down.dart';
import 'package:flutter_playground/src/ui/components/folding_cardboard_component_custom.dart';
import 'package:flutter_playground/src/ui/components/list_wheel_horizontal.dart';
import 'package:flutter_playground/src/ui/components/search.dart';
import 'package:flutter_playground/src/ui/components/tutorial_component.dart';
import 'package:flutter_playground/src/ui/components/user_profile.dart';
import 'package:flutter_playground/src/models/person_model.dart';

import 'src/ui/components/work_calendar_component.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PowerUp Flutter PlayGround',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'PowerUp Flutter PlayGround'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PersonModel personaNN = PersonModel('Benito', 'Rodriguez',
      'brodriguez@gmail.com', 8108135, 'Localidad', 2874125478);
  List<FilterItem> filtros = [
    FilterItem(
        id: 1,
        title: 'Mantenimiento',
        icon: Icons.settings,
        iconBackgroundColor: Colors.grey),
    FilterItem(
      id: 2,
      title: 'Corte',
      icon: Icons.content_cut_sharp,
      iconBackgroundColor: Colors.pink.shade200,
    ),
    FilterItem(
        id: 3,
        title: 'Calidad',
        iconBackgroundColor: Colors.purple.shade300,
        icon: Icons.assignment_ind_outlined),
    FilterItem(
      id: 4,
      title: 'Jefe taller',
      icon: Icons.groups_outlined,
      iconBackgroundColor: Colors.deepPurpleAccent,
    ),
    FilterItem(
        id: 5,
        title: 'Limpieza',
        iconBackgroundColor: Colors.blue,
        icon: Icons.sanitizer_sharp),
    FilterItem(
        id: 6,
        title: 'Capacitación',
        iconBackgroundColor: Colors.green.shade700,
        icon: Icons.school_sharp),
    FilterItem(
        id: 7,
        title: 'Confección',
        iconBackgroundColor: Colors.deepOrange,
        icon: Icons.person),
  ];

  BingoTicketModel bingo1 = BingoTicketModel(
      id: 1,
      number: 123456,
      date: DateTime(2022, 12, 7),
      name: "29° Bingo de la Liga Salteña de Futbol",
      priceUnit: 1500,
      imageUrl:
          "https://i0.wp.com/infosal.es/wp-content/uploads/2020/03/BINGO.jpg?fit=2000%2C2000&ssl=1",);

  void shopp(BingoTicketModel model) {
    print("Comprar ${model.getName()}");
  }

  void share(BingoTicketModel model) {
    print("Compartir ${model.getName()}");
  }

  void favorite(BingoTicketModel model) {
    if (model.getIsFavorite()) {
      print("Añadido a favoritos ${model.getName()}");
    } else {
      print("Quitado de favoritos ${model.getName()}");
    }
  }

  final List<TutorialInstructionModel> tutorialList = [
    TutorialInstructionModel(
        image: 'TutorialExample1.png',
        title: '¡Bienvenido/a a Proteo Bingo!',
        instruction:
            'En esta plataforma cada que compres un cartón de bingo estaras ayudando a una causa social.'),
    TutorialInstructionModel(
        image: 'TutorialExample2.png',
        title: 'Buscar bingos',
        instruction:
            'Elige la provincia y municipio en el cual quieras comprar tu bingo.'),
    TutorialInstructionModel(
        image: 'TutorialExample3.png',
        title: 'Comprar un cartón',
        instruction: 'Decide tu modo de juego: cartón lleno o por linea.'),
    TutorialInstructionModel(
        image: 'TutorialExample4.png',
        title: 'Jugar tu cartón',
        instruction:
            'En la sección "mis bingos" estan todos los bingos que compraste.'),
  ];

  final List<BingoTicketModel> bingoList = [
    BingoTicketModel(id: 2, number: 100001, priceUnit: 10000, name: "bingo 2", date: DateTime(2022, 12, 7),),
    BingoTicketModel(id: 3, number: 104001, priceUnit: 10000, name: "bingo 2", date: DateTime(2022, 12, 7),),
    BingoTicketModel(id: 4, number: 105001, priceUnit: 10000, name: "bingo 2", date: DateTime(2022, 12, 7),),
    BingoTicketModel(id: 5, number: 130006, priceUnit: 10000, name: "bingo 2", date: DateTime(2022, 12, 7),),
    BingoTicketModel(id: 6, number: 150003, priceUnit: 10000, name: "bingo 2", date: DateTime(2022, 12, 7),),
    BingoTicketModel(id: 7, number: 200001, priceUnit: 10000, name: "bingo 2", date: DateTime(2022, 12, 7),),
    BingoTicketModel(id: 8, number: 201111, priceUnit: 10000, name: "bingo 2", date: DateTime(2022, 12, 7),),
    BingoTicketModel(id: 9, number: 202321, priceUnit: 10000, name: "bingo 2", date: DateTime(2022, 12, 7),),
    BingoTicketModel(id: 10, number: 300001, priceUnit: 10000, name: "bingo 2", date: DateTime(2022, 12, 7),),
    BingoTicketModel(id: 11, number: 300326, priceUnit: 10000, name: "bingo 2", date: DateTime(2022, 12, 7),),
    BingoTicketModel(id: 12, number: 303237, priceUnit: 10000, name: "bingo 2", date: DateTime(2022, 12, 7),),
    BingoTicketModel(id: 13, number: 400466, priceUnit: 10000, name: "bingo 2", date: DateTime(2022, 12, 7),),
    BingoTicketModel(id: 14, number: 500051, priceUnit: 10000, name: "bingo 2", date: DateTime(2022, 12, 7),),
    BingoTicketModel(id: 15, number: 500006, priceUnit: 10000, name: "bingo 2", date: DateTime(2022, 12, 7),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //Cambien el Text por su Widget.
              _spaceBetweenProyects(),
              CustomButtonLhaka(
                text: 'Lhaka',
                iconData: Icons.android,
                backgroundColor: Colors.orangeAccent,
                textStyle: const TextStyle(
                    letterSpacing: 3, fontWeight: FontWeight.w800),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              _spaceBetweenProyects(),
              CustomButtonBingo(),
              _spaceBetweenProyects(),
              CustomCounterAndPriceCalculator(
                bingoTicketModel: bingo1,
                valueMax: 10,
                getShop: (amount, total) => {print('$amount $total')},
                label: 'Cantidad de Cartones',
              ),
              _spaceBetweenProyects(),
              CustomBingoHype(backgroundColor: Colors.grey, listMarbles: [
                Marble(number: 77, color: Colors.red),
                Marble(number: 3, color: Colors.purple),
                Marble(number: 29, color: Colors.amber),
                Marble(number: 33, color: Colors.green),
                Marble(number: 22, color: Colors.yellow),
                Marble(number: 4, color: Colors.redAccent),
                Marble(number: 9, color: Colors.blue),
                Marble(number: 60, color: Colors.indigo),
                Marble(number: 66, color: Colors.orange),
                Marble(number: 35, color: Colors.teal),
                Marble(number: 5, color: Colors.lightGreen),
                Marble(number: 90, color: Colors.pink),
                Marble(number: 28, color: Colors.tealAccent)
              ]),
              _spaceBetweenProyects(),
              const BingoCard(
                numbersList: [
                  1,
                  2,
                  3,
                  4,
                  5,
                  6,
                  7,
                  8,
                  9,
                  10,
                  11,
                  12,
                  13,
                  14,
                  15,
                  16,
                  17,
                  18,
                  19,
                  20,
                  21
                ],
              ),
              _spaceBetweenProyects(),
              ListWheelHorizontal(height: 500, cards: [
                Cards(
                  directory: 'assets/pngwing.com.png',
                  text: 'La Merced',
                  action: () {},
                ),
                Cards(
                  directory: 'assets/74297472_p0_master1200.jpg',
                  text: 'Vaqueros',
                  action: () {},
                ),
                Cards(
                  directory: 'assets/pngwingPaint.png',
                  text: 'Cerrillos',
                  action: () {},
                ),
                Cards(
                  directory: 'assets/74297472_p0_master1200.jpg',
                  text: 'Groenlandia',
                  action: () {},
                ),
                Cards(
                  directory: 'assets/pngwing.com.png',
                  text: 'siiiiii',
                  action: () {},
                ),
              ]),
              _spaceBetweenProyects(),
              CustomFilter(
                  color: Colors.teal.shade400,
                  items: filtros,
                  onTap: (lista) {
                    print(lista);
                  }),
              _spaceBetweenProyects(),
              FoldingCardboardComponentCustom(
                bingoTicketModel: BingoTicketFoldingCardboardModel(
                  number: 106044,
                  numberList: [
                    54,
                    4,
                    55,
                    33,
                    97,
                    40,
                    44,
                    1,
                    15,
                    3,
                    83,
                    30,
                    12,
                    53,
                    22,
                    28,
                    36,
                    23,
                    78,
                    71,
                    37,
                    35,
                    82,
                    13,
                    11,
                    69,
                    90,
                    79,
                    2,
                    89,
                    84,
                    20,
                    34
                  ],
                ),
              ),
              _spaceBetweenProyects(),
              CustomCard(
                bingo: bingo1,
                shoppIt: shopp,
                stateFavorite: favorite,
                shareIt: share,
              ),
              _spaceBetweenProyects(),
              Container(
                width: 400,
                child: DropDown(
                    info: DropDownInfo(
                  leadingIcon: Icons.emoji_events_outlined,
                  title: "Descripcion",
                  info: "Lorem ipsum dolor sit amet, canim id est laborum.",
                  image: "assets/74297472_p0_master1200.jpg",
                  price: "\$ 500 ",
                  date: DateTime(2022, 11, 17, 19, 00),
                  bingoName: "juntos por el fuchiboll ",
                  trailingSize: 100,
                )),
              ),
              _spaceBetweenProyects(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MySecondPage(title: 'Pop Up')),
                    );
                  },
                  child: Text('Pop Up')),
              _spaceBetweenProyects(),
              TutorialComponent(
                  tutorialItem: tutorialList,
                  pageDestiny: const PageDestinyExample()),
              _spaceBetweenProyects(),
              ElevatedButton(
                child: const Text("Abrir dialogo"),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => WorkSchedule(
                            employee: Employee(
                                id: 22,
                                name: "Juliana Estafanía Martínez",
                                imageURL:
                                    'https://i0.wp.com/infosal.es/wp-content/uploads/2020/03/BINGO.jpg?fit=2000%2C2000&ssl=1'),
                            items: [
                              WorkArea(id: 1, name: "Corte"),
                              WorkArea(id: 2, name: "Costura"),
                              WorkArea(id: 3, name: "Diseño"),
                              WorkArea(id: 4, name: "Revision"),
                            ],
                            getEmployee: () {},
                            colorPrimary: Colors.teal.shade600,
                            colorSecundary: Colors.teal.shade100,
                          ));
                },
              ),
              _spaceBetweenProyects(),
              CustomUserLoginBingo(
                onTapLogin: (user) {
                  print("${user.mail} ${user.password}");
                },
                onTapForgotPassword: () {
                  print("Hicieron Click en Olvidaste Tu Contraseña");
                },
                onTapRegisterFacebook: () {
                  print("Hicieron Click en Ingresar con Facebook");
                },
                onTapRegisterGoogle: () {
                  print("Hicieron Click en Ingresar con Google");
                },
                onTapRegisterHere: () {
                  print("Hicieron Click en Registrate Aquí");
                },
              ),
              _spaceBetweenProyects(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: UserProfile(model: personaNN),
              ),
              _spaceBetweenProyects(),
              CustomButtonBingo(
                text: "Work Calendar",
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return WorkCalendarComponent(
                        employee: Employee(
                            id: 22,
                            name: "Juliana Estafanía Martínez",
                            imageURL:
                                'https://i0.wp.com/infosal.es/wp-content/uploads/2020/03/BINGO.jpg?fit=2000%2C2000&ssl=1'),
                        salary: Salary(
                            id: 69, dailySalary: 420, totalSalary: 10000),
                        tasks: [
                          Task(
                              procedure: "Costura",
                              product: "Barbijo",
                              amount: 17),
                          Task(
                              procedure: "Costura",
                              product: "Barbijo",
                              amount: 17),
                          Task(
                              procedure: "Costura",
                              product: "Barbijo",
                              amount: 17),
                          Task(
                              procedure: "Costura",
                              product: "Barbijo",
                              amount: 17),
                          Task(
                              procedure: "Costura",
                              product: "Barbijo",
                              amount: 17),
                          Task(
                              procedure: "Costura",
                              product: "Barbijo",
                              amount: 17),
                          Task(
                              procedure: "Costura",
                              product: "Barbijo",
                              amount: 17),
                          Task(
                              procedure: "Costura",
                              product: "Barbijo",
                              amount: 17),
                          Task(
                              procedure: "Costura",
                              product: "Barbijo",
                              amount: 17),
                          Task(
                              procedure: "Costura",
                              product: "Barbijo",
                              amount: 17),
                          Task(
                              procedure: "Costura",
                              product: "Barbijo",
                              amount: 17),
                          Task(
                              procedure: "Costura",
                              product: "Barbijo",
                              amount: 17),
                        ],
                      );
                    },
                  );
                },
              ),
              _spaceBetweenProyects(),
              BingoSelector(list: bingoList,),
              _spaceBetweenProyects(),
            Container(

              height: 400,
              child: Search(onSelectedFilterChange: () => print("on tap filtro "),
                list:
              [ PersonSearchModel(name: "Juliana Estefanía Martínez", id: 1, image: 'https://i0.wp.com/www.diarlu.com/wp-content/uploads/2019/09/rostro-mujer-adulta.jpg?resize=500%2C500&ssl=1'),
                PersonSearchModel(name: "Victor Martín Ríos", id: 5, image: 'https://i0.wp.com/www.diarlu.com/wp-content/uploads/2019/09/rostro-mujer-adulta.jpg?resize=500%2C500&ssl=1'),
                PersonSearchModel(name: "Silvana Enriquez", id: 6),
                PersonSearchModel(name: "Camila Herrera", id: 7),
                PersonSearchModel(name: "Esteban", id: 87),
                PersonSearchModel(name: "Juan perez", id: 8, image:"https://i0.wp.com/www.diarlu.com/wp-content/uploads/2019/09/rostro-mujer-adulta.jpg?resize=500%2C500&ssl=1'"),
                PersonSearchModel(name: "Leo", id: 1),
                PersonSearchModel(name: "sssdaw", id: 9),],onSelectedPersonChange: (person) => print("name: ${person.name}"),),
            ),
              _spaceBetweenProyects(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _spaceBetweenProyects() {
    return const SizedBox(
      height: 20,
    );
  }
}

class PageDestinyExample extends StatefulWidget {
  const PageDestinyExample({Key? key}) : super(key: key);

  @override
  State<PageDestinyExample> createState() => _PageDestinyExampleState();
}

class _PageDestinyExampleState extends State<PageDestinyExample> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: CustomButtonBingo(
            text: "volver a la pagina principal",
            textSize: 12,
            icon: Icons.restore_outlined,
            onTap: _controllerRestore,
          ),
        ),
      ),
    );
  }

  void _controllerRestore() {
    setState(() {
      final route = MaterialPageRoute(builder: (BuildContext context) {
        return const MyHomePage(title: 'PowerUp Flutter PlayGround');
      });
      Navigator.of(context).push(route);
    });
  }
}
