import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameFieldController = TextEditingController();
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();

  TextFormField _buildTextField(controller, prefixIcon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(),
          prefixIcon: prefixIcon),
      style: GoogleFonts.prompt(
        textStyle: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  color: Theme.of(context).primaryColorDark,
                ),
                child: Form(
                  child: Column(
                    children: [
                      _buildTextField(
                        nameFieldController,
                        const Icon(Icons.person),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildTextField(
                        emailFieldController,
                        const Icon(Icons.alternate_email),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildTextField(
                        passwordFieldController,
                        const Icon(Icons.password),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FractionallySizedBox(
                        widthFactor: 1,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Create account",
                            style: GoogleFonts.prompt(
                              textStyle: const TextStyle(
                                fontSize: 20,
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
    );
  }
}
