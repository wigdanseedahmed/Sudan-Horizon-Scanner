import 'package:sudan_horizon_scanner/imports.dart';

class ConflictPrediction extends StatefulWidget {
  const ConflictPrediction({Key? key}) : super(key: key);

  @override
  _ConflictPredictionState createState() => _ConflictPredictionState();
}

class _ConflictPredictionState extends State<ConflictPrediction> {
  // late ScrollController _scrollController;
  // double _scrollPosition = 0;

  /*_scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }*/

  @override
  void initState() {
    // _scrollController = ScrollController();
    // _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var screenSize = MediaQuery.of(context).size;
    /*_opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;*/

    return Portal(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Example'),
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: const ContextualMenuExample(),
          ),
        ),
      ),
    );
  }
}

class ContextualMenuExample extends StatefulWidget {
  const ContextualMenuExample({Key? key}) : super(key: key);

  @override
  _ContextualMenuExampleState createState() => _ContextualMenuExampleState();
}

class _ContextualMenuExampleState extends State<ContextualMenuExample> {
  bool _showMenu = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ModalEntry(
        visible: _showMenu,
        onClose: () => setState(() => _showMenu = false),
        childAnchor: Alignment.bottomCenter,
        menuAnchor: Alignment.topCenter,
        menu: const AreaOfInterventionMenu(
          children: [
            PopupMenuItem(
              child: Text("Rules of Law and Constitutional Building"),
            ),
            PopupMenuItem(
              child: Text("Democratic Transition and Economic Recovery"),
            ),
            PopupMenuItem(
              child: Text("Energy and Environment"),
            ),
            PopupMenuItem(
              child: Text("Health and Development"),
            ),
            PopupMenuItem(
              child: Text("Peace and Stabilization"),
            ),
            PopupMenuItem(
              child: Text("Innovation and Digitization"),
            ),
          ]
        ),
        child: ElevatedButton(
          onPressed: () => setState(() => _showMenu = true),
          child: const Text('show menu'),
        ),
      ),
    );
  }
}

class AreaOfInterventionMenu extends StatelessWidget {
  const AreaOfInterventionMenu({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Card(
        elevation: 8,
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        ),
      ),
    );
  }
}

class ModalEntry extends StatelessWidget {
  const ModalEntry({
    Key? key,
    required this.onClose,
    required this.menu,
    required this.visible,
    required this.menuAnchor,
    required this.childAnchor,
    required this.child,
  }) : super(key: key);

  final VoidCallback onClose;
  final Widget menu;
  final bool visible;
  final Widget child;
  final Alignment menuAnchor;
  final Alignment childAnchor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: visible ? onClose : null,
      child: PortalEntry(
        visible: visible,
        portal: menu,
        portalAnchor: menuAnchor,
        childAnchor: childAnchor,
        child: IgnorePointer(
          ignoring: visible,
          child: child,
        ),
      ),
    );
  }
}