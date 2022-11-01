import 'package:flutter/material.dart';
import '../../models/person_model.dart';
import 'custom_button_bingo.dart';

class UserProfile extends StatefulWidget {
  final PersonModel? model;
  ///---INFO---
  ///
  /// Equipo: Caliva, Gastón Rafael ; Chaile Zelada, Micaela Rita Ivana ; Paz Gerez, Leonel
  ///
  /// Este widget consiste en un formulario, que en caso de recibir un modelo existente (PersonModel), autocompleta
  /// los campos vacios. Además posee un control de ingreso que habilita el botón de guardado solo en caso de que todos los campos
  /// del formulario hayan sido correctamente rellenados por el usuario.

  const UserProfile({Key? key, this.model}) : super(key: key);
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  List<String> locationList = [
    'Salta',
    'Joaquin V. Gonzalez',
    'Quebrachal',
    'Metan',
    'Cachi'
  ];

  final double paddingVertical = 8;
  final double paddingHorizontal = 16;
  final double borderRadiusTextForm = 12;
  final double sizeTextForm = 14;
  String dropDownValue = '';
  bool iconEyeNewPassword = false;
  bool iconEyeConfirmPassword = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameAndSurnameController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dniController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isEnabled = false;

  @override
  void initState() {
    super.initState();
    nameAndSurnameController.text = ('${widget.model!.name} ${widget.model!.surname}');
    emailController.text = widget.model!.email;
    dniController.text = widget.model!.dni.toString();
    phoneController.text = widget.model!.phoneNumber.toString();
    nameAndSurnameController.addListener(() {});
    emailController.addListener(() {});
    dniController.addListener(() {});
    phoneController.addListener(() {});
    newPasswordController.addListener(() {});
    confirmPasswordController.addListener(() {});
  }
  @override
  void setState(VoidCallback fn) {
    if(nameAndSurnameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        dniController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      isEnabled = true;
    }else{
      isEnabled = false;
    }
    super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
    nameAndSurnameController.dispose();
    emailController.dispose();
    dniController.dispose();
    phoneController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  isTapIconEyeNewPassword() {
    iconEyeNewPassword = !iconEyeNewPassword;
  }

  isTapIconEyeConfirmPassword() {
    iconEyeConfirmPassword = !iconEyeConfirmPassword;
  }

  String? emailValidator(email) {
    if (email == null || email.isEmpty) {
      return 'E-mail es requerido';
    }
    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email)) return 'Formato Incorrecto de E-mail';
    return null;
  }

  String? dniValidator(dni) {
    if (dni == null || dni.isEmpty) {
      return 'DNI es requerido';
    } else if (dni.length > 9 && dni.length < 12) {
      return 'DNI es incorrecto';
    }
    return null;
  }

  String? phoneValidator(phone) {
    if (phone == null || phone.isEmpty) {
      return 'Numero de celular es requerido';
    } else if (phone.length > 10 && phone.length < 13){
      return 'Numero incorrecto';
    }
    return null;
  }

  String? newPasswordValidator(newPassword) {
    if (newPassword == null || newPassword.isEmpty) {
      return 'Contraseña requerida';
    } else if (newPassword.length < 8) {
      return 'Debe tener un minimo de 8 caracteres';
    }
    return null;
  }

  String? nameValidator(name) {
    if (name == null || name.isEmpty) {
      return 'Nombre y apellido requerido';
    }
    return null;
  }

  String? confirmPasswordValidator(confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Contraseña requerida';
    }
    if (confirmPassword.length < 8) {
      return 'Debe tener un minimo de 8 caracteres';
    }
    if (newPasswordController.text != confirmPasswordController.text) {
      return 'Contraseñas no coinciden';
    }
    return null;
  }

  void onTapIconInfo() {
    const snackBar = SnackBar(
      content: Text('Ingrese su nueva contraseña'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void onTapIconEyeNewPassword() {
    setState(() {
      isTapIconEyeNewPassword();
    });
  }

  void onTapIconEyeConfirmPassword() {
    setState(() {
      isTapIconEyeConfirmPassword();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: _customTitleTextForm(
              title: "Editar perfil",
              fontSize: 18,
            ),
          ),
          _customTitleTextForm(title: "Nombre y apellido"),
          _customTextFormField(
              controller: nameAndSurnameController,
              hintText: "Adoración Rosa...",
              // initialValue: nameAndSurnameController.text,
              validator: nameValidator),
          _customTitleTextForm(title: "Email"),
          _customTextFormField(
            controller: emailController,
            hintText: "adoracion.rosa@gmail.com...",
            keyboardType: TextInputType.emailAddress,
            // initialValue: widget.model!.email,
            validator: emailValidator,
          ),
          _customTitleTextForm(title: "DNI"),
          _customTextFormField(
              controller: dniController,
              hintText: "9.955.976...",
              // initialValue: widget.model!.dni.toString(),
              keyboardType: TextInputType.number,
              validator: dniValidator),
          _customTitleTextForm(title: "Localidad"),
          _customDropDownButton(locationList, widget.model!.location),
          _customTitleTextForm(title: "Celular"),
          _customTextFormField(
              controller: phoneController,
              hintText: "387678953...",
              validator: phoneValidator,
              keyboardType: TextInputType.number),
          _customTitleTextForm(title: "Cambiar contraseña"),
          _customTextFormFieldWithIcons(
            hintText: "Nueva contraseña",
            iconEye: true,
            iconInfo: true,
            isTapIcon: iconEyeNewPassword,
            onTapInfo: onTapIconInfo,
            onTapEye: onTapIconEyeNewPassword,
            initialValue: null,
            validator: newPasswordValidator,
            controller: newPasswordController,
          ),
          _customTextFormFieldWithIcons(
            hintText: "Repetir contraseña nueva",
            iconEye: true,
            isTapIcon: iconEyeConfirmPassword,
            onTapEye: onTapIconEyeConfirmPassword,
            initialValue: null,
            validator: confirmPasswordValidator,
            controller: confirmPasswordController,
          ),
          _customButton(
            text: "Guardar",
            backgroundColor: const Color(0xFF0000CC),
            height: 36,
            width: 300,
            textSize: 16,
            textWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ],
      ),
    );
  }

  Widget _customButton(
      {String? text = "",
        Color? backgroundColor = const Color(0xFF0000FF),
        double? height = 30,
        double? width = 200,
        double? textSize = 20,
        FontWeight? textWeight = FontWeight.w500,
        double? letterSpacing = 3,
      }) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: CustomButtonBingo(
          isEnabled: isEnabled,
          width: width!,
          text: text!,
          onTap: isEnabled ? () {
            setState(() {
              if (formKey.currentState!.validate()) {
                print("OOOOOK");
              } else {
                print("Noooo OK");
              }
            });
          } : null,
          backgroundColor: backgroundColor!,
          height: height!,
          textSize: textSize!,
          textWeight: textWeight!,
          letterSpacing: letterSpacing!,
        ),
      ),
    );
  }

  Widget _customTitleTextForm({required String title, double? fontSize = 14}) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
        color: Colors.grey.shade700,
      ),
    );
  }

  Widget _customTextFormFieldWithIcons({
    required String hintText,
    TextInputType? keyboardType = TextInputType.text,
    String? initialValue = "",
    void Function()? onTapInfo,
    void Function()? onTapEye,
    bool? iconInfo = false,
    bool? iconEye = false,
    bool? isTapIcon = false,
    required TextEditingController controller,
    String? Function(String?)? validator,
    double? fontSize = 14,
    double? sizeIcon = 18,
  }) {
    IconData icon = Icons.visibility_outlined;
    if (isTapIcon != null) {
      icon =
      isTapIcon ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    }
    bool obscureText = !isTapIcon!;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadiusTextForm),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: paddingVertical,
      ),
      child: Row(children: [
        Expanded(
          child: TextFormField(
            onChanged: (text) {
              setState(() {
                //print("campo $text");
              });
            },
            validator: validator,
            controller: controller,
            initialValue: initialValue,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration.collapsed(
              hintText: hintText,
              hintStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
        Visibility(
          visible: iconInfo!,
          child: GestureDetector(
            onTap: onTapInfo,
            child: Icon(
              Icons.info_outline,
              size: sizeIcon,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Visibility(
          visible: iconEye!,
          child: GestureDetector(
            onTap: onTapEye,
            child: Icon(
              icon,
              size: sizeIcon,
              color: Colors.grey.shade600,
            ),
          ),
        )
      ]),
    );
  }

  Widget _customTextFormField({
    required String hintText,
    String? initialValue,
    TextInputType? keyboardType = TextInputType.text,
    bool? obscureText,
    String? Function(String?)? validator,
    double? fontSize = 14,
    TextEditingController? controller,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (text) {
          setState(() {
          });
        },
        controller: controller,
        keyboardType: keyboardType,
        initialValue: initialValue,
        style: TextStyle(fontSize: fontSize),
        obscureText: !(obscureText == null),
        decoration: InputDecoration.collapsed(
          hintText: hintText,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: fontSize,
          ),
        ),
        validator: validator,
      ),
    );
  }

  Widget _customDropDownButton(List<String> list, String currentLocation) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: DropdownButtonFormField(
        borderRadius: BorderRadius.circular(12),
        decoration: const InputDecoration.collapsed(hintText: 'hit'),
        icon: const Icon(Icons.arrow_drop_down_sharp),
        value:
        "Cachi", //currenhtLocation // algoo como list.elementAt(list.getIndexOf(currenhtLocation))
        onChanged: (String? newValue) {
          setState(() {
            //print("campo $newValue");
            dropDownValue = newValue!;
          });
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: EdgeInsets.zero,
              child: Text(
                value,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
