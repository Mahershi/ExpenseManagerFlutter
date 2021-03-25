import 'package:expensemanager/models/cluster_model.dart';
import 'package:expensemanager/network/APIs.dart';
import 'package:expensemanager/network/rest_service.dart';
import 'package:expensemanager/repositories/user_repo.dart';


List<ClusterModel> clusters = List<ClusterModel>();
ClusterModel none = ClusterModel.none();

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

ClusterModel getClusterById(id){
  for(var i in clusters){
    if(i.id == id)
      return i;
  }
}
