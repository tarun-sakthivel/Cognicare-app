import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class testing extends StatefulWidget {
  const testing({super.key});

  @override
  State<testing> createState() => _testingState();
}

class _testingState extends State<testing> {
   Future<List<dynamic>> fetchBooks() async {
    final res = await http.get(Uri.parse("http://127.0.0.1:8000/books"));
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("Failed to load books");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Books")),
      body: FutureBuilder<List<dynamic>>(
        future: fetchBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          final books = snapshot.data!;
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return ListTile(
                title: Text(book["title"]),
                subtitle: Text(book["author"]),
              );
            },
          );
        },
      ),
    );
  }
}
