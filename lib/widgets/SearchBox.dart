import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: SizedBox(
          width: 320,
          height: 40,
          child: TextField(
            cursorColor: Colors.amber,
            textInputAction: TextInputAction.search,
            keyboardType: .text,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 10,
              ),
              labelText: "Search for movies, TV shows, and more",
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelStyle: TextStyle(color: Color.fromARGB(68, 255, 255, 255)),
              prefixIcon: const Icon(Icons.search, color: Color(0xffFFCD30)),

              filled: true,
              fillColor: Color.fromARGB(75, 124, 92, 192),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  color: Color.fromARGB(0, 255, 207, 48),
                  width: 0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  color: Color(0xffFFCD30),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
