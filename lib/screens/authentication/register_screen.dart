import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clover_flutter/data_models/user_model.dart';
import 'package:clover_flutter/screens/authentication/education_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firestoreInstance = FirebaseFirestore.instance;
  final authInstance = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final _nameFieldController = TextEditingController();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  bool _isPasswordVisible = false;

  bool _checkEmailValid(email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  void _showSnackBarMessage(message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Let's create your account!",
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColorLight,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameFieldController,
                            autofillHints: const [AutofillHints.name],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required!";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              hintText: "Enter name",
                              prefixIcon: Icon(Icons.person),
                            ),
                            style: GoogleFonts.prompt(
                              textStyle: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _emailFieldController,
                            autofillHints: const [AutofillHints.email],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required!";
                              } else if (!(_checkEmailValid(value))) {
                                return "Invalid email format";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              hintText: "Enter email",
                              prefixIcon: Icon(Icons.alternate_email),
                            ),
                            style: GoogleFonts.prompt(
                              textStyle: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _passwordFieldController,
                            autofillHints: const [AutofillHints.newPassword],
                            obscureText: !_isPasswordVisible,
                            validator: (value) {
                              if (value == null || value.length < 6) {
                                return "Password must be at least 6 characters long!";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: const OutlineInputBorder(),
                              hintText: "Create a password",
                              prefixIcon: const Icon(Icons.password),
                              suffixIcon: InkWell(
                                child: _isPasswordVisible
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                                onTap: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            style: GoogleFonts.prompt(
                              textStyle: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FractionallySizedBox(
                            widthFactor: 1,
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    var name = _nameFieldController.text;
                                    var email = _emailFieldController.text;
                                    var password =
                                        _passwordFieldController.text;
                                    firestoreInstance
                                        .collection("users")
                                        .where("email", isEqualTo: email)
                                        .get()
                                        .then((snapshot) => {
                                              if (snapshot.docs.isEmpty)
                                                {
                                                  firestoreInstance
                                                      .collection("users")
                                                      .add(UserModel(
                                                              name: name,
                                                              email: email,
                                                              password:
                                                                  password,
                                                              education: "0")
                                                          .toJson())
                                                      .then((result) => {
                                                            authInstance
                                                                .createUserWithEmailAndPassword(
                                                                    email:
                                                                        email,
                                                                    password:
                                                                        password)
                                                                .then(
                                                                    (userSession) =>
                                                                        {
                                                                          Navigator.pushAndRemoveUntil(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) => const EducationScreen()),
                                                                              (e) => false)
                                                                        })
                                                          })
                                                }
                                              else
                                                {
                                                  _showSnackBarMessage(
                                                      "An account already exists with this email.")
                                                }
                                            });
                                  }
                                },
                                child: Text(
                                  "Create account",
                                  style: GoogleFonts.prompt(
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
