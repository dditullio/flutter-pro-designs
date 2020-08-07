import 'package:disenios/src/theme/theme.dart';
import 'package:disenios/src/widgets/pinterest_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

// Clases auxiliares
class _MenuModel with ChangeNotifier {
  bool _mostrar = true;

  get mostrar => _mostrar;
  set mostrar(bool visible) {
    _mostrar = visible;
    notifyListeners();
  }
}
// Fin clases auxiliares

class PinterestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _MenuModel(),
      child: Scaffold(
          // body: PinterestMenu(),
          // body: PinterestGrid(),
          body: Stack(
        children: <Widget>[
          PinterestGrid(),
          _PinterestMenuPositioner(),
        ],
      )),
    );
  }
}

class _PinterestMenuPositioner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final widthPantalla = MediaQuery.of(context).size.width - 300;
    final mostrar = Provider.of<_MenuModel>(context).mostrar;
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;
    return Positioned(
        bottom: 30,
        child: Container(
          width: widthPantalla,
          child: Row(
            children: <Widget>[
              Spacer(),
              PinterestMenu(
                backgroundColor: appTheme.scaffoldBackgroundColor,
                activeColor: appTheme.accentColor,
                inactiveColor: appTheme.unselectedWidgetColor,
                mostrar: mostrar,
                items: [
                  PinterestMenuButton(
                      icon: Icons.pie_chart,
                      onPressed: () {
                        print('Icon Pie Chart');
                      }),
                  PinterestMenuButton(
                      icon: Icons.search,
                      onPressed: () {
                        print('Icon Search');
                      }),
                  PinterestMenuButton(
                      icon: Icons.notifications,
                      onPressed: () {
                        print('Icon Notification');
                      }),
                  PinterestMenuButton(
                      icon: Icons.supervised_user_circle,
                      onPressed: () {
                        print('Icon Supervised User Circle');
                      }),
                ],
              ),
              Spacer(),
            ],
          ),
        ));
  }
}

class PinterestGrid extends StatefulWidget {
  @override
  _PinterestGridState createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  final List<int> items = List.generate(200, (index) => index);

  ScrollController controller = new ScrollController();

  @override
  void initState() {
    double scrollAnterior = 0;
    controller.addListener(() {
      // print('Scroll Listener ${controller.offset}');
      // if (controller.offset > scrollAnterior) {
      if ((controller.offset - scrollAnterior) > 1) {
        Provider.of<_MenuModel>(context, listen: false).mostrar = false;
      } else {
        Provider.of<_MenuModel>(context, listen: false).mostrar = true;
      }
      scrollAnterior = controller.offset;
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int count;
    if (MediaQuery.of(context).size.width > 1000) {
      count = 4;
    } else if (MediaQuery.of(context).size.width > 500) {
      count = 3;
    } else {
      count = 2;
    }

    return new StaggeredGridView.countBuilder(
      controller: controller,
      crossAxisCount: count,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) => _PinterestItem(index),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(1, index.isEven ? 1 : 2),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}

class _PinterestItem extends StatelessWidget {
  final int index;

  const _PinterestItem(this.index);

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(30)),
        child: new Center(
          child: new CircleAvatar(
            backgroundColor: Colors.white,
            child: new Text('$index'),
          ),
        ));
  }
}
