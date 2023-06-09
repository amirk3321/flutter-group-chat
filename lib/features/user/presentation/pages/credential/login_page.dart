import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_chat/features/app/home/home_page.dart';
import 'package:flutter_group_chat/features/global/common/common.dart';
import 'package:flutter_group_chat/features/global/const/page_const.dart';
import 'package:flutter_group_chat/features/global/custom_text_field/textfield_container.dart';
import 'package:flutter_group_chat/features/global/theme/style.dart';
import 'package:flutter_group_chat/features/global/widgets/container_button.dart';
import 'package:flutter_group_chat/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter_group_chat/features/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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


  Widget _bodyWidget() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 22, vertical: 32),
        child: Column(
          children: [
            SizedBox(height: 40,),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Login",
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
              prefixIcon: Icons.email,
              controller: _emailController,
              hintText: "Email",
            ),
            SizedBox(height: 20,),
            TextFieldContainer(
              prefixIcon: Icons.email,
              controller: _passwordController,
              hintText: "Password",
              isObscureText: true,
            ),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  //Navigate
                  Navigator.pushNamed(context, PageConst.forgotPage);
                },
                child: Text("Forgot Password", style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: greenColor,
                ),),
              ),
            ),
            SizedBox(height: 20,),
            ContainerButton(
              onTap: () {
                _submitLogin();
              },
              title: "Login",
            ),
            SizedBox(height: 20,),
            Row(
              children: <Widget>[
                Text(
                  "don't have an Account",
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, PageConst.registrationPage, (routes) => false);
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: greenColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                //Submit Google Login
                BlocProvider.of<CredentialCubit>(context).googleAuthSubmit();
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.2),
                        offset: Offset(1.0, 1.0),
                        spreadRadius: 1,
                        blurRadius: 1,
                      )
                    ]
                ),
                child: Icon(FontAwesomeIcons.google, color: Colors.white,),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _submitLogin() {
    if (_emailController.text.isEmpty) {
      toast("Enter Your Email");
      return;
    }

    if (_passwordController.text.isEmpty){
      toast("Enter Your Password");
      return;
    }


    BlocProvider.of<CredentialCubit>(context).signInSubmit(
        email: _emailController.text, password: _passwordController.text);
  }
}
