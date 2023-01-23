// ignore_for_file: prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
 bool isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  void loginUser()async{
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().loginUser(email: _emailController.text, password: _passwordController.text);
    if (res=='Success') {
          Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
          (route) => false);

      setState(() {
        
        isLoading = false;
      });
    }else{
      showSnackBar(context,res);
    }
     setState(() {
      isLoading = false;
    });
  }
  void navigateToSignUp(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen(),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
        child: Container(
          padding:
           MediaQuery.of(context).size.width> webScreenSize ?
           EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/3)
          : EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Flexible(child: Container(),flex: 2,),
             SvgPicture.asset('assets/ic_instagram.svg',color: primaryColor,height: 64,),
             SizedBox(height: 65,),
             TextFieldInput(
              hintText: 'Enter Your Email',
              controller: _emailController,
              textInputType: TextInputType.emailAddress),
              SizedBox(height: 20,),
              TextFieldInput(
              hintText: 'Enter Your Password',
              controller: _passwordController,
              isPass: true,
              textInputType: TextInputType.text,),
              SizedBox(height: 20,),
              InkWell(
                child: isLoading? Center(child: CircularProgressIndicator(color: primaryColor,),):
                 Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: ShapeDecoration(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4))
                  ),color: blueColor),
                  child: Text('Log In'),
                ),onTap: loginUser,
              ),
              SizedBox(height: 12,),
              Flexible(child: Container(),flex: 2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Container(child: Text("Don't have an account?"),
                 padding: EdgeInsets.symmetric(vertical: 8),),
                  GestureDetector(
                    onTap: navigateToSignUp,
                    child: Container(child: Text(" Sign Up",style: TextStyle(fontWeight: FontWeight.bold),),
                                   padding: EdgeInsets.symmetric(vertical: 8),),
                  )
              ],)
           ],
       ),
        )),
    );
  }
}