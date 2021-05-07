import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  UserForm({Key key}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              Text("Данные клиента"),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextField(
                          decoration: InputDecoration(hintText: 'TextField B'),
                          onEditingComplete: () => node.nextFocus()),
                      TextField(
                          decoration: InputDecoration(hintText: 'TextField B'),
                          onEditingComplete: () => node.nextFocus()),
                      TextField(
                          decoration: InputDecoration(hintText: 'TextField B'),
                          onEditingComplete: () => node.nextFocus()),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
