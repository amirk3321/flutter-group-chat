

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_group_chat/features/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity{

  UserModel({
    String? name,
    String? email,
    String? uid,
    String? status,
    String? profileUrl,
}) : super (
    name: name,
    email: email,
    uid: uid,
    status: status,
    profileUrl: profileUrl,
  );


  factory UserModel.fromSnapshot(DocumentSnapshot snapshot){
    var snapshotMap = snapshot.data() as Map<String,dynamic>;

    return UserModel(
      name: snapshotMap['name'],
      profileUrl: snapshotMap['profileUrl'],
      status: snapshotMap['status'],
      uid: snapshotMap['uid'],
      email: snapshotMap['email']
    );
  }

  Map<String,dynamic> toDocument(){
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "status": status,
      "profileUrl": profileUrl,
    };
  }


}