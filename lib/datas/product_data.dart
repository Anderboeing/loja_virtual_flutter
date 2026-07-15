import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String category = '';
  String id = '';
  String title = '';
  String description = '';
  double price = 0.0;

  List images = [];
  List sizes = [];

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    final data = snapshot.data() as Map<String, dynamic>?;
    title = data?["title"] ?? "Sem titulo";
    description = data?["description"] ?? "Sem descrição";
    price = data?["price"] ?? 0.0;
    images = data?["images"] ?? [];
    sizes = data?["sizes"] ?? [];
  }
}
