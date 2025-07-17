import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:onyx_ix_pos/core/utils/responsive_font_size.dart';
import 'package:onyx_ix_pos/core/utils/theme/app_colors.dart';

class SearchBarFromField extends StatelessWidget {
  const SearchBarFromField({super.key, required this.name, required this.hintText, this.onChanged});
  final String name;
  final String hintText;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 35,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.searchAndTabBarDark
            : AppColors.searchBarLight,
        borderRadius: BorderRadius.circular(4),
        border: Theme.of(context).brightness == Brightness.dark
            ? Border.all(color: Colors.grey.shade700)
            : null,
      ),
      child: FormBuilderTextField(
         style: const TextStyle(color: Colors.black), 
        name:name ,
        onChanged: onChanged,
        
        decoration: InputDecoration(
         
          hintText: hintText,
          hintStyle:Theme.of(context).textTheme.displayLarge!.copyWith(
            fontSize: getResponsiveFontSize(context, fontSize: 14),
                        color: const Color(0xFFa3a4b6),

          ) ,
          prefixIcon: const Icon(Icons.search,color: Color(0xFFa3a4b6),size: 18,),
          contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      border: InputBorder.none
         ),
      
      ),
    );
  }


}