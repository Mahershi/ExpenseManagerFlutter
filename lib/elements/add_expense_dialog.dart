import 'package:carousel_slider/carousel_slider.dart';
import 'package:expensemanager/blocs/expense_detail_bloc.dart';
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
  CarouselController carouselController = CarouselController();
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
    print(selectedDateString);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: borderRadius20
        ),
        actions: [
          OutlinedButton(
            onPressed: (){
              Navigator.of(context).pop(false);
            },
            style: OutlinedButton.styleFrom(
                primary: accentColor,
                backgroundColor: red,
                elevation: 1
            ),
            child: Text(
              "Cancel",
              style: font.merge(
                  TextStyle(
                      color: accentColor,
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
                Navigator.of(context).pop(widget.expense);

              }
            },
            style: OutlinedButton.styleFrom(
                primary: accentColor,
                backgroundColor: primaryColor,
                elevation: 1
            ),
            child: Text(
              "Save",
              style: font.merge(
                  TextStyle(
                      color: accentColor,
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
                  Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 30, bottom: 20),
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
                      Container(
                          child: IntrinsicHeight(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.15,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: grey),
                                      bottom: BorderSide(color: grey),
                                    )
                                  ),
                                ),
                                CarouselSlider(
                                  carouselController: carouselController,
                                  options: CarouselOptions(
                                    height: 40,
                                    initialPage: settingsRepo.categories.indexOf(settingsRepo.getCategoryById(currentCategory)),
                                    viewportFraction: 0.4,
                                    onPageChanged: (index, reason){
                                      currentCategory = settingsRepo.categories.elementAt(index).id;
                                      setState(() {
                                      });
                                    },
                                    disableCenter: false,
                                  ),
                                  items: settingsRepo.categories.map((e){
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      onTap: (){
                                        currentCategory = e.id;
                                        carouselController.animateToPage(settingsRepo.categories.indexOf(settingsRepo.getCategoryById(currentCategory)));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 10),
                                          alignment: Alignment.center,
                                          child: Text(
                                            e.name,
                                            style: font.merge(
                                                TextStyle(
                                                    color: e.id == currentCategory ? black : grey,
                                                    letterSpacing: 1.3,
                                                  fontWeight: e.id == currentCategory ? FontWeight.w600 : FontWeight.w300,
                                                  fontSize: MediaQuery.of(context).size.width * 0.03
                                                )
                                            ),
                                          )
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          )
                      ),
                    ],
                  ),

                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}