class ApiServiceDemo {
  Future<List<Map<String, dynamic>>> getServices() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      {"name": "Cleaning Service"},
      {"name": "Plumbing Service"},
    ];
  }
}