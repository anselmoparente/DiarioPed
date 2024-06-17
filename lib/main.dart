import 'package:diarioped/app/ui/pages/term_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:diarioped/app/data/models/meal_model.dart';
import 'package:diarioped/app/data/models/patient_model.dart';
import 'package:diarioped/app/data/services/auth_service.dart';
import 'package:diarioped/app/ui/pages/add_meal.dart';
import 'package:diarioped/app/ui/pages/details_meal.dart';
import 'package:diarioped/app/ui/pages/details_patient.dart';
import 'package:diarioped/app/ui/pages/home_page.dart';
import 'package:diarioped/app/ui/pages/introduction_page.dart';
import 'package:diarioped/app/ui/pages/link_page.dart';
import 'package:diarioped/app/ui/pages/login_page.dart';
import 'package:diarioped/app/ui/pages/access_page.dart';
import 'package:diarioped/app/ui/pages/patient_page.dart';
import 'package:diarioped/app/ui/pages/register_page.dart';
import 'package:diarioped/app/ui/pages/splash_page.dart';
import 'package:diarioped/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MainApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
      routes: [
        GoRoute(
          path: 'access',
          name: '/access',
          builder: (context, state) => const AccessPage(),
        ),
        GoRoute(
          path: 'add_meal',
          name: '/add_meal',
          builder: (context, state) => const AddMeal(),
        ),
        GoRoute(
          path: 'details',
          name: '/details',
          builder: (context, state) =>
              DetailsMeal(meal: state.extra as MealModel),
        ),
        GoRoute(
          path: 'details_patient',
          name: '/details_patient',
          builder: (context, state) =>
              DetailsPatient(patient: state.extra as PatientModel),
        ),
        GoRoute(
          path: 'home',
          name: '/home',
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: 'introduction',
          name: '/introduction',
          builder: (context, state) => const IntroductionPage(),
        ),
        GoRoute(
          path: 'link',
          name: '/link',
          builder: (context, state) => const LinkPage(),
        ),
        GoRoute(
          path: 'login',
          name: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: 'patient',
          name: '/patient',
          builder: (context, state) => const PatientPage(),
        ),
        GoRoute(
          path: 'register',
          name: '/register',
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: 'term',
          name: '/term',
          builder: (context, state) => const TermPage(),
        ),
      ],
    ),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const [Locale('pt', 'BR'), Locale('en'), Locale('es')],
        routerConfig: _router,
      ),
    );
  }
}
