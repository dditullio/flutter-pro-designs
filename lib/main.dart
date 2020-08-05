import 'package:disenios/src/theme/theme.dart';
import 'package:flutter/material.dart';
// import 'package:disenios/src/labs/circular_progress_page.dart';
// import 'package:disenios/src/pages/graficas_circulares_page.dart';
// import 'package:disenios/src/retos/cuadrado_animado_page.dart';
// import 'package:disenios/src/pages/animaciones_page.dart';
// import 'package:disenios/src/pages/slideshow_page.dart';
// import 'package:disenios/src/pages/pinterest_page.dart';
// import 'package:disenios/src/pages/emergency_page.dart';
// import 'package:disenios/src/pages/sliver_list_page.dart';
import 'package:disenios/src/pages/launcher_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => new ThemeChanger(2), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diseños App',
      theme: currentTheme,
      home: LauncherPage(),
    );
  }
}
