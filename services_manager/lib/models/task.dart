class Task {
  final String id;
  final String title;
  final DateTime dataExecucao;
  final List<String> products;
  final String location;
  final String description;
  final String status;

  Task({
    required this.status,
    required this.description,
    required this.id,
    required this.title,
    required this.dataExecucao,
    required this.products,
    required this.location,
  });
}
