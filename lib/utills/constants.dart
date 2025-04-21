import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
FirebaseAuth firebaseAuth=FirebaseAuth.instance;
var senderId=FirebaseAuth.instance.currentUser!.uid;

