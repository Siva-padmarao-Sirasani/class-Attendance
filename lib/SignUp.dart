import 'package:attendance/AuthScreens/AuthService.dart';
import 'package:attendance/AuthScreens/FirebaseAuth.dart';
import 'package:attendance/HomeScreen.dart';
import 'package:attendance/PhoneAuth.dart';
import 'package:attendance/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _State();
}

class _State extends State<SignUp> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  final AuthService authClass = AuthService();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff000509),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xff7e8087),Color(0xff000509)])
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20, color:Colors.white,fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),

                  InkWell(
                    onTap: () async {
                      User? user = await authClass.googleSignIn();
                      if (user != null) {
                        // User signed in with Google, navigate to home screen
                        Get.offAll(() => const HomeScreen());
                      } else {
                        // Handle the case when Google Sign-In fails
                        print("Google Sign-In failed.");
                      }
                    },
                    child: Container(
                      height: 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.grey,
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 10.0,),
                          SvgPicture.asset(
                            'assets/images/google.svg',
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 20),
                          const Text('Continue with Google'),
                          const SizedBox(height: 15.0,),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 15.0,),
                  Container(
                    height: 60.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.grey,
                    ),
                    child: InkWell(
                      onTap: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PhoneAuthPage()), // Replace 'PhoneScreen' with the actual name of your Phone screen class
                        );
                      },
                      child: const Row(
                        children: [
                          SizedBox(width: 10.0,),
                          Icon(Icons.phone, size: 30.0, color: Colors.blue,),
                          SizedBox(width: 20.0,),
                          Text("Continue With Phone"),
                        ],
                      ),
                    ),
                  ),


                  const SizedBox(height: 20),
                  const Text("Or",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Email',
                      filled: true,
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                    obscureText: true,
                    decoration: InputDecoration(

                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.grey,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.remove_red_eye),
                        onPressed: () {
                          // Toggle password visibility
                        },
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: signUp,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? ',style: TextStyle(color: Colors.white),),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>const SignIn()),
                          );
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void signUp() async{
    try {
      String? email=emailController.text;
      String? password=passwordController.text;
      User? user=await _auth.signUpWithEmailAndPassword(email, password);
      if(user!=null) {
        Get.offAll(()=>const HomeScreen());
      }
    }
    catch(e){
      print(e);
    }
  }
}
