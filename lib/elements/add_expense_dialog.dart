import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/expense_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:expensemanager/repositories/settings_repo.dart' as settingsRepo;
import 'package:expensemanager/repositories/cluster_repo.dart' as clusterRepo;
import 'package:expensemanager/repositories/expense_repository.dart' as exRepo;

class AddExpenseDialog extends StatefulWidget{
  String title;
  ExpenseModel expense;

  AddExpenseDialog({this.expense = null, this.title = "Add Expense"});
  @override
  PageState createState() => PageState();
}

class PageState extends State<AddExpenseDialog>{
  TextEditingController name = TextEditingController();
  TextEditingController amount = TextEditingController();
  String currentCategory = '1';
  DateTime selected;
  String selectedDateString;
  String currentCluster = '0';

  final formKey = GlobalKey<FormState>();
  @override
  void initState(){
    super.initState();

    if(widget.expense == null){
      widget.expense = ExpenseModel.createNew();
      // selected = DateTime.now();

    }
    selected = DateTime.parse(widget.expense.expense_date);
    name = TextEditingController(text: widget.expense.name);
    amount = TextEditingController(text: widget.expense.amount);
    currentCategory = widget.expense.category_id;
    currentCluster = widget.expense.cluster_id ?? '0';
    selectedDateString = selected.toIso8601String();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
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
              if(formKey.currentState.validate()){
                print(name.text);
                print(amount.text);
                print(selectedDateString);
                print(currentCategory);
                print(currentCluster);
                widget.expense.name = name.text;
                widget.expense.amount = amount.text;
                widget.expense.category_id = currentCategory;
                widget.expense.cluster_id = currentCluster == '0' ? null : currentCluster;
                print("CID");
                print(widget.expense.cluster_id);
                widget.expense.expense_date = selectedDateString;
                await exRepo.saveExpense(widget.expense, context).then((value){
                  print("Value:  " + value.toString());
                  Navigator.of(context).pop(value);
                });
              }
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
        contentPadding: EdgeInsets.only(top: 40, right: 40, left: 40, bottom: 40),
        titlePadding: EdgeInsets.only(top: 40, right: 40, left: 40),
        actionsPadding: EdgeInsets.only(bottom: 10, right: 10),
        title: Text(
          widget.title,
          style: font.merge(
            TextStyle(
              color: primaryColor
            )
          ),
        ),
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: name,
                      validator: (value){
                        if (value == null || value.isEmpty){
                          return "Expense Name Required";
                        }
                        else if(value.length > 20){
                          return "Max 20 Characters";
                        }
                        return null;
                      },
                      textAlign: TextAlign.center,
                      style: font.merge(TextStyle(
                          color: primaryColor,
                          letterSpacing: 1.4,
                          fontWeight: FontWeight.w800)),
                      decoration: InputDecoration(
                        hintText: "Expense Name",
                        hintStyle: font.merge(
                            TextStyle(color: grey, letterSpacing: 1.2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: borderRadius12,
                            borderSide: BorderSide(color: grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: borderRadius12,
                            borderSide: BorderSide(color: primaryColor)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: borderRadius12,
                            borderSide: BorderSide(color: red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: borderRadius12,
                            borderSide: BorderSide(color: primaryColor)),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: amount,
                      validator: (value){
                        if (value == null || value.isEmpty){
                          return "Amount Required";
                        }
                        return null;
                      },
                      textAlign: TextAlign.center,
                      style: font.merge(TextStyle(
                          color: primaryColor,
                          letterSpacing: 1.4,
                          fontWeight: FontWeight.w800)),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        hintText: "Amount",
                        hintStyle: font.merge(
                            TextStyle(color: grey, letterSpacing: 1.2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: borderRadius12,
                            borderSide: BorderSide(color: grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: borderRadius12,
                            borderSide: BorderSide(color: primaryColor)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: borderRadius12,
                            borderSide: BorderSide(color: red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: borderRadius12,
                            borderSide: BorderSide(color: primaryColor)),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          child: Text(
                            "Date",
                            style: font.merge(
                                TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: grey,
                                    fontSize: MediaQuery.of(context).size.width * 0.04
                                )
                            ),
                          )
                      ),
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                            // decoration: BoxDecoration(border: testBorder),
                            child: InkWell(
                              onTap: () async{
                                var got = await showDatePicker(
                                  context: context,
                                  initialDate: selected,
                                  currentDate: selected,
                                  firstDate: DateTime(2020, 1, 1),
                                  lastDate: DateTime.now().add(Duration(days: 7))
                                );
                                if(got != null){
                                  selected = got;
                                  selectedDateString = selected.toIso8601String();
                                  print(selected.toIso8601String().toString());
                                  setState(() {

                                  });
                                }

                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    child: Text(
                                      selectedDateString.substring(0, 10),
                                      style: font.merge(
                                        TextStyle(
                                          fontSize: MediaQuery.of(context).size.width * 0.04,
                                          color: primaryColor
                                        )
                                      ),
                                    )
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    child: Icon(
                                      Icons.calendar_today_rounded,
                                      size: MediaQuery.of(context).size.width * 0.06,
                                      color: primaryColor,
                                    )
                                  )
                                ],
                              ),
                            )
                        ),
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            "Category",
                            style: font.merge(
                              TextStyle(
                                fontWeight: FontWeight.w300,
                                color: grey,
                                fontSize: MediaQuery.of(context).size.width * 0.04
                              )
                            ),
                          )
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                          child: DropdownButton(
                            isExpanded: true,
                            value: currentCategory,
                            items: settingsRepo.categories.map((e){
                              print(e.name);
                              return DropdownMenuItem(
                                value: e.id,
                                child: Text(
                                  e.name,
                                  style: font.merge(
                                    TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.035,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600
                                    )
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value){
                              currentCategory = value;
                              setState(() {

                              });
                            },
                            underline: Container(
                              height: 1,
                              color: primaryColor,
                            ),
                            icon: Icon(Icons.keyboard_arrow_down_rounded, color: primaryColor,),
                          )
                        ),
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                            child: Text(
                              "Cluster",
                              style: font.merge(
                                  TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: grey,
                                      fontSize: MediaQuery.of(context).size.width * 0.04
                                  )
                              ),
                            )
                        ),
                      ),
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                            child: DropdownButton(
                              isExpanded: true,
                              value: currentCluster,
                              items: clusterRepo.clusters.map((e){
                                print(e.name);
                                return DropdownMenuItem(
                                  value: e.id,
                                  child: Text(
                                    e.name,
                                    style: font.merge(
                                        TextStyle(
                                            fontSize: MediaQuery.of(context).size.width * 0.035,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600
                                        )
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value){
                                currentCluster = value;
                                setState(() {

                                });
                              },
                              underline: Container(
                                height: 1,
                                color: primaryColor,
                              ),
                              icon: Icon(Icons.keyboard_arrow_down_rounded, color: primaryColor,),

                            )
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Text(
                      "To add to a new cluster, first create a new cluster",
                      style: font.merge(
                        TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.025,
                          color: grey
                        )
                      ),
                      textAlign: TextAlign.justify,
                    )
                  )
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}