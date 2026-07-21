import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          "Cupom de Desconto",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite seu cupom"
              ),
              initialValue: CartModel.of(context).couponCode ?? "",
              onFieldSubmitted: (text) {
                FirebaseFirestore.instance.collection("coupons").doc(text).get().then((docSnap){
                  if(docSnap.data() != null) {
                    CartModel.of(context).SetCoupon(text, docSnap.data()?["percent"]);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Desconteo de ${docSnap.data()?["percent"]}% aplicado"),
                        backgroundColor: Theme.of(context).primaryColor,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else {
                    CartModel.of(context).SetCoupon('', 0);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Cupom não existente!"),
                        backgroundColor: Colors.redAccent,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}