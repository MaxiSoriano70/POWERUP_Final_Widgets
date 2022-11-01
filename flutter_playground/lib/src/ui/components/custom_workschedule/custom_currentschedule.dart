import 'package:flutter/material.dart';

class CurrentSchedule extends StatefulWidget {
  Color? backgroundColor;
  double? heightSlots;
  double? widthSlots;
  Color primaryColor;
  double fontSize;
  Function getTimeNow;
  late DateTime timeNow = DateTime.now();
  CurrentSchedule({
    Key? key,
    this.backgroundColor = Colors.white,
    this.heightSlots = 50,
    this.widthSlots = 100,
    this.primaryColor = Colors.teal,
    this.fontSize = 30,
    required this.getTimeNow,
  }) : super(key: key);

  @override
  State<CurrentSchedule> createState() => _CurrentScheduleState();
}

class _CurrentScheduleState extends State<CurrentSchedule> {
  bool isAm = true;

  void initState() {
    // TODO: implement initState
    super.initState();
    widget.timeNow = DateTime.now();
    widget.getTimeNow(widget.timeNow);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Column(
        children: [
          _timeBuilder(),
        ],
      ),
    );
  }

  Widget _timeBuilder() {
    late int timeHour;
    if (widget.timeNow.hour > 12 && widget.timeNow.hour != 0) {
      timeHour = widget.timeNow.hour - 12;
    } else if (widget.timeNow.hour == 0) {
      timeHour = 12;
    } else {
      timeHour = widget.timeNow.hour;
    }
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(timeHour.remainder(60));
    final minutes = twoDigits(widget.timeNow.minute.remainder(60));
    if (widget.fontSize <= 10) {
      widget.fontSize = 15;
    }

    if (widget.heightSlots! < 20) {
      widget.heightSlots = 20;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _slotBuilder(hours),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Text(
            ':',
            style: TextStyle(
                fontSize: widget.fontSize + 0.5,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        _slotBuilder(minutes),
        const SizedBox(
          width: 20,
        ),
        _amAndPmButtons()
      ],
    );
  }

  Widget _slotBuilder(String time) {
    return Container(
      height: widget.heightSlots,
      width: widget.widthSlots,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        border: Border.all(color: widget.primaryColor, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
          child: Text(time,
              style:
                  TextStyle(fontSize: widget.fontSize, color: Colors.black))),
    );
  }

  Widget _amAndPmButtons() {
    if (widget.timeNow.hour >= 12) {
      isAm = false;
    } else {
      isAm = true;
    }

    return isAm
        ? Row(
            children: [
              _switchBuilder(
                  widget.heightSlots,
                  widget.primaryColor,
                  const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4)),
                  'AM',
                  widget.backgroundColor),
              _switchBuilder(
                  widget.heightSlots,
                  Colors.transparent,
                  const BorderRadius.only(
                      topRight: Radius.circular(4),
                      bottomRight: Radius.circular(4)),
                  'PM',
                  Colors.black)
            ],
          )
        : Row(
            children: [
              _switchBuilder(
                  widget.heightSlots,
                  Colors.transparent,
                  const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4)),
                  'AM',
                  Colors.black),
              _switchBuilder(
                  widget.heightSlots,
                  widget.primaryColor,
                  const BorderRadius.only(
                      topRight: Radius.circular(4),
                      bottomRight: Radius.circular(4)),
                  'PM',
                  widget.backgroundColor)
            ],
          );
  }

  Widget _switchBuilder(double? height, Color? color,
      BorderRadiusGeometry? borderRadius, String text, Color? colorText) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.grey.shade700),
        borderRadius: borderRadius,
      ),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Text(text,
            style: TextStyle(
              fontSize: widget.fontSize - 4,
              color: colorText,
            )),
      )),
    );
  }
}
