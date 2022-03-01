import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_cubit.dart';
import 'package:majootestcase/common/widget/custom_button.dart';
import 'package:majootestcase/common/widget/text_form_field.dart';
import 'package:majootestcase/models/user.dart';
import 'package:majootestcase/ui/home/home_bloc_screen.dart';
import 'package:majootestcase/ui/auth/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final _emailController = TextController();
  final _passwordController = TextController();

  final connectivity = Connectivity();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final pattern = new RegExp(r'([\d\w]{1,}@[\w\d]{1,}\.[\w]{1,})');

  bool _isObscurePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBlocCubit, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthBlocLoggedInState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (context) =>
                      HomeBlocCubit(connectivity: connectivity),
                  child: HomeBlocScreen(),
                ),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 75, left: 25, bottom: 25, right: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Selamat Datang',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    // color: colorBlue,
                  ),
                ),
                Text(
                  'Silahkan login terlebih dahulu',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                _form(),
                SizedBox(
                  height: 50,
                ),
                CustomButton(
                  text: 'Login',
                  onPressed: handleLogin,
                  height: 100,
                ),
                SizedBox(
                  height: 50,
                ),
                _register(),
              ],
            ),
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
            controller: _emailController,
            isEmail: true,
            hint: 'Example@123.com',
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

  Widget _register() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return RegisterPage();
            },
          ));
        },
        child: RichText(
          text: TextSpan(
            text: 'Belum punya akun? ',
            style: TextStyle(color: Colors.black45),
            children: [
              TextSpan(text: 'Daftar'),
            ],
          ),
        ),
      ),
    );
  }

  void handleLogin() async {
    final _email = _emailController.value;
    final _password = _passwordController.value;

    if (_email.isNotEmpty && _password.isNotEmpty) {
      if (pattern.hasMatch(_email)) {
        AuthBlocCubit authBlocCubit = AuthBlocCubit();
        User user = User(
          email: _email,
          password: _password,
        );
        authBlocCubit.loginUser(user, context);
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
