import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {
  TextComposer(this.sendMessage);

  final Function(String) sendMessage;
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
            onPressed: () {},
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

  void sendMessage(text) {
    widget.sendMessage(text);
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
  }
}
