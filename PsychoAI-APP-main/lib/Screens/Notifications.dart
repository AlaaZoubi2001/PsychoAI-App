import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:psychoai/Components/CustomAppBar.dart';
import 'package:psychoai/common/db_functions.dart';

class Notification {
  final String title;
  final String body;
  final String id;
  final String type;
  final DateTime date;
  bool isDone;

  Notification({
    required this.title,
    required this.body,
    required this.date,
    required this.type,
    required this.id,
    this.isDone = false,
  });
}

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Notification> notifications = [];
  bool first_load = true;
  GlobalKey<CustomAppBarState> _appBarKey = GlobalKey<CustomAppBarState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void markAsDone(int index, DBFunctions dbFunctions) {
    setState(() {
      notifications[index].isDone = true;
      dbFunctions.updateReminderAsDoneInFirestore(notifications[index].id);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  void _addNewActivity(DBFunctions dbFunctions) {
    var reminder_type;
    if (_titleController.text.isNotEmpty && _bodyController.text.isNotEmpty) {
      DateTime date = DateTime.now(); // You can use a unique ID generator here
      dbFunctions.addReminderToFirestore(
        _titleController.text,
        _bodyController.text,
        _selectedDate ,
        "From Parent"
      );

      setState(() {
        notifications.add(Notification(
          title: _titleController.text,
          body: _bodyController.text,
          date: _selectedDate,
          type: _titleController.text,
          id: "",
        ));
      });

      // Clear inputs
      _titleController.clear();
      _bodyController.clear();
      _selectedDate = DateTime.now();

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    var dbFunctions = Provider.of<DBFunctions>(context);
    if (first_load) {
      dbFunctions.fetchUserReminders();

      setState(() {
        first_load = false;
      });

      notifications = [];
      int i = 0;
      for (var item in dbFunctions.reminders) {
        var title = item!["reminder_type"];
        var body = item!["reminder_message"];
        var date = item!["duo_timestamp"];
        var status = item!["status"];
        var id = item!["id"];
        var dateTime = DateTime.parse(date.toString());
        notifications.add(
          Notification(
            type: title,
            title: title,
            body: body,
            date: dateTime,
            id: id,
            isDone: status.toString().toLowerCase() == "done" ? true : false,
          ),
        );
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: CustomAppBar(key: _appBarKey),
      ),
      body: dbFunctions.reminders.isEmpty
          ? Center(child: Text("loading"))
          : Container(
            child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  final isRecent = DateTime.now().difference(notification.date).inHours < 24;
            
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        notification.title,
                        style: TextStyle(
                          decoration: notification.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: isRecent ? Colors.red : Colors.black,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(notification.body,
                              style: TextStyle(
                                color: isRecent ? Colors.red : Colors.black,
                              )),
                          SizedBox(height: 4),
                          Text(
                            _formatDate(notification.date),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      leading: Icon(
                        Icons.notifications,
                        color: notification.isDone ? Colors.green : Colors.blue,
                      ),
                      trailing: notification.isDone
                          ? Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : TextButton(
                              onPressed: () => markAsDone(index, dbFunctions),
                              child: Text('Done'),
                            ),
                    ),
                  );
                },
              ),
          ),
      floatingActionButton: 
      FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Add New Activity'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(labelText: 'Title'),
                      ),
                      TextField(
                        controller: _bodyController,
                        decoration: InputDecoration(labelText: 'Body'),
                      ),
                      SizedBox(height: 8),
                      TextButton(
                        onPressed: () => _selectDate(context),
                        child: Text('Select Date: ${DateFormat('yMd').format(_selectedDate)}'),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: Text("Add"),
                      onPressed: () => _addNewActivity(dbFunctions),
                    ),
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}
