import 'dart:async';

import 'package:expensemanager/controllers/expensedetail_controller.dart';

enum ExpenseEvent{RefreshExpenseDetail, RefreshHome, RefreshBatch, RefreshClusterList, RefreshClusterDetail}

class ExpenseBloc{
  static ExpenseDetailController controller;
  static final expEventController = StreamController<ExpenseEvent>.broadcast();
  static final expEventSink = expEventController.sink;
  static final expEventStream = expEventController.stream;

  static final expStateController = StreamController<int>.broadcast();
  static final expStateSink = expStateController.sink;
  static final expStateStream = expStateController.stream;

  static final homeStateController = StreamController<int>.broadcast();
  static final homeStateSink = expStateController.sink;
  static final homeStateStream = expStateController.stream;

  static final exListStateController = StreamController<int>.broadcast();
  static final exListStateSink = exListStateController.sink;
  static final exListStateStream = exListStateController.stream;

  static void mapexpEventToState(ExpenseEvent event){
    // if(event == ExpenseEvent.RefreshExpenseDetail){
    //   expStateSink.add(1);
    // }else if(event == ExpenseEvent.RefreshHome){
    //   homeStateSink.add(1);
    // }
  }


}