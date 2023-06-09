


import 'package:flutter/material.dart';
import 'package:flutter_group_chat/features/global/custom_tab_bar/custom_tab_bar_item.dart';
import 'package:flutter_group_chat/features/global/theme/style.dart';

typedef TabClickListener=Function(int index);

class CustomTabBar extends StatefulWidget {
  final TabClickListener tabClickListener;
  final int index;

  const CustomTabBar({Key? key, this.index = 0,required this.tabClickListener}) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int _indexHolder=0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: primaryColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomTabBarItem(
              width: 50,
              text: "Groups",
              textColor: widget.index == 0 ? textIconColor : textIconColorGray,
              borderColor: widget.index == 0 ? textIconColor : Colors.transparent,
              onTap: (){
                setState(() {
                  _indexHolder=0;
                });
                widget.tabClickListener(_indexHolder);
              },
            ),
          ),
          Expanded(
            child: CustomTabBarItem(
              text: "Users",
              textColor: widget.index == 1 ? textIconColor : textIconColorGray,
              borderColor: widget.index == 1 ? textIconColor : Colors.transparent,
              onTap: (){
                setState(() {
                  _indexHolder=1;
                });
                widget.tabClickListener(_indexHolder);
              },
            ),
          ),
          Expanded(
            child: CustomTabBarItem(
              text: "Profile",
              textColor: widget.index == 2 ? textIconColor : textIconColorGray,
              borderColor: widget.index == 2 ? textIconColor : Colors.transparent,
              onTap: (){
                setState(() {
                  _indexHolder=2;
                });
                widget.tabClickListener(_indexHolder);
              },
            ),
          )
        ],
      ),
    );
  }
}