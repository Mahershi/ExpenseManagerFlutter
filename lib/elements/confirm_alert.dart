import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmAlert extends StatefulWidget{
  String title;
  String tag;
  Color color;

  ConfirmAlert({this.title, this.tag, this.color});

  @override
  PageState createState() => PageState();
}

class PageState extends State<ConfirmAlert>{
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: borderRadius20
      ),
      actionsPadding: EdgeInsets.only(bottom: 10, right: 10),
      actions: [
        OutlinedButton(
          onPressed: (){
            Navigator.of(context).pop(false);
          },
          style: OutlinedButton.styleFrom(
              primary: accentColor,
              backgroundColor: red,
              elevation: 1
          ),
          child: Text(
            "Cancel",
            style: font.merge(
                TextStyle(
                    color: accentColor,
                    letterSpacing: 1.1,
                    fontSize: MediaQuery.of(context).size.width * 0.04
                )
            ),
          ),

        ),
        SizedBox(
          width: 5,
        ),
        OutlinedButton(
          onPressed: () async{
            Navigator.of(context).pop(true);
          },
          style: OutlinedButton.styleFrom(
              primary: accentColor,
              backgroundColor: primaryColor,
              elevation: 1
          ),
          child: Text(
            "Yes",
            style: font.merge(
                TextStyle(
                    color: accentColor,
                    letterSpacing: 1.1,
                    fontSize: MediaQuery.of(context).size.width * 0.04
                )
            ),
          ),

        )
      ],
      title: Text(
        widget.title,
        style: font.merge(
          TextStyle(
            color: widget.color,
            fontSize: MediaQuery.of(context).size.width * 0.04,
            letterSpacing: 1.2
          )
        ),
      ),
      content: Container(
        child: Text(
          widget.tag,
          style: font.merge(
              TextStyle(
                  color: grey,
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  letterSpacing: 1.2
              )
          ),
        ),
      ),
    );
  }
}