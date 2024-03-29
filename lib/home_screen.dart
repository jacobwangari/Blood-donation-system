import 'package:bds/drawer.dart';
import 'package:bds/report.dart';
import 'package:flutter/material.dart';
import 'donors.dart';
import 'request.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: sideDrawer(),
      appBar: AppBar(
        title: const Text('Safe Live'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Donors()),
                    );
                  },
                  child: const Text('Donors'),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Request()),
                    );
                  },
                  child: const Text('Request'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
