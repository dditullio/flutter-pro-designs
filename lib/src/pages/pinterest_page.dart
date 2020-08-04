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
    final widthPantalla = MediaQuery.of(context).size.width;
    final mostrar = Provider.of<_MenuModel>(context).mostrar;
    return Positioned(
        bottom: 30,
        child: Container(
          width: widthPantalla,
          child: Align(
            child: PinterestMenu(
              backgroundColor: Colors.yellowAccent,
              activeColor: Colors.red,
              inactiveColor: Colors.green,
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
    return new StaggeredGridView.countBuilder(
      controller: controller,
      crossAxisCount: 4,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) => _PinterestItem(index),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 2 : 3),
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
