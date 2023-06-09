import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class GroupEntity extends Equatable {
  final String? groupName;
  final String? groupProfileImage;
  final Timestamp? createAt;
  final String? groupId;
  final String? uid;
  final String? lastMessage;

  GroupEntity({
    this.groupName,
    this.groupProfileImage,
    this.createAt,
    this.groupId,
    this.uid,
    this.lastMessage,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    groupName,
    groupProfileImage,
    createAt,
    groupId,
    uid,
    lastMessage,
  ];
}
