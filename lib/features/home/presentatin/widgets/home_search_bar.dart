import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: .search,
      keyboardType: .text,
      onChanged: (String? value) {},
      decoration: InputDecoration(
        hintText: "Search...",
        prefixIcon: Icon(Icons.search),
        fillColor: Colors.grey.withAlpha(50),
        filled: true,
        border: _buildOutlineInputBorder(),
        enabledBorder: _buildOutlineInputBorder(),
        focusedBorder: _buildOutlineInputBorder(),
      ),
    );
  }

  OutlineInputBorder _buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: .circular(12),
      borderSide: BorderSide.none,
    );
  }
}
