import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//snackBar para feedback ao usuario
mostrarSnackBar({required BuildContext context, required String texto, bool isErro = true}){
  SnackBar snackBar = SnackBar(
    content: Text(texto),
    backgroundColor: (isErro)? Colors.red: Colors.green,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    duration: const Duration(seconds: 3),
    showCloseIcon: true,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}