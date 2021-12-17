import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firestoreInstance = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  final _nameFieldController = TextEditingController();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  bool _isPasswordVisible = true;

  bool checkEmailValid(email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
              FractionallySizedBox(
                widthFactor: 0.8,
                child: Container(
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
                            label: Text("Name"),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "This field is required!";
                            } else if (!(checkEmailValid(value))) {
                              return "Invalid email format";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            label: Text("Email"),
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
                            label: const Text("Password"),
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
                                  firestoreInstance.collection("users").add({
                                    'name': _nameFieldController.text,
                                    'email': _emailFieldController.text,
                                    'password': _passwordFieldController.text
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
              ),
              const SizedBox(
                height: 40,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}