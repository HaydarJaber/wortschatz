import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class CategoryButton extends StatelessWidget {
  final String label, route;
  final int iconCodePoint;
  final Color color;

  const CategoryButton({Key? key,
    required this.label,
    required this.route,
    required this.iconCodePoint,
    this.color = Colors.transparent})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: ElevatedButton.icon(
          style: ButtonStyle(
              alignment: Alignment.centerLeft,
              backgroundColor: MaterialStateProperty.resolveWith((state) {
                if (state.contains(MaterialState.pressed)) return Colors.grey;
                return color;
              }),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              side: MaterialStateProperty.all(const BorderSide(width: 2))),
          onPressed: () =>
              Navigator.pushNamed(context, route, arguments: label ),
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
                  .height * 0.03,
              color: Colors.white,
              IconData(iconCodePoint, fontFamily: 'FontAwesomeSolid', fontPackage: 'font_awesome_flutter')
          ),
          label: Text(label,
            textAlign: TextAlign.right,
            style: TextStyle(
              shadows: const <Shadow>[
                Shadow(
                  offset: Offset(0.0, 0.0),
                  blurRadius: 2.0,
                  color: Colors.black,
                ),
              ],
              color: Colors.black,
              fontSize: MediaQuery
                  .of(context)
                  .size
                  .height * 0.03,
              fontFamily: "Qaz",
            ),
          ),
        ));
  }
}










