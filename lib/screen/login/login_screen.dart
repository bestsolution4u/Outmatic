import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outmatic/bloc/bloc.dart';
import 'package:outmatic/config/image.dart';
import 'package:outmatic/config/preference_param.dart';
import 'package:outmatic/util/app_theme.dart';
import 'package:outmatic/util/keyboard_util.dart';
import 'package:outmatic/util/preference_helper.dart';
import 'package:outmatic/util/toasts.dart';
import 'package:outmatic/widget/button/app_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc;
  TextEditingController _emailController, _passwordController;
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    if (PreferenceHelper.getBool(PreferenceParam.saveCredentials, false)) {
      _checked = true;
      _emailController.text = PreferenceHelper.getString(PreferenceParam.email, "");
      _passwordController.text = PreferenceHelper.getString(PreferenceParam.password, "");
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login() {
    KeyboardUtil.hideKeyboard(context);
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      _loginBloc.add(OnLoginEvent(
          email: _emailController.text,
          password: _passwordController.text,
          save: _checked));
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Images.Background,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              Expanded(
                child: Container(),
              ),
              Image.asset(Images.Logo, width: width * 2 / 3),
              Expanded(
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'E-mailadres',
                          hintText: "",
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          )),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Wachtwoord',
                          hintText: "",
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          )),
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: _checked,
                          activeColor: Colors.white,
                          checkColor: AppTheme.primaryColor,
                          onChanged: (value) {
                            setState(() {
                              _checked = value;
                            });
                          },
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _checked = !_checked;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                'Onthouden',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, loginState) => BlocListener<LoginBloc, LoginState>(
                        listener: (context, state) {
                          if (state is LoginFailed) {
                            ToastUtils.showErrorToast(
                                context, "Inloggen mislukt");
                          } else if (state is LoginSuccess) {
                            ToastUtils.showErrorToast(
                                context, "Succesvol ingelogd");
                          }
                        },
                        child: AppButton(
                          text: "INLOGGEN",
                          onPressed: login,
                          disableTouchWhenLoading: true,
                          loading: loginState is LoginLoading,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
