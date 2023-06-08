import 'package:flutter/material.dart';
import 'package:services_manager/Sceens/qrcode/qrcode_screen.dart';
import 'package:services_manager/Sceens/tasks/components/task_card.dart';
import 'package:services_manager/Sceens/tasks/components/task_tile.dart';

import '../../common/custum_drawer/custom_drawer.dart';

class TasksList extends StatefulWidget {
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  late DateTime selectedDateTime;
  @override
  void initState() {
    super.initState();
    selectedDateTime = DateTime.now();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDateTime.year,
            pickedDateTime.month,
            pickedDateTime.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    const items = [1, 2, 3, 4, 6, 7];
    return Scaffold(
        drawer: CustomDrawer(),
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text('Minhas tarefas'),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          shrinkWrap: true,
          itemCount: items.length,
          // prototypeItem: ListTile(
          //   title: Text('${items.first}'),
          // ),
          itemBuilder: (context, index) {
            return TaskCard(
              title: 'Limpeza das áreas comuns',
              description:
                  'Realizar limpeza e organização das áreas comuns do condomínio.',
              dataExecucao: DateTime.now(),
              location: 'Salão de festas',
              productsUsed: ['Vassoura', 'Rodo', 'Detergente'],
              status: 'Em andamento',
              onReschedulePressed: reagendarTarefa,
            );
          },
        ));
  }

  void reagendarTarefa() {
    _selectDateTime(context);
  }
}
