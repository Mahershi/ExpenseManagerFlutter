import 'package:expensemanager/controllers/clustercontroller.dart';
import 'package:expensemanager/elements/back_button_app_bar.dart';
import 'package:expensemanager/elements/cluster_item.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expensemanager/repositories/cluster_repo.dart' as clusterRepo;
import 'package:mvc_pattern/mvc_pattern.dart';

class ClusterPage extends StatefulWidget{
  @override
  PageState createState() => PageState();
}

class PageState extends StateMVC{
  ClusterController _con;
  String heading = "Clusters";

  PageState() : super(ClusterController()){
    _con = controller;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        color: white,
        child: Stack(
          children: [
            Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.1 + 20,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: BackbuttonAppBar(
                  heading: heading,
                  tag: "Group expenses by convenience",
                  action: _con.addNewCluster,
                )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: radius20, topLeft: radius20),
                    color: primaryColor
                ),
                height: MediaQuery.of(context).size.height * 0.9 - 40,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: clusterRepo.clusters.length - 1,
                  itemBuilder: (context, index){
                    return ClusterItem(cluster: clusterRepo.clusters[index + 1],);
                  },
                )
              ),
            ),
          ],
        )
      )
    );
  }
}