import 'package:sudan_horizon_scanner/imports.dart';

class SmallScreenAppBar extends StatelessWidget {
  const SmallScreenAppBar({
    Key? key,
    required double opacity,
  })  : _opacity = opacity,
        super(key: key);

  final double _opacity;

  @override
  Widget build(BuildContext context) {
    void changeBrightness() {
      DynamicTheme.of(context)!.setBrightness(
          Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark);
    }

    return AppBar(
      backgroundColor: DynamicTheme.of(context)?.brightness == Brightness.light
          ? Colors.white
          : const Color(0xFF323232),
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.menu_sharp,
          color: DynamicTheme.of(context)?.brightness == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.brightness_6,
            color: primaryColour,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: changeBrightness,
        ),
      ],
      title: Text(
        'Sudan Horizon Scanner',
        style: TextStyle(
          color: DynamicTheme.of(context)?.brightness == Brightness.light
              ? Colors.black
              : Colors.white,
          fontSize: 15,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          letterSpacing: 3,
        ),
      ),
    );
  }
}
