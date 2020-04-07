import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {
  TextComposer(this.sendMessage);

  final Function({String text, File imgFile}) sendMessage;
  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _isComposing = false;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () async {
              final File imgFile =
                  await ImagePicker.pickImage(source: ImageSource.camera);
              if (imgFile == null) return;
              sendImage(imgFile);
            },
          ),
          Expanded(
            child: TextField(
              controller: _textController,
              decoration:
                  InputDecoration.collapsed(hintText: "Enviar uma Mensagem"),
              onChanged: (text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                sendMessage(text);
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _isComposing
                ? () {
                    sendMessage(_textController.text);
                  }
                : null,
          )
        ],
      ),
    );
  }

  void sendMessage(String text) {
    widget.sendMessage(text: text);
    _reset();
  }

  void sendImage(File img) {
    widget.sendMessage(imgFile: img);
    _reset();
  }

  void _reset() {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
  }
}
