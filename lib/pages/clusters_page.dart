import 'package:expensemanager/blocs/expense_detail_bloc.dart';
import 'package:expensemanager/controllers/clustercontroller.dart';
import 'package:expensemanager/elements/back_button_app_bar.dart';
import 'package:expensemanager/elements/cluster_item.dart';
import 'package:expensemanager/elements/no_expenses.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/route_arguement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expensemanager/repositories/cluster_repo.dart' as clusterRepo;
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:expensemanager/repositories/settings_repo.dart' as settingsRepo;

class ClusterPage extends StatefulWidget{
  @override
  PageState createState() => PageState();
}

class PageState extends StateMVC<ClusterPage> with RouteAware{
  ClusterController _con;
  String heading = "Clusters";

  PageState() : super(ClusterController()){
    _con = controller;
  }

  @override
  void didPopNext(){
    print("visible");
    super.didPopNext();
    ExpenseBloc.expEventSink.add(ExpenseEvent.RefreshClusterList);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    settingsRepo.routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose(){
    settingsRepo.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    ExpenseBloc.expEventStream.listen((event)async{
      if(event == ExpenseEvent.RefreshClusterList) {
        print("refreshing clusters");
        await _con.fetchClusters(context);
      }
      // ExpenseBloc.mapexpEventToState(event);
    });
    //not needed bcz when page first appears from home page, clusters are already loaded to latest
    print("re init");
    _con.fetchClusters(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        color: accentColor,
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
                  color: primaryColor,
                )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: radius20, topLeft: radius20),
                    color: primaryColor
                ),
                height: MediaQuery.of(context).size.height * 0.9 - 40,
                width: MediaQuery.of(context).size.width,
                child: clusterRepo.clusters.length > 1 ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: clusterRepo.clusters.length - 1,
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap: (){
                       Navigator.of(context).pushNamed('/ClusterDetail', arguments: RouteArgument(param: clusterRepo.clusters[index + 1]));
                      },
                      child: ClusterItem(cluster: clusterRepo.clusters[index + 1],)
                    );
                  },
                ) : NoExpenses(
                  text: "No Clusters!",
                  textColor: accentColor,
                  tag: "Group your expenses under a common title as per your convenience to receive statistics about the cluster",
                )
              ),
            ),
          ],
        )
      )
    );
  }
}