import 'package:flutter/material.dart';
import '../app_data.dart';
import '../screens/about_screen.dart';
import '../models/icons.dart';

class MainDrawer extends StatelessWidget {

    /// The index of which screen is selected
   static int _selectedIndex = 0;

  Widget buildListTile(BuildContext context, int index, String title, IconData icon, Function givenOnTap,){
    final double width = MediaQuery.of(context).size.width;
    final currentColor = index == _selectedIndex ? Theme.of(context).primaryColor : Colors.white;
    // color can be green or white depends on if its selected or not
    return ListTile(
      leading: Icon(
        icon,
        size: width / (360 / 22),
        color: currentColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: width / (360 / 24),
          fontWeight: FontWeight.bold,
          color: currentColor,
        ),
      ),
      onTap: () {
        _selectedIndex = index; // sets the selected option index
        givenOnTap();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height - APP_DATA.APPBAR_HEIGHT;
    return Drawer(
      child: Container(
        color: Theme.of(context).accentColor,
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Text(
                  'מחשבון גמל',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width / (360 / 30),
                    fontFamily: "SecularOne",
                  ),
                ),
              ),
            ),
            SizedBox(height: height / (570 / 10),),
            buildListTile(context, 0, 'מחשבון', MyFlutterApp.calculator, () {
              Navigator.pushReplacementNamed(context, '/');
            }),
            SizedBox(height: height / (570 / 5),),
            buildListTile(context, 1, 'אודות', MyFlutterApp.info_circled, () {
              Navigator.pushReplacementNamed(context, AboutScreen.pageName);
            })
          ],
        ),
      ),
    );
  }
}
