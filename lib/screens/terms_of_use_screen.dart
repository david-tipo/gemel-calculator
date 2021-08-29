import 'package:flutter/material.dart';
import '../app_data.dart';
import '../app_code/gemel_math.dart';

class TermsOfUseScreen extends StatelessWidget {

  static const String pageName = '/terms-of-use-screen';
  static const String _termsOfUseText = """
מחשבון גמל
הוא כלי לחישוב צבירה בקופת הגמל להשקעה
מחשבון גמל מציג את הסכום הנקי לאחר
חישוב תשואה, דמי ניהול ומס

מחשבון גמל מחשב על פי נתונים בלתי משתנים
כגון תשואה דמי ניהול מחיר מדד לצרכן ועוד.
במציאות כל אחד מהנתונים הללו עשוי ואף צפוי להשתנות.
שימוש במידע מחשבון גמל באחריות המשתמש
ובאחריותו בלבד
אין לראות במחשבון גמל המלצה או קביעה
בכל הקשור לקופות גמל
מחשבון גמל אינו אחראי לשום הפסד/נזק
הנגרם כתוצאה משימוש במידע
ייתכן כי קיימות טעויות בחישובים 

 מחשבון גמל מסתמך על חוק המיסוי על קופות הגמל להשקעה נכון ליוני 2021
ייתכן כי קיימות טעויות בחישובים 

חישוב מהיר מחשב עם תשואה שנתית של ${GemelMath.defaultYield * 100}%
ודמי ניהול על סך ${(GemelMath.defaultMgmtFee * 100)}%
ככלל מחשבון גמל מחשב עם מדד מחיר לצרכן ${GemelMath.inflation * 100}% 

כל הזכויות שמורות למחשבון גמל
אין לשכפל, להעתיק, לצלם,  להקליט, לתרגם, לשדר
או לקלוט בכל דרך או אמצעי אלקטרוני, אופטי או מכני. 
שימוש מסחרי מכל סוג הכלול ביישומון זה אסור בהחלט 
אלא ברשות מפורשת מיוצר היישומון
.
יוצר היישומון: דוד טיפוגרף""";

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height - APP_DATA.APPBAR_HEIGHT;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(APP_DATA.APPBAR_HEIGHT),
        child: AppBar(
          title: Text('תנאי שימוש'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: height / (570 / 30)),
          child: Text(
            _termsOfUseText,
            textAlign: TextAlign.center,
            style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(
              fontSize: MediaQuery.of(context).size.width / (360 / Theme.of(context).primaryTextTheme.bodyText1.fontSize),
            ),
          ),
        ),
      ),
    );
  }
}
