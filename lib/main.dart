import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:machine_test_techware/Data/Repositories/auth_repository.dart';
import 'package:machine_test_techware/Data/Repositories/product_repository.dart';
import 'package:machine_test_techware/Presentation/Utils/route_manager.dart';
import 'package:machine_test_techware/Presentation/Utils/shared_preferences.dart';
import 'package:machine_test_techware/Presentation/View/Product/add_product_screen.dart';
import 'package:machine_test_techware/Presentation/View/Product/product_list_screen.dart';
import 'package:machine_test_techware/Presentation/View/registeration_screen.dart';
import 'package:machine_test_techware/Presentation/View/sign_in_screen.dart';
import 'package:machine_test_techware/Presentation/View/splash_screen.dart';
import 'package:machine_test_techware/bloc/authentication_bloc.dart';
import 'package:machine_test_techware/bloc/product_bloc.dart';
import 'package:machine_test_techware/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await UserPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => ProductRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
          BlocProvider<QRGeneratorBloc>(
            create: (context) => QRGeneratorBloc(
                RepositoryProvider.of<ProductRepository>(
                    context)), // Provide an instance of YourSecondBloc
          ),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          routes: RouteManager.routes,
          home: SplashScreen(),
        ),
      ),
    );
  }
}
