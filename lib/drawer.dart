import 'package:bds/logout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Drawer sideDrawer() {
  return Drawer(
    child: FutureBuilder<User?>(
      future: FirebaseAuth.instance.authStateChanges().first,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data!;
          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error loading user data'),
                );
              } else {
                final name = snapshot.data!['name'];
                return ListView(
                  children: <Widget>[
                    Builder(builder: (context) {
                      return Column(children: [
                        DrawerHeader(
                          padding: const EdgeInsets.all(0),
                          child: UserAccountsDrawerHeader(
                            accountName: Text(
                              (name ?? user.displayName ?? "").toUpperCase(),
                              style: const TextStyle(fontSize: 24),
                            ),
                            accountEmail: Text(
                              user.email ?? "",
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            currentAccountPictureSize: const Size.square(50),
                            currentAccountPicture: CircleAvatar(
                              backgroundColor: Theme.of(context).primaryColor,
                              child: Text(
                                name != null
                                    ? name[0].toUpperCase()
                                    : user.displayName != null
                                        ? user.displayName![0].toUpperCase()
                                        : "",
                                style: const TextStyle(
                                  fontSize: 30.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]);
                    }),
                    const Divider(),
                    ListTile(
                      title: const Text('Update Profile'),
                      onTap: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                    ),
                    ListTile(
                      title: const Text('Donors'),
                      onTap: () {
                        Navigator.pushNamed(context, '/donors');
                      },
                    ),
                    ListTile(
                      title: const Text('Request'),
                      onTap: () {
                        Navigator.pushNamed(context, '/request');
                      },
                    ),
                    ListTile(
                      title: const Text('Donate'),
                      onTap: () {
                        Navigator.pushNamed(context, '/donate');
                      },
                    ),
                    ListTile(
                      title: const Text('LogOut'),
                      onTap: () {
                        signOut(context);
                      }, 
                    ),
                  ],
                );
              }
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    ),
  );
}
