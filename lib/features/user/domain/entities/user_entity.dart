import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? name;
  final String? email;
  final String? uid;
  final String? status;
  final String? profileUrl;
  final String? password;

  UserEntity(
      {this.name,
      this.email,
      this.uid,
      this.status,
      this.profileUrl,
      this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        email,
        uid,
        status,
        profileUrl,
        password,
      ];
}
