
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:piller/common/constants.dart';
import 'package:piller/common/styles.dart';
import 'package:piller/common/widgets/background_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sikeres bejelentkezés!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Padding(
          padding: EdgeInsets.all(UIConstants.defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('login_title'.tr(), style: AppTextStyles.headline,),
                SizedBox(height: UIConstants.largePadding),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Az email megadása kötelező';
                    }
                    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}").hasMatch(value)) {
                      return 'Érvényes email címet adj meg';
                    }
                    return null;
                  },
                ),
                SizedBox(height: UIConstants.defaultPadding),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Jelszó'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'A jelszó megadása kötelező';
                    }
                    if (value.length < 6) {
                      return 'A jelszónak legalább 6 karakter hosszúnak kell lennie';
                    }
                    return null;
                  },
                ),
                SizedBox(height: UIConstants.largePadding),
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Bejelentkezés'),
                  style: AppButtonStyles.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
