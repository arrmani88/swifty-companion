import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class HomeRoute extends StatelessWidget {
  HomeRoute({Key? key}) : super(key: key);

  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(colors: [
            Theme.of(context).splashColor, Theme.of(context).scaffoldBackgroundColor],
            center: const Alignment(0, -0.05),
            radius: 0.9
        )),
        child: InkWell(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: SizedBox(
              width: 500.0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        child: Image.asset('assets/images/app_logo.jpeg'), padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 30.0),
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          label: Text('Enter login', style: TextStyle(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      RoundedLoadingButton(
                        borderRadius: 4.0,
                        color: Colors.white,
                        controller: _btnController,
                        onPressed: () {},
                        child: const Text('Search', style: TextStyle(color: Colors.black, fontSize: 20.0),),
                      )
                    ],
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
