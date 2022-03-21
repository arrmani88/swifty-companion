import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:notifier_42/functions/validate_access_token.dart';
import 'package:notifier_42/globals/globals.dart';
import 'package:provider/provider.dart';
import 'package:notifier_42/providers/target_provider.dart';
import 'package:notifier_42/providers/user_provider.dart';
import 'package:notifier_42/widgets/pop_ups/error_pop_up.dart';
import 'package:notifier_42/widgets/pop_ups/loading_pop_up.dart';
import 'package:notifier_42/widgets/pop_ups/user_not_found_pop_up.dart';
import 'package:notifier_42/providers/pop_up_provider.dart';

class HomeRoute extends StatefulWidget {
  HomeRoute({Key? key}) : super(key: key);
  @override
  State<HomeRoute> createState() => _HomeRouteState();
}
class _HomeRouteState extends State<HomeRoute> {
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();
  final OutlineInputBorder border = OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(0.0));
  final TextEditingController textController = TextEditingController();
  String? descriptionMessage;

  void onSearchPressed (BuildContext context, RoundedLoadingButtonController _btnController) async {
    // try {
      FocusManager.instance.primaryFocus?.unfocus();
      _btnController.start();
      var status = await context.read<UserProvider>().getThisUser(textController.text.isEmpty ? 'anel-bou' : textController.text, context.read<TargetProvider>().targetedItemsData);
      // var status = await context.read<UserProvider>().getThisUser('anel-bou');
      if (status == ConnectionStatus.success) {
        Navigator.pushNamed(context, 'routes_holder');
      } else if (status == ConnectionStatus.notFound) {
        context.read<PopUpProvider>().displayUserNotFoundPopUp();
      } else if (status == ConnectionStatus.noInternet) {
        context.read<PopUpProvider>().displayNoInternetPopUp();
      }
    // } catch (e) {
    //   if (e is DioError) {
    //     context.read<PopUpProvider>().displayUnknownErrorPopUp();
    //     descriptionMessage = (e.response?.data as Map<String, dynamic>)['error_description'];
    //   } else {
    //     context.read<PopUpProvider>().displayUnknownErrorPopUp();
    //     descriptionMessage = e.toString();
    //   }
    // }
    textController.clear();
    _btnController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          InkWell(
            onTap: () => context.read<PopUpProvider>().hideAllPopUps(),
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
                              animateOnTap: false,
                              width: 500.0,
                              borderRadius: 0.0,
                              color: Colors.white,
                              disabledColor: const Color(0xFFFFFFFF),
                              valueColor: Theme.of(context).scaffoldBackgroundColor,
                              controller: _btnController,
                              // onPressed: () => textController.text.isNotEmpty ? onSearchPressed(context, _btnController) : _btnController.reset(),
                              onPressed: () => onSearchPressed(context, _btnController),
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
          if (context.watch<PopUpProvider>().isUserNotFoundPopUpDisplayed == true) const UserNotFoundPopUp()
          else if (context.watch<PopUpProvider>().isNoInternetPopUpDisplayed == true) ErrorPopUp(closePopUp: () {}, descriptionMessage: 'Either your device isn\'t connected to the internet, or the server that you are looking for is down',)
          else if (context.watch<PopUpProvider>().isUnknownErrorPopUpDisplayed == true) ErrorPopUp(closePopUp: () {}, descriptionMessage: descriptionMessage,)
        ],
      ),
    );
  }
}


/*
onPressed: textController.text.isNotEmpty
  ? () { onSearchPressed(context, _btnController); print('1: >${textController.text}<');}
  : () { _btnController.reset(); print('2: >${textController.text}<');},
*/