import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/app_logo.jpeg', height: 250.0,),
                  const SizedBox(height: 30.0,),
                  Row(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).secondaryHeaderColor, // fillColor: Colors.white,
                          label: Text('Enter login here'),
                          border: OutlineInputBorder()
                        ),
                      ),
                      RoundedLoadingButton(controller: controller, onPressed: onPressed, child: child)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
