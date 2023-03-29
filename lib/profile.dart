import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  String _selectedBloodGroup = 'A+';
  String _selectedLocation = 'Nairobi';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: FutureBuilder<User?>(
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Blood Group',
                      ),
                      value: _selectedBloodGroup,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedBloodGroup = newValue!;
                        });
                      },
                      items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your blood group';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Location',
                      ),
                      value: _selectedLocation,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedLocation = newValue!;
                        });
                      },
                      items: [
                        'Bomet',
                        'Bungoma',
                        'Busia',
                        'Elgeyo/Marakwet',
                        'Embu',
                        'Garissa',
                        'Homa Bay',
                        'Isiolo',
                        'Kajiado',
                        'Kakamega',
                        'Kericho',
                        'Kiambu',
                        'Kilifi',
                        'Kirinyaga',
                        'Kisii',
                        'Kisumu',
                        'Kitui',
                        'Kwale',
                        'Laikipia',
                        'Lamu',
                        'Machakos',
                        'Makueni',
                        'Mandera',
                        'Marsabit',
                        'Meru',
                        'Migori',
                        'Mombasa',
                        'Murang\'a',
                        'Nairobi',
                        'Nakuru',
                        'Nandi',
                        'Narok',
                        'Nyamira',
                        'Nyandarua',
                        'Nyeri',
                        'Samburu',
                        'Siaya',
                        'Taita/Taveta',
                        'Tana River',
                        'Tharaka-Nithi',
                        'Trans Nzoia',
                        'Turkana',
                        'Uasin Gishu',
                        'Vihiga',
                        'Wajir',
                        'West Pokot'
                      ]
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your location';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.uid)
                              .set({
                            'name': _nameController.text,
                            'phone': _phoneController.text,
                            'email': _emailController.text,
                            'blood_group': _selectedBloodGroup,
                            'location': _selectedLocation,
                          }).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Profile updated successfully')));
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(error.toString())));
                          });
                        }
                      },
                      child: const Text('Update Profile'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
