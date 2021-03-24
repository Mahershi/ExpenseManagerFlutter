class Utils{
  static Future<dynamic> iterateListData(data) async{
    for(var i in data){
      return i;
    }
  }

  static Stream<dynamic> iterateListStream(Stream<dynamic> stream) async*{
    await for(var i in stream){
      print(i.runtimeType);
      yield i;
    }
  }
}