

import 'package:bds/drawer.dart';
import 'package:flutter/material.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        drawer: sideDrawer(),
        appBar: AppBar(
          title:const Text("Request Blood")
        ),


    );
  }
}