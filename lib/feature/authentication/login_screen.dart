import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:piller/di/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:piller/common/constants.dart';
import 'package:piller/common/styles.dart';
import 'package:piller/common/widgets/background_widget.dart';
import 'package:piller/providers/auth_provider.dart'; // Importáljuk a provider-t

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => locator<AuthProvider>(),
      child: Consumer<AuthProvider>(
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
                        controller: authProvider.emailController,
                        keyboardType: TextInputType.emailAddress,
                        focusNode: authProvider.emailFocusNode,
                        decoration: InputDecorations.customInputDecoration(
                          labelText: 'login_email'.tr(),
                        ),
                        validator: (value) => authProvider.validateEmail(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      SizedBox(height: UIConstants.defaultPadding),
                      TextFormField(
                        controller: authProvider.passwordController,
                        obscureText: true,
                        decoration: InputDecorations.customInputDecoration(
                          labelText: 'login_password'.tr(),
                        ),
                        validator: (value) => authProvider.validatePassword(value),
                      ),
                      SizedBox(height: UIConstants.largePadding),
                      ElevatedButton(
                        onPressed: () async {
                          final messenger = ScaffoldMessenger.of(context);
                          await authProvider.login();
                          if (authProvider.isAuthenticated) {
                            messenger.showSnackBar(
                              SnackBar(content: Text('login_success'.tr())),
                            );
                            Navigator.pushReplacementNamed(context, '/home');
                          } else {
                            messenger.showSnackBar(
                              SnackBar(content: Text('login_failed'.tr())),
                            );
                          }
                        },
                        style: AppButtonStyles.primary,
                        child: Text('login_title'.tr()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
