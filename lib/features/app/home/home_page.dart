import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_chat/features/global/custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_group_chat/features/group/presentation/cubits/group/group_cubit.dart';
import 'package:flutter_group_chat/features/group/presentation/pages/group_page.dart';
import 'package:flutter_group_chat/features/user/domain/entities/user_entity.dart';
import 'package:flutter_group_chat/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter_group_chat/features/user/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:flutter_group_chat/features/user/presentation/cubit/user/user_cubit.dart';
import 'package:flutter_group_chat/features/user/presentation/pages/all_users/all_users_page.dart';
import 'package:flutter_group_chat/features/user/presentation/pages/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  final String uid;

  const HomePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabIndex = 0;

  List<Widget> get pages => [GroupPage(uid: widget.uid),AllUsersPage(),ProfilePage()];

  PageController _pageController = PageController();


  @override
  void initState() {
    BlocProvider.of<SingleUserCubit>(context).getSingleUserProfile(user: UserEntity(uid: widget.uid));
    BlocProvider.of<UserCubit>(context).getUsers(user: UserEntity(uid: widget.uid));
    BlocProvider.of<GroupCubit>(context).getGroups();
    super.initState();
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Group Chat"),
        actions: [
          Icon(Icons.search),
          SizedBox(
            width: 10,
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    BlocProvider.of<AuthCubit>(context).loggedOut();
                  },
                  child: Text(
                    "Logout",
                  ),
                )
              ];
            },
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          CustomTabBar(
            index: _tabIndex,
            tabClickListener: (int index) {
              setState(() {
                _tabIndex = index;
                _pageController.jumpToPage(index);
              });
            },
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index){
                setState(() {
                  _tabIndex = index;
                });
              },
              itemCount: pages.length,
              itemBuilder: (BuildContext context, int index) {
                return pages[index];
              },
            ),
          )
        ],
      ),
    );
  }
}
