import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reclamations/presentation/ressources/dimensions/constants.dart';

class Inputfield extends StatefulWidget {
  final String label;
  final Widget prefixIcon;
  final TextInputType textInputType;
  final TextEditingController controller;
 // final Widget? suffixIcon;
  const Inputfield({super.key, required this.controller,required this.label,required this.prefixIcon,required this.textInputType});

  @override
  State<Inputfield> createState() => _InputfieldState();
}

class _InputfieldState extends State<Inputfield> {
  bool obscureText=true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: Constants.screenHeight* 0.01),
      child: TextFormField(
        keyboardType:widget.textInputType ,
        obscureText: widget.textInputType==TextInputType.visiblePassword ? obscureText:false,// inline if
        controller: widget.controller,
        validator: (value){
          if(value!.isEmpty){
            return "field must not be empty";
          }
        },
        decoration: InputDecoration(
          hintText: widget.label,

          hintStyle: TextStyle(color: Colors.blueAccent,fontFamily: "Raleway-medium"),
          fillColor: Colors.blueAccent.withOpacity(0.5),
          filled: true,
          prefixIcon: widget.prefixIcon,
          suffixIcon:widget.textInputType== TextInputType.visiblePassword ?
          GestureDetector(
            onTap: (){
              setState(() {
                obscureText=!obscureText;
              });
            },
            child: obscureText ? Icon(Icons.visibility,color: Colors.blueAccent,)
                : Icon(Icons.visibility_off,color: Colors.grey,),
          ):null
          ,
          focusedBorder: OutlineInputBorder(
            // when we click inside the field border
            borderSide:  BorderSide(
              color: Colors.grey,
            ),
          ) ,
          enabledBorder:OutlineInputBorder(
            // default border
            borderSide:  BorderSide(
              color: Colors.blueAccent,

            ),
          ) ,
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
