import 'package:disenios/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SliverListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _MainScroll(),
          Positioned(bottom: -10, right: 0, child: _NewListButton())
        ],
      ),
    );
  }
}

class _NewListButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appTheme = Provider.of<ThemeChanger>(context);

    return ButtonTheme(
      minWidth: size.width * 0.9,
      height: 100,
      child: RaisedButton(
        onPressed: () {},
        color: appTheme.darkTheme
            ? appTheme.currentTheme.buttonColor
            : Color(0xffED6762),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
        child: Text(
          'CREATE NEW LIST',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 3),
        ),
      ),
    );
  }
}

class _MainScroll extends StatelessWidget {
  final items = [
    _ListItem('Orange', Color(0xffF08F66)),
    _ListItem('Family', Color(0xffF2A38A)),
    _ListItem('Subscriptions', Color(0xffF7CDD5)),
    _ListItem('Books', Color(0xffFCEBAF)),
    _ListItem('Orange', Color(0xffF08F66)),
    _ListItem('Family', Color(0xffF2A38A)),
    _ListItem('Subscriptions', Color(0xffF7CDD5)),
    _ListItem('Books', Color(0xffFCEBAF)),
    _ListItem('Orange', Color(0xffF08F66)),
    _ListItem('Family', Color(0xffF2A38A)),
    _ListItem('Subscriptions', Color(0xffF7CDD5)),
    _ListItem('Books', Color(0xffFCEBAF)),
    _ListItem('Orange', Color(0xffF08F66)),
    _ListItem('Family', Color(0xffF2A38A)),
    _ListItem('Subscriptions', Color(0xffF7CDD5)),
    _ListItem('Books', Color(0xffFCEBAF)),
  ];

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);

    return CustomScrollView(
      slivers: <Widget>[
        // SliverAppBar(
        //   floating: true,
        //   elevation: 0,
        //   backgroundColor: Colors.red,
        //   title: Text('Hola Mundo'),
        // ),
        SliverPersistentHeader(
            floating: true,
            delegate: _SliverCustomHeaderDelegate(
                minheight: 170,
                maxheight: 200,
                child: Container(
                    alignment: Alignment.centerLeft,
                    color: appTheme.currentTheme.scaffoldBackgroundColor,
                    child: _Titulo()))),
        SliverList(
            delegate: SliverChildListDelegate([
          ...items,
          SizedBox(
            height: 110,
          )
        ]))
      ],
    );
  }
}

class _SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minheight;
  final double maxheight;
  final Widget child;

  _SliverCustomHeaderDelegate(
      {@required this.minheight,
      @required this.maxheight,
      @required this.child});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxheight;

  @override
  double get minExtent => minheight;

  @override
  bool shouldRebuild(_SliverCustomHeaderDelegate oldDelegate) {
    return maxheight != oldDelegate.maxheight ||
        minheight != oldDelegate.minheight ||
        child != oldDelegate.child;
  }
}

// class _ListaTareas extends StatelessWidget {
//   final items = [
//     _ListItem('Orange', Color(0xffF08F66)),
//     _ListItem('Family', Color(0xffF2A38A)),
//     _ListItem('Subscriptions', Color(0xffF7CDD5)),
//     _ListItem('Books', Color(0xffFCEBAF)),
//     _ListItem('Orange', Color(0xffF08F66)),
//     _ListItem('Family', Color(0xffF2A38A)),
//     _ListItem('Subscriptions', Color(0xffF7CDD5)),
//     _ListItem('Books', Color(0xffFCEBAF)),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         physics: BouncingScrollPhysics(),
//         itemCount: items.length,
//         itemBuilder: (BuildContext context, int index) => items[index]);
//   }
// }

class _Titulo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);
    return Column(
      children: <Widget>[
        SizedBox(height: 30),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            'New',
            style: TextStyle(
                color: appTheme.darkTheme
                    ? appTheme.currentTheme.textTheme.bodyText2.color
                    : Color(0xff532128),
                fontSize: 50),
          ),
        ),
        Stack(
          children: <Widget>[
            Positioned(
              bottom: 8,
              child: Container(
                width: 150,
                height: 8,
                decoration: BoxDecoration(
                    color: appTheme.darkTheme
                        ? appTheme.currentTheme.dividerColor
                        : Color(0xffF7CDD5)),
              ),
            ),
            Container(
                width: 140,
                child: Text('List',
                    style: TextStyle(
                        color: appTheme.darkTheme
                            ? appTheme.currentTheme.textTheme.bodyText2.color
                            : Color(0xffD93A30),
                        fontSize: 50,
                        fontWeight: FontWeight.bold))),
          ],
        )
      ],
    );
  }
}

class _ListItem extends StatelessWidget {
  final String titulo;
  final Color color;

  const _ListItem(this.titulo, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        titulo,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(10),
      height: 130,
      margin: EdgeInsets.all(10),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(30)),
    );
  }
}
