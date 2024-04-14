import 'package:flutter/material.dart';

// import 'bottomBarIcon.dart';

class CustomBottomBar extends StatelessWidget {
  final Color color;
  const CustomBottomBar({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 5,
      notchMargin: 8,
      color: Colors.black,
      shape: const AutomaticNotchedShape(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 20, 18),
              child: Text(
                'Search For location',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18, color: color),
              ),
            ),
            SizedBox(width: 80)
          ],
        ),
      ),
    );
  }
}
