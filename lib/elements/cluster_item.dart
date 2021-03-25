import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/cluster_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ClusterItem extends StatefulWidget{
  ClusterModel cluster;

  ClusterItem({this.cluster});
  @override
  PageState createState() => PageState();
}

class PageState extends State<ClusterItem>{
  @override
  Widget build(BuildContext context) {
    return Slidable(
      secondaryActions: [
        Container(
            margin: EdgeInsets.symmetric(vertical: 10,),
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.only(topRight: radius20, bottomRight: radius20),
                borderRadius: borderRadius20,
                color: white
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.edit,
                  color: black,
                  size: MediaQuery.of(context).size.width * 0.08,
                ),
              ],
            )

        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10,),
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.only(topRight: radius20, bottomRight: radius20),
            borderRadius: borderRadius20,
            color: white
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.delete,
                color: black,
                size: MediaQuery.of(context).size.width * 0.08,
              ),
            ],
          )
        ),
      ],
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10,),
        decoration: BoxDecoration(
          color: secondColor.withOpacity(0.8),
          borderRadius: borderRadius20
          // borderRadius: BorderRadius.only(topLeft: radius20, bottomLeft: radius20)
        ),
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    width: 3,
                    decoration: BoxDecoration(
                      borderRadius: borderRadius12,
                      color: white,

                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cluster.name ?? "Unknown",
                        style: font.merge(
                          TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: white,
                            letterSpacing: 1.1
                          )
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          child: Text(
                            widget.cluster.expenses + " expenses",
                            style: font.merge(
                                TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.03,
                                  color: white.withOpacity(0.7),
                                  letterSpacing: 1.2
                                )
                            ),
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
                child: Text(
                  "₹ 5600",
                  style: font.merge(
                      TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: white
                      )
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}