import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedBloodGroup = '';
  String _selectedLocation = '';

  void _updateProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': _nameController.text,
        'phone': _phoneController.text,
        'blood_group': _selectedBloodGroup,
        'location': _selectedLocation,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: user != null
          ? StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final data = snapshot.data!.data() as Map<String, dynamic>?;
                _nameController.text = data?['name'] ?? '';
                _phoneController.text = data?['phone'] ?? '';
                _selectedBloodGroup = data?['blood_group'] ?? '';
                _selectedLocation = data?['location'] ?? '';
                return Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(labelText: 'Phone'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _selectedBloodGroup,
                          onChanged: (value) {
                            setState(() {
                              _selectedBloodGroup = value!;
                            });
                          },
                          items:
                              ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                                  .map(
                                    (group) => DropdownMenuItem(
                                      value: group,
                                      child: Text(group),
                                    ),
                                  )
                                  .toList(),
                          decoration: const InputDecoration(
                            labelText: 'Blood Group',
                          ),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _selectedLocation,
                          onChanged: (value) {
                            setState(() {
                              _selectedLocation = value!;
                            });
                          },
                          items: [
                            'Baringo',
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
                            'West Pokot',
                          ]
                              .map(
                                (group) => DropdownMenuItem(
                                  value: group,
                                  child: Text(group),
                                ),
                              )
                              .toList(),
                          decoration: const InputDecoration(
                            labelText: 'Location',
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _updateProfile();
                            }
                          },
                          child: const Text('Update'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
