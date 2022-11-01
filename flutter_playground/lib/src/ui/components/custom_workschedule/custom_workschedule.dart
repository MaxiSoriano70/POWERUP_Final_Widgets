import 'package:flutter/material.dart';
import 'package:flutter_playground/src/models/employee_model.dart';
import 'package:flutter_playground/src/models/work_area_model.dart';
import 'package:flutter_playground/src/ui/components/custom_button_lhaka.dart';
import 'package:flutter_playground/src/ui/components/custom_workschedule/custom_currentschedule.dart';
import 'package:flutter_playground/src/ui/components/custom_workschedule/custom_dropdown.dart';

// ignore: must_be_immutable
class WorkSchedule extends StatefulWidget {
  late Employee employee;
  final Color colorPrimary;
  final Color colorSecundary;
  final List<WorkArea> items;
  final Function getEmployee;

  ///________________________________INFO_______________________________________
  ///
  /// Equipo: Alvarez, Diaz Benjamin; Fadel, Nicolas; Apaza,Celina Daniela ;
  ///
  /// Este widget, es pop up que permite asignar la hora de inicio de un trabajador
  /// y su área de trabajo.
  /// Requiere de un modelo del tipo Empoyee (trabajador) y una lista de WorkArea
  /// (Areas de trabajo).
  /// Puede recibir dos colores, uno que se aplica en los margenes de sus componenetes
  /// y en el botón principal, y otro que sombre un icono.
  ///Tambien requiere de una función para poder obtener el trabajador que se paso
  /// por parametro con su hora de inicio y area de trabajo.
  ///

  WorkSchedule(
      {required this.employee,
      required this.items,
      this.colorPrimary = Colors.teal,
      this.colorSecundary = Colors.tealAccent,
      required this.getEmployee,
      Key? key})
      : super(key: key);

  timeNow(DateTime timeNow) {
    employee.startTime = timeNow;
  }

  theSelected(WorkArea workArea) {
    employee.workArea = workArea;
  }

  @override
  State<WorkSchedule> createState() => _WorkScheduleState();
}

class _WorkScheduleState extends State<WorkSchedule> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(0),
      content: Stack(
        children: [
          Container(
            width: 400,
            height: 360,
            padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                profile(),
                const SizedBox(height: 8),
                Divider(
                  height: 10,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 25),
                title(),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: CurrentSchedule(
                    getTimeNow: widget.timeNow,
                    heightSlots: 30,
                    widthSlots: 60,
                    fontSize: 17,
                    primaryColor: widget.colorPrimary,
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Expanded(flex: 3, child: SizedBox()),
                  SizedBox(
                      width: 80,
                      child: Text(
                        "Hora   ",
                        style: TextStyle(
                            fontSize: 11, color: Colors.grey.shade600),
                      )),
                  SizedBox(
                      width: 80,
                      child: Text(
                        "Minutos",
                        style: TextStyle(
                            fontSize: 11, color: Colors.grey.shade600),
                      )),
                  const Expanded(flex: 8, child: SizedBox())
                ]),
                const SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      "Área de trabajo",
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey.shade800),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: DropdownCustom(
                    items: widget.items,
                    theSelected: widget.theSelected,
                    height: 30,
                    widht: 300,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                buttonToAccept(),
                const SizedBox(
                  height: 35,
                ),
              ],
            ),
          ),
          Positioned(
            top: 1,
            right: 1,
            child: closeButton(),
          ),
        ],
      ),
    );
  }

  Widget profile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        profilePicture(),
        const SizedBox(width: 5),
        Text(
          widget.employee.name,
          style: const TextStyle(
              fontWeight: FontWeight.w400, fontSize: 13, letterSpacing: 0.5),
        ),
      ],
    );
  }

  Widget profilePicture() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(35),
      child: SizedBox.square(
          dimension: 35,
          child: Image.network(
            widget.employee.imageURL,
            fit: BoxFit.cover,
          )),
    );
  }

  Widget title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: widget.colorSecundary,
            ),
            child: Center(
                child: Icon(
              Icons.play_arrow,
              color: widget.colorPrimary,
              size: 15,
            ))),
        const SizedBox(width: 8),
        Text("INICIAR TURNO",
            style: TextStyle(
                color: widget.colorPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 13,
                letterSpacing: 0.5)),
      ],
    );
  }

  Widget buttonToAccept() {
    return SizedBox(
      width: 170,
      child: CustomButtonLhaka(
        text: "Aceptar",
        backgroundColor: widget.colorPrimary,
        onTap: () {
          Navigator.pop(context);
          widget.getEmployee(widget.employee);
        },
      ),
    );
  }

  Widget closeButton() {
    return IconButton(
      padding: EdgeInsets.only(top: 10, right: 10, left: 20),
      icon: Icon(Icons.close, color: Colors.grey.shade600),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
