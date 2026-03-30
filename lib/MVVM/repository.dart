import '../repository/api_service_http.dart';
import 'api_service.dart';

class ServiceModel {
  final String name;

  ServiceModel({required this.name});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(name: json["name"]);
  }
}

class ServiceRepository {
  final ApiServiceDemo api;

  ServiceRepository(this.api);

  Future<List<ServiceModel>> getServices() async {
    final data = await api.getServices();

    return data.map((e) => ServiceModel.fromJson(e)).toList();
  }
}