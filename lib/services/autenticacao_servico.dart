import 'package:firebase_auth/firebase_auth.dart';

class AutenticacaoServico {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> cadastrarUsuario({
    required String nome,
    required String email,
    required String senha,
    required String parentesco,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      await userCredential.user!.updateDisplayName(nome);
      await userCredential.user!.updatePhotoURL(parentesco);

      return null;
    } on FirebaseAuthException catch(e){
      if(e.code == "email-already-in-use"){
        return"Email já em uso";
      }
      return "Erro desconhecido";
      
    }
  }

  Future<String?> logarUsuario({
    required String email,
    required String senha,
  }) async {
    try {
  await _firebaseAuth.signInWithEmailAndPassword(email: email, password: senha);
  return null;
} on FirebaseAuthException catch (e) {
  return e.message;
}
  }

  Future<void> deslogarUsuario() async{
    return _firebaseAuth.signOut();
  }
}
