import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant(builder: (context, child, model) {
        return ScopedModel<CartModel>(
          model: CartModel(model as UserModel),
          child: MaterialApp(
            title: 'Flutter Loja',
            theme: ThemeData(
              colorScheme: .fromSeed(seedColor: Color.fromARGB(255, 4, 125, 141)),
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
          ),
        );
      },),
    );
  }
}
