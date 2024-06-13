import 'package:firebase_auth/firebase_auth.dart';

class AutenticacaoServico {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  //metodo de cadastrar usuario
  Future<String?> cadastrarUsuario({
    required String nome,
    required String email,
    required String senha,
    required String parentesco,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      await userCredential.user!.updateDisplayName(nome);
      await userCredential.user!.updatePhotoURL(parentesco);

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "Email já em uso";
      }
      return "Ocorreu um erro ao tentar cadastrar. Por favor, tente novamente";
    }
  }

  //metodo de logar usuario
  Future<String?> logarUsuario({
    required String email,
    required String senha,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: senha);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.message ==
          "The supplied auth credential is incorrect, malformed or has expired.") {
        return "O email ou a senha é inválido";
      } else {
        return "Ocorreu um erro ao tentar logar. Por favor, tente novamente";
      }
    }
  }

  //metodo de deslogar usuario
  Future<void> deslogarUsuario() async {
    return _firebaseAuth.signOut();
  }

  Future<String?> resetarSenha({
    required String email
    }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return null;
    } catch (e) {
      print("Erro ao enviar email de redefinição de senha: $e");
      return "Ocorreu um erro ao enviar o email de redefinição de senha. Por favor, tente novamente.";
    }
  }
}
