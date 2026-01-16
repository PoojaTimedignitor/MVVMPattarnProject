import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/me_model.dart';
import '../model/user_model.dart';
import '../view_model/sql_db_provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SqlDbProvider>().fetchUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SqlDbProvider>();
   // final provider = Provider.of<SqlDbProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Sqflite")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.addUser(
            UserModel(name: "Pooja", email: "pooja@gmail.com"),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: provider.users.length,
        itemBuilder: (context, index) {
          final user = provider.users[index];
          return ListTile(
            title: Text(user.name ?? ''),
            subtitle: Text(user.email ?? ''),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                provider.deleteUser(user.id!);
              },
            ),
          );
        },
      ),
    );
  }
}
