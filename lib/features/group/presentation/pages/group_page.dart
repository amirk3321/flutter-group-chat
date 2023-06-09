import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_chat/features/global/const/page_const.dart';
import 'package:flutter_group_chat/features/group/domain/entities/single_chat_entity.dart';
import 'package:flutter_group_chat/features/group/presentation/cubits/group/group_cubit.dart';
import 'package:flutter_group_chat/features/user/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:network_image/network_image.dart';

class GroupPage extends StatefulWidget {
  final String uid;

  const GroupPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, PageConst.createGroupPage,
              arguments: widget.uid);
        },
        child: Icon(Icons.groups),
      ),
      body: BlocBuilder<SingleUserCubit, SingleUserState>(
        builder: (context, singleUserSate) {
          if (singleUserSate is SingleUserLoaded) {
            final currentUser = singleUserSate.currentUser;

            return BlocBuilder<GroupCubit, GroupState>(
              builder: (context, groupState) {
                if (groupState is GroupLoaded) {
                  final groups = groupState.groups;
                  return groups.isEmpty
                      ? Center(child: Text("No Group Created Yet"))
                      : ListView.builder(
                          itemCount: groups.length,
                          itemBuilder: (BuildContext context, int index) {
                            final groupInfo = groups[index];
                            return ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PageConst.singleChatPage,
                                    arguments: SingleChatEntity(
                                        groupId: groupInfo.groupId!,
                                        groupName: groupInfo.groupName!,
                                        uid: currentUser.uid!,
                                        username: currentUser.name!));
                              },
                              title: Text("${groupInfo.groupName}"),
                              subtitle: Text("${groupInfo.lastMessage}"),
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
                                    imageUrl: groupInfo.groupProfileImage,
                                    progressIndicatorBuilder: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    placeHolder: "assets/profile_default.png",
                                  ),
                                ),
                              ),
                            );
                          });
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
