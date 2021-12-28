import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:state_manage/application/profile/bloc/profileb_bloc.dart';
import 'package:state_manage/domain/auth/model/login_response.dart';
import 'package:state_manage/domain/core/user/model/user_response.dart';
import 'package:state_manage/presentation/sign_in/sign_in_page.dart';
import '../../../utils/constants.dart' as constants;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginResponse? loginResponse = null;

  @override
  void initState() {
    final _data = GetStorage().read(constants.USER_LOCAL_KEY);
    loginResponse = jsonDecode(_data);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfilebBloc()..add(ProfilebEvent.getAllUser()),
        child: BlocConsumer<ProfilebBloc, ProfilebState>(
          listener: (context, state) {
            state.maybeMap(
                orElse: () {},
                isLoading: (value) {
                  print("is Loading");
                },
                isSucess: (value) {
                  print(value.userResponse.toJson());
                });
          },
          builder: (context, state) {
            return state.maybeMap(
                orElse: () => homePageError(context),
                isLoading: (val) => homePageLoading(),
                isError: (err) => homePageError(context),
                isSucess: (value) =>
                    homePageScaffold(value.userResponse.data!));
          },
        ));
  }

  Scaffold homePageError(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Oops, something wrong !!"),
            IconButton(
                onPressed: () => context
                    .read<ProfilebBloc>()
                    .add(ProfilebEvent.getAllUser()),
                icon: Icon(Icons.replay))
          ],
        ),
      ),
    );
  }

  Scaffold homePageLoading() => Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );

  Scaffold homePageScaffold(List<UserData> _data) {
    return Scaffold(
        appBar: AppBar(
          title: Text("State Management"),
          actions: [
            IconButton(onPressed: () {
              GetStorage().erase();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPage()));
            }, icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: Container(
          child: ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) => ListTile(
                    title: Text(_data[index].firstName.toString()),
                  )),
        ));
  }
}
