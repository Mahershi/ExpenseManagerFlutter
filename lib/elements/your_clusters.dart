import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/cluster_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:expensemanager/repositories/cluster_repo.dart' as clusterRepo;
import 'package:flutter/material.dart';

class YourClusters extends StatefulWidget{
  String currentId;

  YourClusters({this.currentId});
  @override
  PageState createState() => PageState();
}

class PageState extends State<YourClusters>{
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius20
      ),
      actions: [
        OutlinedButton(
          onPressed: (){
            Navigator.of(context).pop(false);
          },
          style: OutlinedButton.styleFrom(
              primary: white,
              backgroundColor: red,
              elevation: 1
          ),
          child: Text(
            "Cancel",
            style: font.merge(
                TextStyle(
                    color: white,
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
            Navigator.of(context).pop(widget.currentId);
          },
          style: OutlinedButton.styleFrom(
              primary: white,
              backgroundColor: primaryColor,
              elevation: 1
          ),
          child: Text(
            "Save",
            style: font.merge(
                TextStyle(
                    color: white,
                    letterSpacing: 1.1,
                    fontSize: MediaQuery.of(context).size.width * 0.04
                )
            ),
          ),

        )
      ],
      title: Text(
        "Your Clusters",
        style: font.merge(
          TextStyle(

          )
        ),
      ),
      contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      titlePadding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
      actionsPadding: EdgeInsets.only(bottom: 10, right: 10),
      content: Container(
        // margin: EdgeInsets.symmetric(vertical: 30),
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height / 1.5,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: clusterRepo.clusters.length - 1,
          itemBuilder: (context, index){
            ClusterModel c = clusterRepo.clusters[index+1];
            return InkWell(
              onTap: (){
                widget.currentId = c.id;
                setState(() {

                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      c.name ?? "Unknown",
                      style: font.merge(
                        TextStyle(
                          color: widget.currentId == c.id ? primaryColor: black,
                          fontWeight: FontWeight.w600
                        )
                      ),
                    ),
                    Visibility(
                      visible: widget.currentId == c.id,
                      child: Icon(
                        Icons.done_rounded,
                        color: primaryColor,
                      ),
                    )
                  ],
                )
              ),
            );
          },
        ),
      ),
    );
  }
}