import 'package:bloc_cubit/appliaction/profile/bloc/profileb_bloc.dart';
import 'package:bloc_cubit/domain/auth/model/login_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, @required this.loginResponse}) : super(key: key);

  final LoginResponse? loginResponse;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfilebBloc()..add(ProfilebEvent.getAllUserData()),
      child: BlocConsumer<ProfilebBloc, ProfilebState>(
        listener: (context, state) {
          state.maybeMap(
            orElse: () {},
            isLoading: (value) {
              print("Is Loading");
            },
            isSuccess: (value) {
              print(value.userResponse.toJson());
            },
          );
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.loginResponse!.token.toString()),
            ),
            body: Container(
              child: ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  title: Text("Nama"),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
