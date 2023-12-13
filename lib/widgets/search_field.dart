import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Custom search field widget

class SearchField extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  const SearchField(
      {super.key, required this.onChanged, required this.controller});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
          fontSize: 16.sp, fontWeight: FontWeight.normal, color: Colors.white),
      onChanged: widget.onChanged,
      controller: widget.controller,
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.h),
        hintText: 'Search city',
        hintStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
