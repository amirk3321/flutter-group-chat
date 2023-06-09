import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_chat/features/global/common/common.dart';
import 'package:flutter_group_chat/features/global/custom_text_field/textfield_container.dart';
import 'package:flutter_group_chat/features/global/theme/style.dart';
import 'package:flutter_group_chat/features/global/widgets/container_button.dart';
import 'package:flutter_group_chat/features/storage/domain/usecases/upload_profile_image_usecase.dart';
import 'package:flutter_group_chat/features/user/domain/entities/user_entity.dart';
import 'package:flutter_group_chat/features/user/presentation/cubit/single_user/single_user_cubit.dart';
import 'package:flutter_group_chat/features/user/presentation/cubit/user/user_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:network_image/network_image.dart';
import 'package:flutter_group_chat/features/injection_container.dart' as di;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  File? _image;


  TextEditingController _nameController=TextEditingController();
  TextEditingController _statusController=TextEditingController();
  TextEditingController _emailController=TextEditingController();


  @override
  void dispose() {
    _nameController.dispose();
    _statusController.dispose();
    _emailController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SingleUserCubit, SingleUserState>(
        builder: (context, singleUserState) {


          if (singleUserState is SingleUserLoaded){

            return _bodyWidget(singleUserState.currentUser);
          }


          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }


  Future getImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 40,);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      toast("error $e");
    }
  }

  Widget _bodyWidget(UserEntity currentUser) {
    _nameController.value = TextEditingValue(text: "${currentUser.name}");
    _emailController.value = TextEditingValue(text: "${currentUser.email}");
    _statusController.value = TextEditingValue(text: "${currentUser.status}");
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              getImage();
            },
            child: Container(
              height: 80,
              width: 80,
              child: NetworkImageWidget(
                imageFile: _image,
                borderRadiusImageFile: 50,
                imageFileBoxFit: BoxFit.cover,
                placeHolderBoxFit: BoxFit.cover,
                networkImageBoxFit: BoxFit.cover,
                imageUrl: currentUser.profileUrl,
                progressIndicatorBuilder: Center(
                  child: CircularProgressIndicator(),
                ),
                placeHolder: "assets/profile_default.png",
              ),
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
            'Remove profile photo',
            style: TextStyle(
                color: greenColor,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 14,
          ),
          TextFieldContainer(
            hintText: "username",
            prefixIcon: Icons.person,
            controller: _nameController,
          ),
          SizedBox(
            height: 14,
          ),
          AbsorbPointer(
            child: TextFieldContainer(
              hintText: "email",
              prefixIcon: Icons.alternate_email,
              controller: _emailController,
            ),
          ),
          SizedBox(
            height: 14,
          ),
          TextFieldContainer(
            hintText: "status",
            prefixIcon: Icons.data_array,
            controller: _statusController,
          ),
          SizedBox(
            height: 14,
          ),
          ContainerButton(
            title: "Update Profile",
            onTap: () {
              _updateProfile(currentUser.uid!);
            },
          )
        ],
      ),
    );
  }

  void _updateProfile(String uid){

    if (_image !=null){
      di.sl<UploadProfileImageUseCase>().call(file: _image!).then((imageUrl) {

        BlocProvider.of<UserCubit>(context).getUpdateUser(user: UserEntity(
          uid: uid,
          name: _nameController.text,
          status: _statusController.text,
          profileUrl: imageUrl
        )).then((value) {
          toast("Profile Updated Successfully");
        });
      });
    }else{
      BlocProvider.of<UserCubit>(context).getUpdateUser(user: UserEntity(
        uid: uid,
        name: _nameController.text,
        status: _statusController.text,
      )).then((value){
        toast("Profile Updated Successfully");
      });
    }



  }

}
