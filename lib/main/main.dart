import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// import '../utils/i18n/i18n.dart';

import '../ui/components/components.dart';

import './factories/factories.dart';

void main() {
  // R.load(Locale('en', 'US'));

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return GetMaterialApp(
      title: '4Dev',
      debugShowCheckedModeBanner: false,
      theme: makeAppTheme(),
      initialRoute: '/survey_result/3',
      getPages: [
        GetPage(name: '/', page: makeSplashPage, transition: Transition.fade),
        GetPage(name: '/login', page: makeLoginPage, transition: Transition.fadeIn),
        GetPage(name: '/signup', page: makeSignUpPage),
        GetPage(name: '/surveys', page: makeSurveysPage, transition: Transition.fadeIn),
        GetPage(name: '/survey_result/:survey_id', page: makeSurveyResultPage),
      ],
    );
  }
}
