import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Clases auxiliares
class PinterestMenuButton {
  final Function onPressed;
  final IconData icon;

  PinterestMenuButton({@required this.onPressed, @required this.icon});
}

class _MenuModel with ChangeNotifier {
  int _selectedIndex = 0;
  Color backgroundColor = Colors.white;
  Color activeColor = Colors.black;
  Color inactiveColor = Colors.blueGrey;

  get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
// Fin clases auxiliares

class PinterestMenu extends StatelessWidget {
  final bool mostrar;
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final List<PinterestMenuButton> items;

  PinterestMenu(
      {this.mostrar = true,
      this.activeColor = Colors.black,
      this.inactiveColor = Colors.blueGrey,
      this.backgroundColor = Colors.white,
      @required this.items});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _MenuModel(),
      child: Builder(
        builder: (context) {
          Provider.of<_MenuModel>(context, listen: false).backgroundColor =
              this.backgroundColor;
          Provider.of<_MenuModel>(context, listen: false).activeColor =
              this.activeColor;
          Provider.of<_MenuModel>(context, listen: false).inactiveColor =
              this.inactiveColor;
          return AnimatedOpacity(
              opacity: mostrar ? 1 : 0,
              duration: Duration(milliseconds: 250),
              child: _PinterestMenuBackground(itemSet: _MenuItems(items)));
        },
      ),
    );
  }
}

class _PinterestMenuBackground extends StatelessWidget {
  final Widget itemSet;
  const _PinterestMenuBackground({@required this.itemSet});

  @override
  Widget build(BuildContext context) {
    final colorFondo = Provider.of<_MenuModel>(context).backgroundColor;

    return Container(
      child: itemSet,
      width: 250,
      height: 60,
      decoration: BoxDecoration(
          color: colorFondo,
          borderRadius: BorderRadius.circular(100),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black38,
                // offset: Offset(10, 10),
                blurRadius: 10,
                spreadRadius: -5)
          ]),
    );
  }
}

class _MenuItems extends StatelessWidget {
  final List<PinterestMenuButton> menuItems;

  const _MenuItems(this.menuItems);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
          menuItems.length, (index) => _MenuButton(index, menuItems[index])),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final int index;
  final PinterestMenuButton item;

  const _MenuButton(this.index, this.item);

  @override
  Widget build(BuildContext context) {
    final itemSeleccionado = Provider.of<_MenuModel>(context).selectedIndex;
    final colorActivo = Provider.of<_MenuModel>(context).activeColor;
    final colorInactivo = Provider.of<_MenuModel>(context).inactiveColor;

    return GestureDetector(
      onTap: () {
        Provider.of<_MenuModel>(context, listen: false).selectedIndex = index;
        item.onPressed();
      },
      behavior: HitTestBehavior.translucent,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
        child: Icon(item.icon,
            size: itemSeleccionado == index ? 35 : 25,
            color: itemSeleccionado == index ? colorActivo : colorInactivo),
      ),
    );
  }
}
