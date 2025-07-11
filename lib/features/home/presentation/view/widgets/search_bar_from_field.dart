import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SearchBarFromField extends StatelessWidget {
  const SearchBarFromField({super.key, required this.name, required this.hintText, this.onChanged});
  final String name;
  final String hintText;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: Color(0xFFe5e9ec),
        borderRadius: BorderRadius.circular(4),
      ),
      child: FormBuilderTextField(
         style: const TextStyle(color: Colors.black), 
        name:name ,
        onChanged: onChanged,
        
        decoration: InputDecoration(
         
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0xFFa3a4b6),
          ),
          prefixIcon: const Icon(Icons.search,color: Color(0xFFa3a4b6),size: 18,),
          contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      border: InputBorder.none
         ),
      
      ),
    );
  }


}