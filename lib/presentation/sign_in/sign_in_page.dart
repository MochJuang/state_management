// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' as ui;

import 'package:state_manage/application/auth/cubit/auth_cubit.dart';
import 'package:state_manage/domain/auth/model/login_request.dart';
import 'package:state_manage/infrastructure/auth/auth_repository.dart';
import 'package:state_manage/presentation/home/home_page.dart';

class SignInPage extends StatefulWidget {
  static final String path = "lib/src/pages/login/login10.dart";

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if(state is AuthError){
            showDialog(context: context, builder: (contex) => AlertDialog(
              title: Text("Error"),
              content : Text(state.errorMessage.toString())
            ));
          }else if(state is AuthLoading){
            print("loading...");
          }else if(state is AuthLoginSuccess){
            context.watch<AuthCubit>().saveStorage(state.dataLogin);
          }else if(state is AuthSuccess){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
          }
        },
        builder: (context, state) {
          return Container(
            color: Colors.grey.shade300,
            child: Stack(
              children: [
                CustomPaint(
                  size: MediaQuery.of(context).size,
                  painter: RPSCustomPainter(),
                ),
                Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: _buildAppBar(context),
                  body: ListView(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 60,
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              "Hello",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800,
                                  ),
                            ),
                            Text(
                              "Sign in your account",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(height: 20.0),
                            TextField(
                              controller: this._emailController,
                              // ignore: prefer_const_constructors
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Email address",
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            TextField(
                              controller: this._passwordController,
                              // obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Password",
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Text("Forgot your Password?")),
                            const SizedBox(height: 20.0),
                            (state is AuthLoading) ? _loginButtonLoading() : _loginButton(context),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          const SizedBox(width: 10.0),
                          Text(
                            "Register Now",
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  RaisedButton _loginButton(BuildContext context) {
    return RaisedButton(
      padding: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0)),
      color: Colors.orange,
      textColor: Colors.white,
      onPressed: () {
        LoginRequest loginRequest = LoginRequest(
          email: "eve.holt@reqres.in",
          password: "cityslicka"
        );
        context.watch<AuthCubit>().signInUser(loginRequest);
      },
      child: Text("Login"),
    );
  }

  RaisedButton _loginButtonLoading() {
    return RaisedButton(
      padding: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0)),
      color: Colors.orange,
      textColor: Colors.white,
      onPressed: null,
      child: CircularProgressIndicator(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Row(
          children: [
            Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
            ),
            Text(
              "Back",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint_0.shader = ui.Gradient.linear(
        Offset(size.width * 0.64, size.height * 0.11),
        Offset(size.width, size.height * 0.11),
        [Color(0x55e17e51), Color(0x99cd5c0b)],
        [0.00, 1.00]);

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.64, 0);
    path_0.quadraticBezierTo(size.width * 0.74, size.height * 0.09,
        size.width * 0.79, size.height * 0.08);
    path_0.cubicTo(size.width * 0.74, size.height * 0.09, size.width * 0.69,
        size.height * 0.14, size.width * 0.71, size.height * 0.17);
    path_0.quadraticBezierTo(size.width * 0.72, size.height * 0.19,
        size.width * 0.79, size.height * 0.21);
    path_0.quadraticBezierTo(
        size.width * 0.93, size.height * 0.24, size.width, size.height * 0.21);
    path_0.quadraticBezierTo(size.width, size.height * 0.16, size.width, 0);
    path_0.lineTo(size.width * 0.64, 0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);

    Paint paint_1 = new Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint_1.shader = ui.Gradient.linear(
        Offset(size.width * 0.64, size.height * 0.12),
        Offset(size.width, size.height * 0.12),
        [Color(0x6ade8146), Color(0x87b75b0a)],
        [0.00, 1.00]);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.64, size.height * 0.08);
    path_1.quadraticBezierTo(size.width * 0.68, size.height * 0.15,
        size.width * 0.76, size.height * 0.13);
    path_1.cubicTo(size.width * 0.81, size.height * 0.15, size.width * 0.71,
        size.height * 0.22, size.width * 0.74, size.height * 0.24);
    path_1.quadraticBezierTo(
        size.width * 0.81, size.height * 0.27, size.width, size.height * 0.18);
    path_1.lineTo(size.width, 0);
    path_1.quadraticBezierTo(size.width * 0.83, 0, size.width * 0.77, 0);
    path_1.quadraticBezierTo(size.width * 0.66, size.height * 0.02,
        size.width * 0.64, size.height * 0.08);
    path_1.close();

    canvas.drawPath(path_1, paint_1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
