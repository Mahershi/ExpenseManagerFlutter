import 'package:expensemanager/helpers/constants.dart';
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
    authRequired: false,
    showSuccess: true,
    showError: true,
    showLoader: true,
    loaderColor: accentColor
  );
  return resp['success'] == 'true';
}

Future<void> getClusters(context) async{
  var qp = {
    'user_id': currentUser.id
  };

  var resp = await RestService.request(
      context: context,
      endpoint: API.clusters,
      authRequired: false,
      queryParameters: qp,
  );
  if(resp['success'] == 'true'){
    clusters.clear();
    for(var i in resp['data']){
      var c = ClusterModel.fromJson(i);
      clusters.add(c);
    }
  }
  clusters.insert(0, none);
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
    method: "POST",
    showSuccess: true,
    showError: true,
    showLoader: true,
    loaderColor: accentColor
  );
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
      method: "POST",
    showLoader: true
  );
}

Future<bool> deleteCluster(clusterID, context) async{
  String api = API.clusters;
  api += "/$clusterID/";
  String method = 'DELETE';

  var resp = await RestService.request(
    context: context,
    endpoint: api,
    method: method,
    authRequired: false,
    showSuccess: true,
    showError: true,
    showLoader: true,
    loaderColor: accentColor
  );

  print(resp.toString());
  return resp['success'] == 'true';
}

ClusterModel getClusterById(id){
  for(var i in clusters){
    if(i.id == id)
      return i;
  }
}
