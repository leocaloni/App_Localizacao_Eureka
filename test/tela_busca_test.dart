import 'package:app_eureka/tela_busca.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}

class MockQuerySnapshot extends Mock implements QuerySnapshot<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot<Map<String, dynamic>> {}

class MockQuery extends Mock implements Query<Map<String, dynamic>> {}

void main() {
  group('TelaBusca Tests', () {
    late MockFirebaseFirestore mockFirestore;
    late MockCollectionReference mockCollection;
    late MockQuery mockQuery;
    late Widget widgetUnderTest;

    setUp(() {
      mockFirestore = MockFirebaseFirestore();
      mockCollection = MockCollectionReference();
      mockQuery = MockQuery();

      // Configurando o retorno do método collection no mockFirestore
      when(mockFirestore.collection('trabalhos')).thenReturn(mockCollection);

      widgetUnderTest = MaterialApp(
        home: TelaBusca(),
      );
    });

    testWidgets('Displays search suggestions', (WidgetTester tester) async {
      final mockQuerySnapshot = MockQuerySnapshot();
      final mockDocumentSnapshot1 = MockQueryDocumentSnapshot();
      final mockDocumentSnapshot2 = MockQueryDocumentSnapshot();

      when(mockDocumentSnapshot1.data()).thenReturn({'tituloTrabalho': 'Trabalho 1'});
      when(mockDocumentSnapshot2.data()).thenReturn({'tituloTrabalho': 'Trabalho 2'});
      when(mockQuerySnapshot.docs).thenReturn([mockDocumentSnapshot1, mockDocumentSnapshot2]);
      when(mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);

      await tester.pumpWidget(widgetUnderTest);
      await tester.enterText(find.byType(TextField), 'Tra');
      await tester.pump(); 

      expect(find.text('Trabalho 1'), findsOneWidget);
      expect(find.text('Trabalho 2'), findsOneWidget);
    });

    testWidgets('Displays no suggestions for empty search term', (WidgetTester tester) async {
      final mockQuerySnapshot = MockQuerySnapshot();
      when(mockQuerySnapshot.docs).thenReturn([]);
      when(mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);

      await tester.pumpWidget(widgetUnderTest);
      await tester.enterText(find.byType(TextField), '');
      await tester.pump(); 

      expect(find.byType(ListTile), findsNothing);
    });

    testWidgets('Displays search result', (WidgetTester tester) async {
      final mockQuerySnapshot = MockQuerySnapshot();
      final mockDocumentSnapshot = MockQueryDocumentSnapshot();

      when(mockDocumentSnapshot.data()).thenReturn({
        'tituloTrabalho': 'Trabalho 1',
        'descricaoTrabalho': 'Descrição 1',
        'numeroEstande': 1
      });
      when(mockQuerySnapshot.docs).thenReturn([mockDocumentSnapshot]);
      when(mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);

      await tester.pumpWidget(widgetUnderTest);
      await tester.enterText(find.byType(TextField), 'Trabalho 1');
      await tester.tap(find.text('Buscar'));
      await tester.pump(); 

      expect(find.text('Descrição 1'), findsOneWidget);
    });

    testWidgets('Displays no result found message', (WidgetTester tester) async {
      final mockQuerySnapshot = MockQuerySnapshot();

      when(mockQuerySnapshot.docs).thenReturn([]);
      when(mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);

      await tester.pumpWidget(widgetUnderTest);
      await tester.enterText(find.byType(TextField), 'Trabalho 1');
      await tester.tap(find.text('Buscar'));
      await tester.pump(); 

      expect(find.text('Trabalho não encontrado.'), findsOneWidget);
    });
  });
}
