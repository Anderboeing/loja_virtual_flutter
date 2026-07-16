import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Conta", style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: "Nome Completo"),
              validator: (value) {
                if (value == '') {
                  return "Nome inválido!";
                }
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(hintText: "E-mail"),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || !value.contains("@")) {
                  return "E-mail inválido!";
                }
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(hintText: "Senha"),
              obscureText: true,
              validator: (value) {
                if (value == null || value.length < 6) {
                  return "Senha inválida";
                }
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(hintText: "Endereço"),
              validator: (value) {
                if (value == '') {
                  return "Endereço inválido";
                }
              },
            ),
            SizedBox(height: 16.0),
            SizedBox(
              height: 44.0,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
                child: Text(
                  "Criar Conta",
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
