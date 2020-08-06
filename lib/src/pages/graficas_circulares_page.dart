import 'package:disenios/src/theme/theme.dart';
import 'package:disenios/src/widgets/radial_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GraficasCircularesPage extends StatefulWidget {
  @override
  _GraficasCircularesPageState createState() => _GraficasCircularesPageState();
}

class _GraficasCircularesPageState extends State<GraficasCircularesPage> {
  double porcentaje = 0.0;

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.refresh,
          ),
          backgroundColor: appTheme.accentColor,
          onPressed: () {
            setState(() {
              porcentaje += 10;
              if (porcentaje > 100) {
                porcentaje = 0;
              }
            });
          }),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomRadialProgress(porcentaje: porcentaje, color: Colors.blue),
              CustomRadialProgress(
                  porcentaje: porcentaje * 1.2, color: Colors.yellow)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomRadialProgress(
                  porcentaje: porcentaje * 3, color: Colors.pink),
              CustomRadialProgress(
                  porcentaje: porcentaje * 0.7, color: Colors.purple)
            ],
          ),
        ],
      ),
    );
  }
}

class CustomRadialProgress extends StatelessWidget {
  const CustomRadialProgress({
    @required this.porcentaje,
    @required this.color,
  });

  final double porcentaje;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);
    final secColor = appTheme.currentTheme.textTheme.bodyText2.color;
    return Container(
      width: 300,
      height: 300,
      // color: Colors.red,
      child: RadialProgress(
        porcentaje: porcentaje,
        colorPrimario: this.color,
        colorSecundario: secColor,
        grosorPrimario: 20,
        grosorSecundario: 2,
      ),
      // child: Text(
      //   '$porcentaje %',
      //   style: TextStyle(fontSize: 50.0),
      // ),
    );
  }
}
