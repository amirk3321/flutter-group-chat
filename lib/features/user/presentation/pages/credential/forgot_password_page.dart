import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_chat/features/global/common/common.dart';
import 'package:flutter_group_chat/features/global/const/app_const.dart';
import 'package:flutter_group_chat/features/global/const/page_const.dart';
import 'package:flutter_group_chat/features/global/custom_text_field/textfield_container.dart';
import 'package:flutter_group_chat/features/global/theme/style.dart';
import 'package:flutter_group_chat/features/global/widgets/container_button.dart';
import 'package:flutter_group_chat/features/user/presentation/cubit/credential/credential_cubit.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {


  TextEditingController _emailController = TextEditingController();


  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 32),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Forgot Password',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: greenColor),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Don't worry! Just fill in your email and ${AppConst.appName} will send you a link to rest your password.",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(.6),
                    fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 30,),
              TextFieldContainer(
                prefixIcon: Icons.email,
                controller: _emailController,
                hintText: "Email",
              ),
              SizedBox(height: 30,),
              ContainerButton(
                title: "Send Password Rest Email",
                onTap: (){
                  _submitForgotPasswordEmail();
                },
              ),
              SizedBox(height: 30,),
              Row(
                children: [
                  Text(
                    'Remember the account information? ',
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamedAndRemoveUntil(context, PageConst.loginPage, (route) => false);
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
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submitForgotPasswordEmail() {
    
    if (_emailController.text.isEmpty){
      toast("Enter your email");
      return;
    }
    
    
    BlocProvider.of<CredentialCubit>(context).forgotPassword(email: _emailController.text).then((value) {
      toast("Email has been sent please check your mail.");
    });
    
  }
}
