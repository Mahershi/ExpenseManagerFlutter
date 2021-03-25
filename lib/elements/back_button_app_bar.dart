import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackbuttonAppBar extends StatelessWidget{
  String heading;
  String tag;
  Color color;
  Function action;

  BackbuttonAppBar({this.heading = '', this.color=primaryColor ,this.tag = null, this.action = null});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: color),
                    borderRadius: borderRadius12
                ),
                child: Icon(
                  Icons.chevron_left,
                  color: color,
                )
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  heading,
                  style: font.merge(
                    TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      color: color
                    )
                  ),
                )
              ),
              Visibility(
                visible:  tag!=null,
                child: SizedBox(
                  height: 2,
                )
              ),
              Visibility(
                visible:  tag!=null,
                child: Container(
                    child: Text(
                      tag ?? "",
                      style: font.merge(
                          TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.03,
                              color: color
                          )
                      ),
                    )
                ),
              ),
            ],
          ),
          Opacity(
            opacity: action == null ? 0 : 1,
            child: InkWell(
              onTap: action,
              child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: color),
                      borderRadius: borderRadius12
                  ),
                  child: Icon(
                    Icons.add,
                    color: color,
                  )
              ),
            ),
          )
        ],
      )
    );
  }
}