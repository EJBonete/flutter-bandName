import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:band_names/services/socket_service.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    Map<String, String> mensaje = {
      'nombre': 'Flutter',
      'mensaje': 'Hola desde FLutter'
    };

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text('ServerStatus: ${socketService.serverStatus}')],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          socketService.socket.emit('mensaje', mensaje);
        },
        child: const Icon(Icons.message),
      ),
    );
  }
}
