import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_manage/application/auth/cubit/auth_cubit.dart';
import 'package:state_manage/presentation/home/home_page.dart';
import 'package:state_manage/presentation/sign_in/sign_in_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..loadData(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
           if(state is AuthLoginSuccess){
             Navigator.of(context).push( MaterialPageRoute(builder: (context) => HomePage()) );
           }else if(state is AuthError){
             Navigator.of(context).push( MaterialPageRoute(builder: (context) => SignInPage()) );

           }
        },
        child: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
