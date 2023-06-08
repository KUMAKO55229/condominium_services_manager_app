import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final DateTime dataExecucao;
  final String location;
  final List<String> productsUsed;
  final String status;
  final VoidCallback? onReschedulePressed;

  TaskCard({
    required this.title,
    required this.description,
    required this.dataExecucao,
    required this.location,
    required this.productsUsed,
    required this.status,
    this.onReschedulePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              description,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(Icons.access_time, size: 16.0),
                SizedBox(width: 4.0),
                Text(
                  '$dataExecucao',
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(width: 16.0),
                Icon(Icons.location_on, size: 16.0),
                SizedBox(width: 4.0),
                Text(
                  location,
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Produtos Utilizados:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: productsUsed.map((product) {
                return Text(
                  '- $product',
                  style: TextStyle(fontSize: 14.0),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            if (onReschedulePressed != null)
              ElevatedButton(
                onPressed: onReschedulePressed,
                child: Text('Reagendar'),
              ),
          ],
        ),
      ),
    );
  }
}
