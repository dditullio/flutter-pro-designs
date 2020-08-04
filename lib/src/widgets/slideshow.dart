import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Modelo para el Provider
class _SlideshowModel with ChangeNotifier {
  double _currentPage = 0;
  Color _colorPrimario = Colors.blue;
  Color _colorSecundario = Colors.grey;
  double _dotSize = 15;

  double get currentPage => this._currentPage;
  set currentPage(double page) {
    this._currentPage = page;
    notifyListeners();
  }

  get colorPrimario => this._colorPrimario;
  set colorPrimario(Color color) {
    this._colorPrimario = color;
  }

  get colorSecundario => this._colorSecundario;
  set colorSecundario(Color color) {
    this._colorSecundario = color;
  }

  get dotSize => this._dotSize;
  set dotSize(double size) {
    _dotSize = size;
  }
}

// import 'package:flutter_svg/flutter_svg.dart';

class Slideshow extends StatelessWidget {
  final List<Widget> slides;
  final bool puntosArriba;
  final Color colorPrimario;
  final Color colorSecundario;
  final double dotSize;

  const Slideshow(
      {@required this.slides,
      this.puntosArriba = false,
      this.colorPrimario = Colors.blue,
      this.colorSecundario = Colors.grey,
      this.dotSize = 15});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _SlideshowModel(),
      child: SafeArea(
        child: Center(
          child: Builder(
            builder: (context) {
              Provider.of<_SlideshowModel>(context, listen: false)
                  .colorPrimario = this.colorPrimario;
              Provider.of<_SlideshowModel>(context, listen: false)
                  .colorSecundario = this.colorSecundario;
              Provider.of<_SlideshowModel>(context, listen: false).dotSize =
                  this.dotSize;
              return _CrearEstructuraSlideshow(
                  puntosArriba: puntosArriba, slides: slides);
            },
          ),
        ),
      ),
    );
  }
}

class _CrearEstructuraSlideshow extends StatelessWidget {
  const _CrearEstructuraSlideshow({
    Key key,
    @required this.puntosArriba,
    @required this.slides,
  }) : super(key: key);

  final bool puntosArriba;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (puntosArriba) _Dots(this.slides.length),
        Expanded(child: _Slides(this.slides)),
        if (!puntosArriba) _Dots(this.slides.length),
      ],
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;

  const _Slides(this.slides);

  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageViewController = new PageController();

  @override
  void initState() {
    pageViewController.addListener(() {
      Provider.of<_SlideshowModel>(context, listen: false).currentPage =
          pageViewController.page;
    });
    super.initState();
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageViewController,
        children: widget.slides.map((slide) => _Slide(slide)).toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;

  const _Slide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(30),
        child: slide);
  }
}

class _Dots extends StatelessWidget {
  final int totalSlides;

  const _Dots(this.totalSlides);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(totalSlides, (index) => new _Dot(index))),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  const _Dot(this.index);

  @override
  Widget build(BuildContext context) {
    // final pageViewIndex = Provider.of<_SlideshowModel>(context).currentPage;
    final ssModel = Provider.of<_SlideshowModel>(context);
    final dotSize = ssModel.dotSize;

    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      curve: Curves.elasticOut,
      width:
          (ssModel.currentPage.round() == index) ? dotSize : (dotSize * 0.75),
      height:
          (ssModel.currentPage.round() == index) ? dotSize : (dotSize * 0.75),
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          // color: (pageViewIndex >= index - 0.5 && pageViewIndex <= index + 0.5)
          color: (ssModel.currentPage.round() == index)
              ? ssModel.colorPrimario
              : ssModel.colorSecundario,
          shape: BoxShape.circle),
    );
  }
}
