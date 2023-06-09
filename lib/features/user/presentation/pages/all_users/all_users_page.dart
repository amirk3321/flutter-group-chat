import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_chat/features/user/presentation/cubit/user/user_cubit.dart';
import 'package:network_image/network_image.dart';

class AllUsersPage extends StatelessWidget {
  const AllUsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          if (userState is UserLoaded) {
            final users = userState.users;


            return ListView.builder(
                itemCount: users.length, itemBuilder: (context, index) {

                  final user = users[index];

              return ListTile(
                title:Text("${user.name}"),
                subtitle: Text("${user.status}"),
                leading: Container(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: NetworkImageWidget(
                      borderRadiusImageFile: 50,
                      imageFileBoxFit: BoxFit.cover,
                      placeHolderBoxFit: BoxFit.cover,
                      networkImageBoxFit: BoxFit.cover,
                      imageUrl: user.profileUrl,
                      progressIndicatorBuilder: Center(
                        child: CircularProgressIndicator(),
                      ),
                      placeHolder: "assets/profile_default.png",
                    ),
                  ),
                ),
                trailing: Icon(Icons.favorite),
              );
            });
          }


          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
