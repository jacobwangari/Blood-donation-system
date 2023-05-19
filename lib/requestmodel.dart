import 'package:cloud_firestore/cloud_firestore.dart';

class BloodRequest {
  final String email;
  final Timestamp timestamp;

  BloodRequest({required this.email, required this.timestamp});
}
