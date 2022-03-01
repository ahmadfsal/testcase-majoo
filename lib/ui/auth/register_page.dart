import 'package:flutter/material.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:majootestcase/common/widget/custom_button.dart';
import 'package:majootestcase/common/widget/text_form_field.dart';
import 'package:majootestcase/models/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextController();
  final _emailController = TextController();
  final _passwordController = TextController();

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final pattern = new RegExp(r'([\d\w]{1,}@[\w\d]{1,}\.[\w]{1,})');

  bool _isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 75, left: 25, bottom: 25, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Daftar Akun Baru',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  // color: colorBlue,
                ),
              ),
              SizedBox(height: 9),
              _form(),
              SizedBox(height: 40),
              CustomButton(
                text: 'Daftar',
                onPressed: handleRegister,
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _form() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            context: context,
            controller: _usernameController,
            hint: 'yuri',
            label: 'Username',
          ),
          CustomTextFormField(
            context: context,
            controller: _emailController,
            isEmail: true,
            hint: 'yuri@gmail.com',
            label: 'Email',
          ),
          CustomTextFormField(
            context: context,
            label: 'Password',
            hint: 'password',
            controller: _passwordController,
            isObscureText: _isObscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _isObscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
              onPressed: () {
                setState(() {
                  _isObscurePassword = !_isObscurePassword;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void handleRegister() {
    final _username = _usernameController.value;
    final _email = _emailController.value;
    final _password = _passwordController.value;

    if (_username.isNotEmpty && _email.isNotEmpty && _password.isNotEmpty) {
      if (pattern.hasMatch(_email)) {
        AuthBlocCubit authBlocCubit = AuthBlocCubit();
        User user = User(
          userName: _username,
          email: _email,
          password: _password,
        );
        authBlocCubit.registerUser(user, context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Masukkan e-mail yang valid'),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        'Form tidak boleh kosong, mohon cek kembali data yang anda inputkan',
      )));
    }
  }
}
