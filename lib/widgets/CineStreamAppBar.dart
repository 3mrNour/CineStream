import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CineStreamAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CineStreamAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    
    return AppBar(
      actionsPadding: .symmetric(horizontal: 10),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Image.asset('assets/images/Logo_horizontal.png', width: 180),
      toolbarHeight: 100,
      // centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.person, color: Colors.amber, size: 28),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite, color: Colors.amber, size: 28),
        ),
      ],
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(100);
}
