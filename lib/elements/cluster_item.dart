import 'package:expensemanager/blocs/expense_detail_bloc.dart';
import 'package:expensemanager/elements/SlidableIconButton.dart';
import 'package:expensemanager/elements/cluster_edit.dart';
import 'package:expensemanager/elements/confirm_alert.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/cluster_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:expensemanager/repositories/cluster_repo.dart' as clusterRepo;

class ClusterItem extends StatefulWidget{
  ClusterModel cluster;

  ClusterItem({this.cluster});
  @override
  PageState createState() => PageState();
}

class PageState extends State<ClusterItem>{
  SlidableController slidableController = SlidableController();
  @override
  Widget build(BuildContext context) {
    return Slidable(
      controller: slidableController,
      secondaryActions: [
        InkWell(
          onTap: (){
            showDialog(
              context: context,
              builder: (context){
                return ClusterEditDialog(cluster: widget.cluster,);
              }
            ).then((value) async{
              slidableController.activeState.close();
              print("value from dialog: " + value.toString());
              if(value != null) {
                if(value != false){
                  print(value.toMap().toString());
                  await clusterRepo.addorModifyCluster(context, value).then((value) async{
                    print("Re"+value.toString() );
                    if(value){
                      print("here1");
                      ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshClusterList);
                    }
                  });
                }
              }
            });
          },
          child: SlidableIconButton(myIcon: Icons.edit, iconSize: MediaQuery.of(context).size.width * 0.08,)
        ),
        InkWell(
          onTap: (){
            showDialog(
              context: context,
              builder: (context){
                return ConfirmAlert(title: "Delete Cluster?", tag: "This will delete the cluster and all the expenses under it",);
              }
            ).then((value) async {
              if(value != null){
                if(value){
                  slidableController.activeState.close();
                  await clusterRepo.deleteCluster(widget.cluster.id, context);
                  print("here");
                  ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshClusterList);
                }
              }
            });
          },
          child: SlidableIconButton(myIcon: Icons.delete, iconSize: MediaQuery.of(context).size.width * 0.08,)
        )
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
            // Container(
            //     child: Text(
            //       "₹ 5600",
            //       style: font.merge(
            //           TextStyle(
            //               fontSize: MediaQuery.of(context).size.width * 0.05,
            //               color: white
            //           )
            //       ),
            //     )
            // ),
          ],
        ),
      ),
    );
  }
}