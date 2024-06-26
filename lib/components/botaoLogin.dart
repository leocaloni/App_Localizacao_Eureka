import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BotaoLogin extends StatelessWidget {
  final Function()? onTap;

  const BotaoLogin({super.key, required this.onTap});

  //botao de login  
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.indigo[900],
          borderRadius: BorderRadius.circular(8),
        ),
        child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide.none,
                ),
                backgroundColor: Colors.indigo[900]),
            child: const Center(
              child: Text(
                'Login',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto mono',
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            )));
  }
}
