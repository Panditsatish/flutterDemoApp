import 'package:demo_flutte/cubits/home_cubit.dart';
import 'package:demo_flutte/pages/home_page.dart';
import 'package:demo_flutte/utils/color_const.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common_widgets/commond_text_field.dart';
import '../cubits/singin_cubit.dart';
import '../states/signin_state.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isHidden = true;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  final formKey = GlobalKey<FormState>();
final controller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return   BlocProvider(
      create: (context) => SignInCubit(),
      lazy: false,
      child: Scaffold(
          body: SafeArea(
            child: BlocConsumer<SignInCubit,SignInState>(
              listener:(BuildContext context,SignInState state) {
                if(state is SignInSuccessState){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlocProvider<HomeCubit>(
                                create: (context) => HomeCubit(),
                                child: const HomeScreen()),
                      ),);
                     }else if(state is SignInEmailValidationState){
                  _isEmailValid = state.isEmailValid;
                }else if(state is SignInPasswordValidState){
                  _isPasswordValid = state.isPassValid;
                }else if(state is SignInPassVisibilityState){
                  _isHidden = state.isPassVisible;
                }
              },
              builder:(BuildContext context,SignInState state){
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: GestureDetector(
                    onTap: (){
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                 color: Colors.white,
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 100,
                              width: 100,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue
                              ),
                              child: const ClipOval(
                                child: Icon(Icons.person,color: Colors.white,size: 80,),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                child: const Text(
                                  "SingIn",
                                  style: TextStyle(
                                      color: ColorConstants.blueColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                )),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Welcome Black!",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  "Login your account",
                                  style: TextStyle(
                                      color: ColorConstants.blueAccentColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            LoginTextField(
                              labelWidget: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(right: 5),
                                      child: const Icon(
                                        Icons.mail,
                                        color: ColorConstants.blueColor,
                                      )),
                                  const Text(
                                    'Email',
                                    style: TextStyle(
                                        color: ColorConstants.blackColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              onChange: (String email) =>
                                  BlocProvider.of<SignInCubit>(context).onEmailValidate(email),
                              widget: _isEmailValid ? const Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 2.0),
                                child: Icon(
                                  Icons.check ,
                                  color:  ColorConstants.greenColor,
                                )):const SizedBox(),
                              hintText: 'Enter your email', labelText: 'Email',
                            ),

                            LoginTextField(
                              labelWidget:  Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(right: 5),
                                      child: const Icon(
                                        Icons.lock,
                                        color: ColorConstants.blueColor,
                                      )),
                                  const Text(
                                    'Password',
                                    style: TextStyle(
                                        color: ColorConstants.blackColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              onChange: (String password) => BlocProvider.of<SignInCubit>(context).onPasswordValidate(password),
                              widget: InkWell(
                                onTap: (){
                                  BlocProvider.of<SignInCubit>(context).onPasswordVisibility(_isHidden);
                                },
                                child: Icon(
                                  _isHidden ?  Icons.visibility_off : Icons.visibility ,
                                ),
                              ),
                              obscureText: _isHidden,
                              hintText: 'Enter your Password',
                              labelText: 'Password',
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 200),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Forgot password?',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: ColorConstants.blueAccentColor),
                                  recognizer: TapGestureRecognizer()
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 55, left: 35, right: 35),
                              width: 350,
                              height: 55,
                              padding: const EdgeInsets.all(5),
                              child: ElevatedButton(
                                  onPressed: (_isEmailValid && _isPasswordValid)
                                      ? () {
                                    BlocProvider.of<SignInCubit>(context).onLoginButtonPress();
                                  }
                                      : null,
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(color: ColorConstants.whiteColor, fontSize: 20),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 15,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  text: "Don't have an account?",
                                  style:
                                 const  TextStyle(fontSize: 12, color: ColorConstants.blueAccentColor),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' Register',
                                      style: const TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        color: ColorConstants.blueColor,),
                                      recognizer: TapGestureRecognizer()
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } ,
            ),
          )
      ),
    );
  }
}

