import 'package:flutter/material.dart';

class msg_send_counter extends StatefulWidget {
  const msg_send_counter({super.key});

  @override
  State<msg_send_counter> createState() {
    State<msg_send_counter> sendCounterWidget = _msg_send_counterState();
    return sendCounterWidget;
  }
}

class _msg_send_counterState extends State<msg_send_counter> {
  int counter = 0;
  void count_increment() {
    setState(() {
      counter++;
    });
    print(counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          count_increment();
        },
      ),
      body: Center(
        child: Text(
          '$counter',
          style: const TextStyle(
            fontSize: 50,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
