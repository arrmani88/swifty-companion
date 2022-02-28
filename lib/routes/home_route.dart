import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:swifty_companion/functions/parse_user_data.dart';
import 'package:swifty_companion/functions/validate_access_token.dart';
import 'package:swifty_companion/globals/globals.dart';
import 'package:swifty_companion/constants/constants.dart';
import 'package:dio/dio.dart';

class HomeRoute extends StatelessWidget {
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();
  final OutlineInputBorder border = OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(0.0));
  final TextEditingController textController = TextEditingController();
  HomeRoute({Key? key}) : super(key: key);

  void onSearchPressed (BuildContext context) async {
    try {
      validateAccessToken();
      Response _response = await dio.get(
        // hostname + '/v2/users/' + textController.text,
        hostname + '/v2/users/anel-bou',
        options: Options(headers: {'Authorization': 'Bearer ' + accessToken}),
      );
      parseUserData(_response);
    } catch (e) {
      print(e);
    }
    Navigator.pushReplacementNamed(context, 'profile_route');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(colors: [
              Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor],
                center: const Alignment(0, -0.05),
                radius: 0.8
            )
          ),
          child: SafeArea(
            child: Center(
              child: SizedBox(
                width: 500.0,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(child: Hero(tag: 'app_logo', child: Image.asset('assets/images/app_logo.jpeg')), padding: const EdgeInsets.symmetric(horizontal: 60.0),),
                        const SizedBox(height: 30.0),
                        TextField(
                          controller: textController,
                          decoration: InputDecoration(
                            label: const Text('Enter login', style: TextStyle(color: Colors.white)),
                            enabledBorder: border,
                            focusedBorder: border,
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        RoundedLoadingButton(
                          width: 500.0,
                          borderRadius: 0.0,
                          color: Colors.white,
                          disabledColor: const Color(0xFFFFFFFF),
                          valueColor: Theme.of(context).scaffoldBackgroundColor,
                          controller: _btnController,
                          onPressed: () => onSearchPressed(context),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 3.5),
                            child: Text('Search', style: TextStyle(color: Colors.black, fontSize: 20.0)),
                          ),
                        ),
                        const SizedBox(height: 100.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
