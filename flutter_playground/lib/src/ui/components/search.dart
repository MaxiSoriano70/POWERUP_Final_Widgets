import 'package:flutter/material.dart';

import '../../models/person_search_model.dart';


///-----INFO-----
///
/// integrantes:
///             Coronel, Benjamín Leonel
///             Herrera, Camila
///             Rodriguez, Esteban Ernesto
///
/// Este widget requiere una lista de personas en el cual se puede buscar por nombre, filtrar  para la busqueda
/// y seleccionar un elemento de la lista y debuelve un modelo person selecionado
///
/// Cuenta con un botón de filtro de debuelve su onpres
/// NOta: enm el caso de no recivir imagen el widgwt cuenta con una imagen por defecto
/// modelo: recive imagen y nombre
///
/// Nota: por contar con una ListView.builder() es nesesario que se le asige una altura (height).
///
class Search extends StatefulWidget {
  Function( PersonSearchModel person)?  onSelectedPersonChange ;
  Function( )?  onSelectedFilterChange ;
  List<PersonSearchModel> list;
  ///-----INFO-----
  ///
  /// integrantes:
  ///             Coronel, Benjamín Leonel
  ///             Herrera, Camila
  ///             Rodriguez, Esteban Ernesto
  ///
  /// Este widget requiere una lista de personas en el cual se puede buscar por nombre, filtrar  para la busqueda
  /// y seleccionar un elemento de la lista y debuelve un modelo person selecionado
  ///
  /// Cuenta con un botón de filtro de debuelve su onpres
  /// NOta: enm el caso de no recivir imagen el widgwt cuenta con una imagen por defecto
  /// modelo: recive imagen y nombre
  ///
  /// Nota: por contar con una ListView.builder() es nesesario que se le asige una altura (height).
  ///

  Search({Key? key , this.onSelectedPersonChange , this.onSelectedFilterChange, required this.list}) : super(key: key);


  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool colors=false;
  List<PersonSearchModel> listAux = [];
  initState(){
    super.initState();
    listAux =  List.from( widget.list);
  }


  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: const BoxDecoration(color: Colors.white),
      child:  Column(
          children: [
            const SizedBox(height: 20),
            const Text("Socios",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15),
            ),
            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                   Expanded(
                     child: TextField(
                       onChanged: (value) => _filter(value),
                       cursorColor: Colors.grey,
                       cursorHeight: 16,
                       textAlign: TextAlign.justify,
                       decoration: const InputDecoration(
                         labelText: "Buscar socios",
                         labelStyle: TextStyle(fontSize: 13),
                         floatingLabelBehavior: FloatingLabelBehavior.never,
                         constraints: BoxConstraints(maxHeight: 30),
                         suffixIcon: Icon(
                             Icons.search,
                             color: Colors.black54,
                             size: 25)  ,
                         filled: true,
                         fillColor: Colors.white,
                         enabledBorder: OutlineInputBorder(
                             borderSide: BorderSide(
                               width: 1.0,
                                 color: Colors.grey),
                             borderRadius: BorderRadius.all(
                                 Radius.circular(5))
                         ),
                         focusedBorder: OutlineInputBorder(
                             borderSide: BorderSide(
                                 color: Colors.grey),
                             borderRadius: BorderRadius.all(
                                 Radius.circular(5))
                         ),
                       ),
                     ),
                   ),
                  //const SizedBox(width: 5,),
                  IconButton(onPressed: () {
                    widget.onSelectedFilterChange!();
                  }, icon: const Icon(
                      Icons.filter_alt_outlined),
                    color: Colors.black54,
                    iconSize: 25,)
                ],
              ),
            ),
            const SizedBox(height: 15,),
            Expanded(
              child: ListView.builder(
                itemCount: listAux.length,
                itemBuilder: (context, index) {
                  return _ficha(listAux[index]);
                  }
              ,),
            )
          ],
        ),
    ) ;
  }

 _ficha(PersonSearchModel person){
    return Container(
      decoration:  BoxDecoration(
          color: person.isSelcted? Colors.grey.shade300  : Colors.white ,
          border: const  Border(
              top:BorderSide(
                  color: Colors.grey,
                  width: 1)
          )
      ),
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Center(
          child: ListTile(

            onTap: () {
              listAux.forEach((element) {element.isSelcted = false;});

              setState(() {
                person.isSelcted=!person.isSelcted;
                widget.onSelectedPersonChange!(person) ;
              });
            },
            title: Text(person.name, style: const TextStyle(fontSize: 13),),
            leading: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(40)),
                child: _image(person),)
          ),
        ),
      ),
    );
  }
    _image(PersonSearchModel persona){
     if(persona.image == null){
      return const Icon(Icons.person, size: 35,);
      }else{
      return Image.network(persona.image!,width: 35,height: 35);
    }
  }
    _filter(String value){
      setState(() {
        listAux = widget.list.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
      });
  }


}


