import 'package:sudan_horizon_scanner/imports.dart';

void main() {
  runApp(
      const SudanHorizonScannerApp()
  );
}

class SudanHorizonScannerApp extends StatelessWidget {
  const SudanHorizonScannerApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
        }),
        fontFamily: "Nunito",
        primaryColor: Colors.red,
        // ignore: deprecated_member_use
        accentColor: Colors.redAccent,
        primaryColorDark: const Color(0xff0029cb),
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) => SudanHorizonScanner(
        theme: theme,
      ),
    );
  }
}

class SudanHorizonScanner extends StatefulWidget {
  const SudanHorizonScanner({Key? key, required this.theme}) : super(key: key);

  final ThemeData theme;

  @override
  _SudanHorizonScannerState createState() => _SudanHorizonScannerState();
}

class _SudanHorizonScannerState extends State<SudanHorizonScanner> {
  /*Future getUserInfo() async {
    await getUser();
    setState(() {});
    print(uid);
  }*/

  @override
  void initState() {
    //getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sudan Horizon Scanner',
      theme: widget.theme,
      debugShowCheckedModeBanner: false,
      home: const InterventionsScreenWS(),
    );
  }
}