import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile(this.snapshot, {super.key});

  final DocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final data = snapshot.data() as Map<String, dynamic>?;
    final String iconUrl = data?["icon"] ?? "";
    return ListTile(
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: iconUrl.isNotEmpty
            ? NetworkImage(iconUrl)
            : const NetworkImage(
                    "https://img.icons8.com/?size=160&id=EMR7mXmlROzG&format=png",
                  )
                  as ImageProvider,
      ),
      title: Text(data?["title"]),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {},
    );
  }
}
