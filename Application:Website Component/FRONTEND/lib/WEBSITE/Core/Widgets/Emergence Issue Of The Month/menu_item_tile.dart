import 'package:sudan_horizon_scanner/imports.dart';

class MenuItemTile extends StatefulWidget
{
  final String title;
  final IconData icon;
  final AnimationController? animationController;
  final bool isSelected;
  final Function()? onTap;

  const MenuItemTile(
  {
    Key? key,
    required this.title,
    required this.icon,
    this.animationController,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  @override
  _MenuItemTileState createState() => _MenuItemTileState();
}

class _MenuItemTileState extends State<MenuItemTile>
{
  late Animation<double> _animation, _sizedBoxAnimation;

  @override
  void initState()
  {
    super.initState();
    _animation = Tween<double>(begin: 250, end: 70).animate(widget.animationController!);
    _sizedBoxAnimation = Tween<double>(begin: 10, end: 0).animate(widget.animationController!);
  }

  @override
  Widget build(BuildContext context)
  {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.isSelected
              ? Colors.transparent.withOpacity(0.3)
              : Colors.transparent,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        width: _animation.value,
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              widget.icon,
              color: widget.isSelected ? emergenceIssueOfTheMonthSelectedColor : Colors.white30,
              size: 38,
            ),
            SizedBox(
              width: _sizedBoxAnimation.value,
            ),
            if (_animation.value >= 200)
              Text(widget.title,
                  style: widget.isSelected
                      ? menuListTileSelectedText
                      : menuListTileDefaultText),
          ],
        ),
      ),
    );
  }
}
