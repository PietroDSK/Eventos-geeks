import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trabalho2/homepage.dart';

class EventPage extends StatelessWidget {
  final evento;
  EventPage({Key key, @required this.evento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos Geeks'),
      ),
      body: _body(context),
    );
  }

  Column _body(context) {
    return Column(children: <Widget>[
      Expanded(flex: 2, child: Image.network(evento.data['imagem'].toString())),
      Expanded(
        flex: 3,
        child: Column(
          children: <Widget>[
            Text(
              evento.data['nome'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            Text(
              'Local: ' + evento.data['local'],
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            Text(
              'Cidade: ' + evento.data['cidade'],
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            Text(
              "Valor do Ingresso: " +
                  evento.data['valor'].toString() +
                  ' Reais',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: FlatButton(
                onPressed: () {
             
                },
                child: Text(
                  'Comprar Ingresso',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
             SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: FlatButton(
                onPressed: () {
                  deleteData(evento.documentID);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text(
                  'Excluir Evento',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  deleteData(docId) {
    Firestore.instance
        .collection('game_events')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}
