import 'package:flutter/material.dart';
import '../app_data.dart';

class ResultsRect extends StatelessWidget {

  final String totalBeforeTaxes;
  final String totalAfterTaxes;

  ResultsRect(
      {@required this.totalAfterTaxes, @required this.totalBeforeTaxes});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        APP_DATA.APPBAR_HEIGHT;
    return Container(
      width: width / (360 / 277),
      height: (width / (360 / 277) * 0.8 + height / (570 / 186) * 1.4) / 2 ,
      color: Theme.of(context).accentColor.withOpacity(0.8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // item 1
          Column(
            children: [
              SizedBox(width: double.infinity), // here to center just in case
              Text(
                'לפני מס',
                style: Theme.of(context).primaryTextTheme.subtitle2.copyWith(
                  fontSize: width /
                      (360 /
                          Theme.of(context)
                              .primaryTextTheme
                              .subtitle2
                              .fontSize),
                  color: Colors.white,
                ),
              ),
              SizedBox(height: height / (570 / 4)),
              Text(
                totalBeforeTaxes,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  color: Colors.red,
                  fontSize: width / (360 / 30),
                ),
              ),
            ],
          ),
          //item2
          Column(
            children: [
              Text(
                'אחרי מס',
                style: Theme.of(context).primaryTextTheme.subtitle2.copyWith(
                  fontSize: width /
                      (360 /
                          Theme.of(context)
                              .primaryTextTheme
                              .subtitle2
                              .fontSize),
                  color: Colors.white,
                ),
              ),
              SizedBox(height: height / (570 / 4)),
              Text(
                totalAfterTaxes,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  color: Theme.of(context).primaryColor,
                  fontSize: width / (360 / 30),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
