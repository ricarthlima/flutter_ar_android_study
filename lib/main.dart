import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar_android_study/domain/furniture_provider.dart';
import 'package:flutter_ar_android_study/ui/_core/theme.dart';
import 'package:flutter_ar_android_study/ui/home/splash_screen.dart';
import 'package:flutter_ar_android_study/ui/home/view/home_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Permite apenas retrato
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Carrega informações do móveis do servidor (sem baixar modelos)
  FurnitureProvider furnitureProvider = FurnitureProvider();
  await furnitureProvider.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => furnitureProvider),
        ChangeNotifierProvider(create: (_) => HomeViewModel())
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeApp.lightTheme,
    );
  }
}
