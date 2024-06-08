import 'package:flutter/material.dart';
import 'package:new_project/StartPages/home_page.dart';
import 'package:new_project/StartPages/sign_up.dart';
import 'package:new_project/widgets/from_conteiner_widget.dart';
import 'package:new_project/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const screenRoute = '/login';

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  bool _isSigningin = false;
  final FirebaseAuthService _auth = FirebaseAuthService();

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
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage("images/7.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Text(
                "LET'S \nDISCOVER EGYPT",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'MadimiOne',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 50),
            FromConteinerWidget(
              controller: _emailController,
              prefixIcon: Icons.email,
              hintText: "Email",
              isPasswordField: false,
            ),
            SizedBox(height: 20),
            FromConteinerWidget(
              controller: _passwordController,
              prefixIcon: Icons.lock,
              hintText: "Password",
              isPasswordField: true,
            ),
            SizedBox(height: 50),
            Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: GestureDetector(
                  onTap: _signIn,
                  child: _isSigningin
                      ? CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : Text(
                          "Log in",
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(height: 100),
            Container(
              width: 250,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an Account?",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 7),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(Signup.screenRoute);
                      },
                      child: Text(
                        "Sign up ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    setState(() {
      _isSigningin = true;
    });
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('email', _emailController.text);
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigningin = false;
    });

    if (user != null) {
      print("User Is Successfully Signed in");
      Navigator.of(context).pushReplacementNamed(Homepage.screenRoute);
    } else {
      print("Something Not Correct");
    }
  }
}


//class Homepage extends StatelessWidget {
  //const Homepage({super.key});
  //static String id = 'homepage';

  //@override
  //Widget build(BuildContext context) {
    //return Scaffold(
     // appBar: AppBar(title: Text("Home Page")),
      //body: Center(
        //child: ElevatedButton(
          //onPressed: () {
            //Navigator.pop(context);
          //},
          //child: Text('Go Back'),
        //),
      //),
    //);
  //}
//}
