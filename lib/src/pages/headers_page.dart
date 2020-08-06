import 'package:disenios/src/theme/theme.dart';
import 'package:disenios/src/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeadersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;
    return Scaffold(
      body: HeaderWaves(
        color: appTheme.accentColor, // Color(0xff615AAB),
      ),
    );
  }
}
