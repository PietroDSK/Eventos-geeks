import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trabalho2/eventPage.dart';
import 'package:trabalho2/formEvent.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos Geeks'),
      ),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormEvent()),
          );
        },
        tooltip: 'Novo Evento',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  Column _body(context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('game_events').snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  List<DocumentSnapshot> events = snapshot.data.documents;
                  return ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            events[index].data['imagem'],
                          ),
                        ),
                        title: Text(events[index].data['nome']),
                        subtitle: Text(events[index].data['local']),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EventPage(evento: events[index])),
          );
                        }
                      );
                    },
                  );
              }
            },
          ),
        ),
      ],
    );
  }
}