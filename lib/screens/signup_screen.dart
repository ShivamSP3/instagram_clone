// ignore_for_file: prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List ? _image;
  bool _isloading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _passwordController.dispose();
  }

   void selectImage()async{
    Uint8List im =  await pickImage(ImageSource.gallery);
    setState(() {
    _image =im;
    });
   }
   void signUpUser()async {
    setState(() {
      _isloading = true;
    });
        String res = await AuthMethods().signUpUser(
          email: _emailController.text,
           username: _usernameController.text,
          password: _passwordController.text,
          bio: _bioController.text,
          file: _image!);
       setState(() {
      _isloading = true;
    });
    if (res !='Success') {
      showSnackBar(context,res);
    }else{
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),)));
    }
     }
    void navigateToLogin(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Flexible(child: Container(),flex: 1,),
               SvgPicture.asset('assets/ic_instagram.svg',color: primaryColor,height: 64,),
               SizedBox(height: 40,),
               //Circular Widget to accept and show pic
               Stack(
                children: [
                  _image != null ?
                   CircleAvatar(
                    radius: 64,
                    backgroundImage:MemoryImage(_image!),
                  ) :
                  CircleAvatar(
                    radius: 64,
                    backgroundImage:NetworkImage('https://www.chocolatebayou.org/wp-content/uploads/No-Image-Person-2048x2048.jpeg')
                  ),
                  Positioned(
                  bottom: -10,
                  left: 80,  
                  child: IconButton(onPressed: selectImage,
                  icon: Icon(Icons.add_a_photo),
                  ))
                ],
               ),
               SizedBox(height: 20,),
               TextFieldInput(
                hintText: 'Enter Your Username',
                controller: _usernameController,
                textInputType: TextInputType.text),
                SizedBox(height: 20,),
                TextFieldInput(
                hintText: 'Enter Your Bio',
                controller: _bioController,
                textInputType: TextInputType.text),
                SizedBox(height: 20,),
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
                  child:_isloading
                  ? Center(child: CircularProgressIndicator(color: primaryColor,),)
                  : Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: ShapeDecoration(shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4))
                    ),color: blueColor),
                    child: Text('Sign Up'),
                  ),
                  onTap: signUpUser
                ),
                SizedBox(height: 12,),
                Flexible(child: Container(),flex: 1,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Container(child: Text("Already have an account?"),
                   padding: EdgeInsets.symmetric(vertical: 8),),
                    GestureDetector(
                      onTap: navigateToLogin,
                      child: Container(child: Text(" Log In",style: TextStyle(fontWeight: FontWeight.bold),),
                                     padding: EdgeInsets.symmetric(vertical: 8),),
                    )
                ],)
             ],
               ),
          ),
        )),
    );
  }
}