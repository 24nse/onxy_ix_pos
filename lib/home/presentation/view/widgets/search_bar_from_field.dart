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
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(4),
      ),
      child: FormBuilderTextField(
        name:name ,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(Icons.search),
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      border: InputBorder.none
         ),
      
      ),
    );
  }


}