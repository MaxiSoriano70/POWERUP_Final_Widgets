import 'package:flutter_playground/src/models/work_area_model.dart';

class Employee {
  final int id;
  final String name;
  final String imageURL;
  late DateTime? startTime;
  late DateTime? endTime;
  late WorkArea workArea;

  Employee({
    required this.id,
    required this.name,
    required this.imageURL,
  });
}
