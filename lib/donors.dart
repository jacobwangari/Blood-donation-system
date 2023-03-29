import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
              return GestureDetector(
                onTap: () {
                  // Add your action here, such as opening a detailed view of the user
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    title: Text(
                      user['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                        Text(
                          user['location'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.phone,
                          color: Colors.green,
                        ),
                        Text(
                          user['phone'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.local_hospital,
                          color: Colors.orange,
                        ),
                        Text(
                          user['blood_group'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.email,
                          color: Colors.purple,
                        ),
                        Text(
                          user['email'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
