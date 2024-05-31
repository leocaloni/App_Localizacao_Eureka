import 'package:flutter_test/flutter_test.dart';
import 'package:app_eureka/services/autenticacao_servico.dart';

void main() {
  group('AutenticacaoServico', () {
    test('cadastrarUsuario - Sucesso', () async {
      final authServico = AutenticacaoServico();
      final resultado = await authServico.cadastrarUsuario(
        nome: 'Teste',
        email: 'teste@example.com',
        senha: '12345678',
        parentesco: 'parente',
      );

      expect(resultado, isNull);
    });

    test('cadastrarUsuario - Email já em uso', () async {
      final authServico = AutenticacaoServico();
      final resultado = await authServico.cadastrarUsuario(
        nome: 'Teste',
        email: 'teste@example.com', // Este email já deve estar em uso
        senha: '12345678',
        parentesco: 'parente',
      );

      expect(resultado, equals('Email já em uso'));
    });

    test('logarUsuario - Sucesso', () async {
      final authServico = AutenticacaoServico();
      final resultado = await authServico.logarUsuario(
        email: 'teste@example.com',
        senha: '12345678',
      );

      expect(resultado, isNull);
    });

    test('logarUsuario - Email ou senha inválidos', () async {
      final authServico = AutenticacaoServico();
      final resultado = await authServico.logarUsuario(
        email: 'email_invalido@example.com',
        senha: 'senha_invalida',
      );

      expect(resultado, equals('O email ou a senha é inválido'));
    });
  });
}
