import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import 'custom_button_bingo.dart';

class CustomUserLoginBingo extends StatefulWidget {
  final Function(User)? onTapLogin;
  final Function()? onTapForgotPassword;
  final Function()? onTapRegisterFacebook;
  final Function()? onTapRegisterGoogle;
  final Function()? onTapRegisterHere;

  ///==========CustomUserLoginBingo ==========
  ///
  ///Grupo 2 Semana 3
  ///
  ///Integrantes:
  ///
  ///- Alvarez, Ana Victoria
  ///
  ///- Soriano, Maximiliano
  ///
  /// - Pistan, Renso
  ///
  /// CustomUserLoginBingo es un widget el cual tiene el propósito de acceder a una aplicación ya sea por
  /// primera vez, ademas se puede acceder con google y facebook o tambien se accede con su usuario habitual.
  /// Devuelve como parámetros un modelo de Usuario (email y contraseña) y recibe como
  /// funciones una acción para cuando se accione los botones  ¿Olvidaste tu contraseña?(onTapForgotPassword) ,
  /// facebook (onTapRegisterFacebook), google (onTapRegisterGoogle) y el botón de crear un usuario por
  /// primera vez (onTapRegisterHere).
  ///

  const CustomUserLoginBingo({Key? key,this.onTapLogin,this.onTapForgotPassword,this.onTapRegisterFacebook,this.onTapRegisterGoogle,this.onTapRegisterHere
  }) : super(key: key);

  @override
  State<CustomUserLoginBingo> createState() => _CustomUserLoginBingoState();
}

class _CustomUserLoginBingoState extends State<CustomUserLoginBingo> {

  late User user;
  late String mailUser;
  late String password;

  bool isHover = false;
  bool isEnable = true;

  final formKey=GlobalKey<FormState>();

  void showValues(BuildContext context){
    //ESTO VALIDA SI ES NULL
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      user=User(mailUser, password);
      widget.onTapLogin!(user);
    }
  }

  getEnable() {
    return isEnable;
  }

  @override
  Widget build(BuildContext context) {
    return loginUser();
  }

  Widget loginUser(){
    double width=MediaQuery.of(context).size.width;
    return SizedBox(
      width: width*0.8,
      child: Column(
        children: [
          //MATERIAL
          cardRegister(width),
          const SizedBox(height: 20,),
          //INGRESAR CON
          titleEnterWith(),
          const SizedBox(height: 20,),
          //BUTTONS
          registerWithNetworks(),
          const SizedBox(height: 20,),
          //REGISTRATE AQUI
          registerHere(),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }

  Widget cardRegister(double width){
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(32)),
      shadowColor: Colors.grey,
      elevation: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 30),
        child: registerUser(),
      ),
    );
  }

  Widget registerUser() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //CORREO
          TextFormField(
            onSaved: (value){
              mailUser=value!;
            },
            validator: (value){
              if(value!.isEmpty){
                return "*Campo Obligatorio";
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              hintText: "Correo",
              contentPadding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
              filled: true,
              fillColor: const Color(0xffedfafd),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20)
              ),
            ),
            style: const TextStyle(
                color: Colors.black,
                fontSize: 16),
          ),
          const SizedBox(height: 20,),

          //CONTRASEÑA
          TextFormField(
              onSaved: (value){
                password=value!;
              },
              validator: (value){
                if(value!.isEmpty){
                  return "*Campo Obligatorio";
                }
                return null;
              },
              obscureText: getEnable(),
              cursorColor: Colors.black,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16),
              decoration: InputDecoration(
                  hintText: "Contraseña",
                  contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  filled: true,
                  fillColor: const Color(0xffedfafd),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  suffixIcon:  Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: AnimatedIconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        icons: [
                          AnimatedIconItem(
                            icon: const Icon(
                              Icons.visibility_off_outlined,
                              size: 18,
                              color: Colors.grey,
                            ),
                            onPressed: () => setState(() {
                              isEnable = false;
                            }),
                            backgroundColor: Colors.transparent,),
                          AnimatedIconItem(
                            icon: const Icon(
                              Icons.remove_red_eye_outlined,
                              size: 18,
                              color: Colors.grey,
                            ),
                            onPressed: () => setState(() {
                              isEnable = true;
                            }),
                            backgroundColor: Colors.transparent,)
                        ],
                      )
                  ))),
          const SizedBox(height: 20,),

          //OLVIDASTE TU CONTRASEÑA
          forgotPassword(),
          const SizedBox(height: 30,),
          CustomButtonBingo(
            text: 'Ingresar',
            backgroundColor: Colors.teal,
            onTap: (){
              showValues(context);
            },
            height: 45,
            width: 390,
            textSize: 17,
          ),
        ],
      ),
    );
  }

  Widget forgotPassword() {
    return MouseRegion(
      onEnter: (e){
        setState(() {
          isHover=true;
        });
      },
      onExit: (e){
        setState(() {
          isHover=false;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: InkWell(
          onTap: (){
            widget.onTapForgotPassword!();
          },
          hoverColor: Colors.white,
          child: Text("¿Olvidaste tu contraseña?",style: TextStyle(color: isHover?Colors.black:Colors.grey),),
        ),
      ),
    );
  }

  Widget titleEnterWith(){
    return const Text("Ingresar con",
      style:TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
    );
  }

  Widget registerWithNetworks(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomButtonBingo(
              text: '',
              icon: EvaIcons.facebook,
              backgroundColor: Colors.indigo,
              onTap:  (){
                widget.onTapRegisterFacebook!();
              },
              height: 40,
              width: MediaQuery.of(context).size.width*0.45/2.5,
              iconSize: 25,
            ),
          ),
          const SizedBox(width: 20,),
          Expanded(
              child: CustomButtonBingo(
                text: '',
                icon: EvaIcons.google,
                backgroundColor: Colors.red,
                onTap:  (){
                  widget.onTapRegisterGoogle!();
                },
                height: 40,
                width: MediaQuery.of(context).size.width*0.45/2.5,
                iconSize: 25,
              )
          ),
        ],
      ),
    );
  }

  Widget registerHere() {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Si no tenés cuenta ",
          style:TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
        InkWell(
          onTap: (){
            widget.onTapRegisterHere!();
          },
          child: const Text("registrate aquí",
              style:TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              )
          ),
        )
      ],
    );
  }
}
