import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:swifty_companion/globals/globals.dart';

class HomeRoute extends StatelessWidget {
  HomeRoute({Key? key}) : super(key: key);

  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();
  final OutlineInputBorder border = OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(0.0));

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
          )),
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
                        Padding(
                          child: Image.asset('assets/images/app_logo.jpeg'), padding: const EdgeInsets.symmetric(horizontal: 60.0),
                        ),
                        const SizedBox(height: 30.0),
                        TextField(
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
                          valueColor: Theme.of(context).scaffoldBackgroundColor,
                          controller: _btnController,
                          onPressed: () async {
                            try {
                              print(accessToken);
                            } catch (e) {
                              print(e);
                            }
                            Navigator.pushNamed(context, 'profile_route');
                          },
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

