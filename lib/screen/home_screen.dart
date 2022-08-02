import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/band.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Band> bands = [
    Band(id: '1', name: 'Metalica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 2),
    Band(id: '3', name: 'Heroes del silencio', votes: 3),
    Band(id: '4', name: 'Bon Jovi', votes: 7),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BandNames',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) {
          return _bandTile(bands[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addnewBand,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction) {
        //TODO: llamar el borrado en el server
        debugPrint('id: ${band.id}');
      },
      background: Container(
        padding: const EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'DeleteBand',
              style: TextStyle(color: Colors.white),
            )),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(band.name.substring(0, 2)),
        ),
        title: Text(band.name),
        trailing: Text('${band.votes}', style: const TextStyle(fontSize: 20)),
        onTap: () {
          debugPrint(band.name);
        },
      ),
    );
  }

  addnewBand() {
    final textControler = TextEditingController();
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text('New band:'),
              content: TextField(
                controller: textControler,
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text('add'),
                  onPressed: () => addBandToList(textControler.text),
                ),
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text('dissmiss'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          });
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('New band'),
          content: TextField(
            controller: textControler,
          ),
          actions: [
            MaterialButton(
              onPressed: () => addBandToList(textControler.text),
              textColor: Colors.blue,
              child: const Text('Add'),
            )
          ],
        );
      },
    );
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      bands.add(Band(id: 'id', name: name, votes: 5));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
