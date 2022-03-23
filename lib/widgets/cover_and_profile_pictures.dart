import 'package:flutter/material.dart';
import 'package:notifier_42/constants/constants.dart';
import 'package:notifier_42/globals/globals.dart';
import 'package:provider/provider.dart';
import 'package:notifier_42/providers/user_provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CoverAndProfilePictures extends StatelessWidget {
  // final String? profilePictureURL;
  CoverAndProfilePictures({Key? key}) : super(key: key);
  final double profileImageSize = kScreenWidth > 500 ? 250 : kScreenWidth * 0.5;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          child: Image.asset('assets/images/cover.jpg', width: 500.0,), padding: EdgeInsets.only(bottom: profileImageSize / 2),
        ),
        Positioned(
          bottom: 0,
          left: (profileImageSize + 5) / 2,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              width: profileImageSize - 16,
              height: profileImageSize - 16,
              child: Image.network(
                (context.watch<UserProvider>().imageURL)!,
                fit: BoxFit.fitWidth,
                errorBuilder: (context, exception, stackTrace) {
                  return Image.asset('assets/images/blank_profile_picture.png');
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingAnimationWidget.dotsTriangle(color: Colors.white, size: 100.0),
                        const SizedBox(height: 20.0),
                        const FittedBox(fit: BoxFit.fitWidth, child: Text('Loading ...', style: TextStyle(color: Colors.white, fontSize: 25.0))),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}

