import 'package:flutter/material.dart';
import '../app_data.dart';
import '../widgets/main_drawer.dart';
import 'terms_of_use_screen.dart';

class AboutScreen extends StatelessWidget {
  static const String pageName = '/about-screen';
  static const String _aboutContent = """
הוא כלי פיננסי לחישוב צבירת
כסף בקופת גמל להשקעה

המחשבון מחשב
את הסכום שייצבר בקופה לאחר
מספר שנים, ויציג את הסכום הנקי
לאחר דמי ניהול ומסים

מחשבון גמל יוסד ופותח
על ידי דוד
שהוא גם אדם נפלא בנשמתו,
אוהב אדם ונוח לבריות
"""; // DO NOT CHANGE THE TEXT'S SPACES / WHITE SPACE !!

  String _backgroundImageName;

  /// Picks the right background based on device's screen ratio
  _setBackgroundImageName(BuildContext context) {
    final double aspectRatio = MediaQuery.of(context).size.aspectRatio;
    print(aspectRatio);
    if (aspectRatio > 0.5)
      _backgroundImageName = "images/wide-background.png";
    else
      _backgroundImageName = "images/background.png";
  }

  void _showTermsOfService(BuildContext context) {
    Navigator.of(context).pushNamed(TermsOfUseScreen.pageName);
  }

  @override
  Widget build(BuildContext context) {
    _setBackgroundImageName(context);
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom - APP_DATA.APPBAR_HEIGHT ;
    final double buttonWidth = width / (360 / 162);
    final double buttonHeight = height / (570 / 51);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(APP_DATA.APPBAR_HEIGHT),
        child: AppBar(
          title: const Text('אודות'),
        ),
      ),
      drawer: MainDrawer(),
      body: Container(
        // width and height is set as minimum, for very long screens
        width: double.infinity,
        height: MediaQuery.of(context).size.height - APP_DATA.APPBAR_HEIGHT,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_backgroundImageName),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Theme.of(context).accentColor.withOpacity(0.7),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(width: double.infinity,),
                SizedBox(height: height / (570 / 44),),
                Text(
                  'מחשבון גמל',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    color: Colors.white,
                    fontSize: width / (360 / 28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: height / (570 / 30),
                ),
                Text(
                  _aboutContent,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    color: Colors.white,
                    fontSize: width / (360 / 24),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: height / (570 / 30),
                ),
                FlatButton(
                  onPressed: () => _showTermsOfService(context),
                  minWidth: buttonWidth,
                  height: buttonHeight,
                  child: Text(
                    'תנאי שימוש',
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold,
                      fontSize: width / (360 / 24),
                      letterSpacing: 0.5,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Theme.of(context).accentColor,
                ),
                SizedBox(
                  height: height / (570 / 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
