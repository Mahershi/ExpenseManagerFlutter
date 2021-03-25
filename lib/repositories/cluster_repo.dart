import 'package:expensemanager/models/cluster_model.dart';
import 'package:expensemanager/models/expense_model.dart';
import 'package:expensemanager/network/APIs.dart';
import 'package:expensemanager/network/rest_service.dart';
import 'package:expensemanager/repositories/user_repo.dart';


List<ClusterModel> clusters = List<ClusterModel>();
ClusterModel none = ClusterModel.none();

Future<bool> addorModifyCluster(context, ClusterModel cluster) async{
  String api = API.clusters + '/';
  String method = 'POST';
  if(cluster.id != null) {
    api = api + '${cluster.id}/';
    method = 'PATCH';
  }

  var data = cluster.toMap();

  var resp = await RestService.request(
    context: context,
    endpoint: api,
    method: method,
    data: data,
    authRequired: false
  );
  print("RESSS");
  print(resp.toString());
  return resp['success'] == 'true';
}

Future<void> getClusters(context) async{
  clusters.clear();
  var qp = {
    'user_id': currentUser.id
  };

  var resp = await RestService.request(
      context: context,
      endpoint: API.clusters,
      authRequired: false,
      queryParameters: qp
  );
  if(resp['success'] == 'true'){
    for(var i in resp['data']){
      var c = ClusterModel.fromJson(i);
      clusters.add(c);
    }
  }
  clusters.insert(0, none);
  for(var i in clusters){
    print(i.toMap().toString());
  }
}

Future<void> changeCluster(expenseid, oldclusterid, newclusterid, context) async{
  var data = {
    "new_cluster_id": int.parse(newclusterid),
    "old_cluster_id": int.parse(oldclusterid),
    "expense_id": expenseid
  };

  var resp = await RestService.request(
    context: context,
    endpoint: API.cluster_change,
    data: data,
    authRequired: false,
    method: "POST"
  );
  print(resp.toString());
}

Future<void> removeExpenseFromCluster(ExpenseModel expense, context) async{
  var data = {
    "cluster_id": expense.cluster_id,
    "expense_id": expense.id
  };

  var resp = await RestService.request(
      context: context,
      endpoint: API.cluster_remove,
      data: data,
      authRequired: false,
      method: "POST"
  );
  print(resp.toString());
}

ClusterModel getClusterById(id){
  for(var i in clusters){
    if(i.id == id)
      return i;
  }
}
