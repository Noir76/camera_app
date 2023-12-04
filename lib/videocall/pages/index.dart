import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:agora_rtc_engine/rtc_engine.dart' ;
import 'package:permission_handler/permission_handler.dart';
import 'call.dart';

class indexPage extends StatefulWidget {
  const indexPage({super.key});

  @override
  State<indexPage> createState() => _indexPageState();
}

class _indexPageState extends State<indexPage> {
  final _channelController = TextEditingController();
  bool _validateError = false;
  ClientRole? _roleType = ClientRole.Broadcaster;

  @override
  void dispose() {
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _channelController,
              decoration: InputDecoration(
                errorText: _validateError ? 'channel name is mandatory' : null,
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(width: 1),
                ),
                hintText: 'channel name',
              ),
            ),
            RadioListTile(
              title: const Text('Broadcaster'),
              onChanged: (ClientRole? value) {
                setState(() {
                  _roleType = value;
                });
              },
              value: ClientRole.Broadcaster,
              groupValue: _roleType,
            ),
            RadioListTile(
              title: const Text('Audience'),
              onChanged: (ClientRole? value) {
                setState(() {
                  _roleType = value;
                });
              },
              value: ClientRole.Audience,
              groupValue: _roleType,
            ),
            ElevatedButton(
              onPressed: onJoin, 
              child: const Text('join'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
              ),
            )
          ]),
        ),
      ),
    );
  }
  Future<void> onJoin() async{
  setState(() {
    _channelController.text.isEmpty
    ? _validateError = true
    : _validateError = false;
  });
    if(_channelController.text.isNotEmpty) {
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallPage(
          channelName: _channelController.text,
          role: _roleType,
        )
      ), // CallPage
      ); // MaterialPageRoute
    }
}

Future<void> _handleCameraAndMic(Permission permission) async {
  final status = await permission.request();
  log(status.toString()) ;
}

}