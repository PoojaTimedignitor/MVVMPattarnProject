
import 'package:clean_mvvm_pattern/MVVM/repository.dart';
import 'package:clean_mvvm_pattern/MVVM/view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../repository/api_service_http.dart';
import 'api_service.dart';

/// App Start (Dependency Injection)


void main() {
  final apiService = ApiServiceDemo();
  final repository = ServiceRepository(apiService);

  runApp(
    ChangeNotifierProvider(
      create: (_) => ServiceViewModel(repository),
      child: MyApp(),
    ),
  );
}