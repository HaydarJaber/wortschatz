import 'package:flutter/material.dart';


class MenuButton extends StatelessWidget {
  final String label, route;
  final int iconCodePoint;
  final Color color;

  const MenuButton({Key? key,
    required this.label,
    required this.route,
    required this.iconCodePoint,
    this.color = Colors.transparent})
      : super(key: key);

//  final String buttonName, heroTag;
  // final int iconCodePoint;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(3.0),
        child: ElevatedButton.icon(
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(200, 45)),
              backgroundColor: MaterialStateProperty.resolveWith((state) {
                if (state.contains(MaterialState.pressed)) return Colors.grey;
                return color;
              }),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              side: MaterialStateProperty.all(const BorderSide(width: 2))),
          onPressed: () =>
              Navigator.pushNamed(context, route, arguments: label),
          icon: Icon(
              shadows: const <Shadow>[
                Shadow(
                  offset: Offset(0.0, 0.0),
                  blurRadius: 5.0,
                  color: Colors.black,
                ),
              ],
              size: MediaQuery
                  .of(context)
                  .size
                  .height * 0.10,
              color: Colors.white,
              IconData(iconCodePoint, fontFamily: 'MaterialIcons')),
          label: Text(label,
            style: TextStyle(
              shadows: const <Shadow>[
                Shadow(
                  offset: Offset(0.0, 0.0),
                  blurRadius: 5.0,
                  color: Colors.black,
                ),
              ],
              color: Colors.white,
              fontSize: MediaQuery
                  .of(context)
                  .size
                  .height * 0.04,
              fontFamily: "Modak",
            ),
          ),
        ));
  }
}










