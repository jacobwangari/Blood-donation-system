import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class Donors extends StatefulWidget {
  const Donors({Key? key}) : super(key: key);

  @override
  State<Donors> createState() => _DonorsState();
}

class _DonorsState extends State<Donors> {
  late Stream<QuerySnapshot> _usersStream;

  @override
  void initState() {
    super.initState();
    _usersStream = FirebaseFirestore.instance.collection('users').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!.docs;
          return ListView.builder(
  itemCount: users.length,
  itemBuilder: (BuildContext context, int index) {
    final user = users[index].data() as Map<String, dynamic>;
    return ListTile(
      leading: const Icon(Icons.person),
      title: Text(user['name']),
      subtitle: Row(
        children: [
          const Icon(Icons.location_on),
          Text(user['location']),
          const SizedBox(width: 10),
          const Icon(Icons.local_phone),
          InkWell(
            onTap: () => launch('tel:${user['phone']}'),
            child: Text(user['phone']),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.local_hospital),
          Text(user['blood_group']),
        ],
      ),
    );
  },
);
        },
      ),
    );
  }
}
