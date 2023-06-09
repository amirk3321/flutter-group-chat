


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_chat/features/app/home/home_page.dart';
import 'package:flutter_group_chat/features/global/common/common.dart';
import 'package:flutter_group_chat/features/global/const/page_const.dart';
import 'package:flutter_group_chat/features/global/custom_text_field/textfield_container.dart';
import 'package:flutter_group_chat/features/global/theme/style.dart';
import 'package:flutter_group_chat/features/global/widgets/container_button.dart';
import 'package:flutter_group_chat/features/user/domain/entities/user_entity.dart';
import 'package:flutter_group_chat/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter_group_chat/features/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordAgainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CredentialCubit, CredentialState>(
        builder: (context, credentialState) {
          if (credentialState is CredentialLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }


          if (credentialState is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return HomePage(uid: authState.uid,);
                } else {
                  return _bodyWidget();
                }
              },
            );
          }


          return _bodyWidget();
        },
        listener: (context, credentialState) {
          if (credentialState is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }

          if (credentialState is CredentialFailure) {
            toast("wrong email please check");
            //toast
            //alertDialog
            ///SnackBar
          }
        },
      ),
    );
  }
  Widget _bodyWidget(){
    return  SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 22,vertical: 32),
        child: Column(
          children: [
            SizedBox(height: 40,),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Registration",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  color: greenColor,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(height: 10,),

            TextFieldContainer(
              prefixIcon: Icons.person,
              controller: _usernameController,
              hintText: "username",
            ),
            SizedBox(height: 20,),
            TextFieldContainer(
              prefixIcon: Icons.email,
              controller: _emailController,
              hintText: "Email",
            ),
            SizedBox(height: 20,),
            Divider(
              thickness: 2,
              indent: 120,
              endIndent: 120,
            ),
            SizedBox(height: 20,),
            TextFieldContainer(
              prefixIcon: Icons.lock,
              controller: _passwordController,
              hintText: "Password",
              isObscureText: true,
            ),
            SizedBox(height: 20,),
            TextFieldContainer(
              prefixIcon: Icons.lock,
              controller: _passwordAgainController,
              hintText: "Password (Again)",
              isObscureText: true,
            ),

            SizedBox(height: 20,),
            ContainerButton(
              onTap: (){
               _submitSignUp();
              },
              title: "Sign Up",
            ),
            SizedBox(height: 20,),
            Row(
              children: <Widget>[
                Text(
                  "Do you have already an account?",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: (){
                    //Navigator.pushNamedAndRemoveUntil(context, "/registration", (route) => false);
                    Navigator.pushNamedAndRemoveUntil(context, PageConst.loginPage,(routes) => false);
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: greenColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'By clicking register, you agree to the ',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: colorC1C1C1),
                ),
                Text(
                  'Privacy Policy',
                  style: TextStyle(
                      color: greenColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'and ',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: colorC1C1C1),
                ),
                Text(
                  'terms ',
                  style: TextStyle(
                      color: greenColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  'of use',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: colorC1C1C1),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


  void _submitSignUp(){


    if (_usernameController.text.isEmpty){
      toast("Enter username");
      return;
    }

    if (_emailController.text.isEmpty){
      toast("Enter email");
      return;
    }

    if (_passwordController.text.isEmpty){
      toast("Enter password");
      return;
    }

    if (_passwordAgainController.text.isEmpty){
      toast("Enter again password");
      return;
    }

    if (_passwordController.text != _passwordAgainController.text){
      toast("both password must be same");
      return;
    }


    BlocProvider.of<CredentialCubit>(context).signUpSubmit(user: UserEntity(
      name: _usernameController.text,
      profileUrl: "",
      status: "",
      email: _emailController.text,
      password: _passwordController.text,
    ));
  }
}

