import 'package:clean_mvvm_pattern/MVVM/repository.dart';
import 'package:flutter/cupertino.dart';

class ServiceViewModel extends ChangeNotifier {
  final ServiceRepository repo;

  ServiceViewModel(this.repo);

  List<ServiceModel> services = [];
  bool isLoading = false;

  Future<void> fetchServices() async {
    isLoading = true;
    notifyListeners();

    services = await repo.getServices();

    isLoading = false;
    notifyListeners();
  }
}