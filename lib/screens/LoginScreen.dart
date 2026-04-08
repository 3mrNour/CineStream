import 'package:cinestream/screens/MainScreen.dart';
import 'package:cinestream/screens/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: .infinity,
        height: .infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff291E40), Color(0xff413066), Color(0xff120D1D)],
            stops: [0.1, 0.5, 0.9],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: -150,
              child: RotatedBox(
                quarterTurns: 3,
                child: Opacity(
                  opacity: 0.02,
                  child: Image(
                    image: AssetImage('assets/images/CineStream.png'),
                    width: 800,
                  ),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/CineStream.png'),
                      width: 150,
                    ),
                    Text(
                      "Log in",
                      style: TextStyle(
                        color: Color(0xffFFCD30),
                        fontSize: 32,
                        fontWeight: .w600,
                      ),
                    ),
                    SizedBox(height: 50),
                    SizedBox(
                      width: 320,
                      child: FormBuilder(
                        key: _formKey,
                        child: Column(
                          children: [
                            FormBuilderTextField(
                              name: 'email',
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(68, 255, 255, 255),
                                ),
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Color(0xffFFCD30),
                                ),
                                filled: true,
                                fillColor: Color.fromARGB(160, 65, 48, 102),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(0, 255, 207, 48),
                                    width: 0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color(0xffFFCD30),
                                    width: 1.5,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.redAccent,
                                    width: 1.5,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.redAccent,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.email(),
                              ]),
                            ),
                            const SizedBox(height: 30),
                            FormBuilderTextField(
                              name: 'password',
                              obscureText: true,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(68, 255, 255, 255),
                                ),
                                prefixIcon: const Icon(
                                  Icons.password,
                                  color: Color(0xffFFCD30),
                                ),
                                filled: true,
                                fillColor: Color.fromARGB(160, 65, 48, 102),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(0, 255, 207, 48),
                                    width: 0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color(0xffFFCD30),
                                    width: 1.5,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.redAccent,
                                    width: 1.5,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.redAccent,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                            const SizedBox(height: 30),
                            MaterialButton(
                              color: Color(0xffFFCD30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              minWidth: .maxFinite,
                              height: 55,
                              onPressed: () {
                                // Validate and save the form values
                                _formKey.currentState?.saveAndValidate();
                                debugPrint(
                                  _formKey.currentState?.value.toString(),
                                );

                                // On another side, can access all field values without saving form with instantValues
                                _formKey.currentState?.validate();
                                debugPrint(
                                  _formKey.currentState?.instantValue
                                      .toString(),
                                );
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => MainScreen(),
                                  ),
                                );
                              },
                              child: const Text('Login'),
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: .center,
                              children: [
                                Text(
                                  "Don't have an account?  ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => RegisterScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(
                                      color: Color(0xffFFCD30),
                                      fontWeight: .w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
