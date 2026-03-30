import 'package:clean_mvvm_pattern/MVVM/view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ServiceViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Services")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              vm.fetchServices();
            },
            child: Text("Load Services"),
          ),

          if (vm.isLoading) CircularProgressIndicator(),

          Expanded(
            child: ListView.builder(
              itemCount: vm.services.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(vm.services[index].name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}