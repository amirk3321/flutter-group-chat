



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_group_chat/features/group/group_injection_container.dart';
import 'package:flutter_group_chat/features/storage/storage_injection_container.dart';
import 'package:flutter_group_chat/features/user/user_injection_container.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';


final sl = GetIt.instance;

Future<void> init() async {



  /// External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseStorage storage = FirebaseStorage.instance;




  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
  sl.registerLazySingleton(() => googleSignIn);
  sl.registerLazySingleton(() => storage);


  await userInjectionContainer();
  await storageInjectionContainer();
  await groupInjectionContainer();

}