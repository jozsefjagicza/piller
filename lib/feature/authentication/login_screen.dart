import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:piller/common/decorations.dart';
import 'package:provider/provider.dart';
import 'package:piller/common/constants.dart';
import 'package:piller/common/styles.dart';
import 'package:piller/common/widgets/background_widget.dart';
import 'package:piller/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Scaffold(
          body: BackgroundWidget(
            child: Padding(
              padding: EdgeInsets.all(UIConstants.defaultPadding),
              child: Form(
                key: authProvider.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('login_title'.tr(), style: AppTextStyles.headline),
                    SizedBox(height: UIConstants.largePadding),
                    TextFormField(
                      controller: authProvider.usernameController,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: authProvider.usernameFocusNode,
                      decoration: InputDecorations.customInputDecoration(
                        labelText: 'login_username'.tr(),
                      ),
                      validator: (value) => authProvider.validateUsername(value),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(height: UIConstants.defaultPadding),
                    TextFormField(
                      controller: authProvider.passwordController,
                      obscureText: authProvider.obscureText,
                      decoration: InputDecorations.customInputDecoration(
                        labelText: 'login_password'.tr(),
                        isSuffix: true,
                        suffixIconButton: IconButton(
                          icon: Icon(
                            authProvider.obscureText ? Icons.visibility : Icons
                                .visibility_off,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              authProvider.obscureText = !authProvider.obscureText;
                            });
                          },
                        ),
                      ),
                      validator: (value) => authProvider.validatePassword(value),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    SizedBox(height: UIConstants.largePadding),
                    ElevatedButton(
                      onPressed: () async {
                        if (authProvider.isLoading) return;
                        final messenger = ScaffoldMessenger.of(context);
                        await authProvider.login();

                        if (authProvider.isAuthenticated) {
                          messenger.showSnackBar(
                            SnackBar(content: Text('login_success'.tr())),
                          );
                          if(!mounted) return;
                          await Future.delayed(Duration(seconds: 3));
                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          messenger.showSnackBar(
                            SnackBar(content: Text('login_failed'.tr())),
                          );
                        }
                      },
                      style: AppButtonStyles.primary,
                      child: authProvider.isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('login_title'.tr()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
