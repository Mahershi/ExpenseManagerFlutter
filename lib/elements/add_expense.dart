import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/expense_model.dart';
import 'package:expensemanager/models/route_arguement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expensemanager/repositories/settings_repo.dart' as settingsRepo;

class AddExpense extends StatefulWidget{
  RouteArgument routeArgument;

  AddExpense({this.routeArgument});
  @override
  PageState createState() => PageState();
}

class PageState extends State<AddExpense>{
  ExpenseModel expense;
  final formKey = GlobalKey<FormState>();
  CarouselController carouselController = CarouselController();
  TextEditingController name = TextEditingController();
  TextEditingController amount = TextEditingController();
  String currentCategory = '1';
  DateTime selected;
  String selectedDateString;
  String currentCluster = '0';

  @override
  void initState(){
    super.initState();
    expense = widget.routeArgument.param as ExpenseModel;
    selected = DateTime.parse(expense.expense_date);
    print("here");
    print(selected.toString());

    name = TextEditingController(text: expense.name);
    amount = TextEditingController(text: expense.amount);
    currentCategory = expense.category_id;
    currentCluster = expense.cluster_id ?? '0';
    selectedDateString = selected.toIso8601String();
    print(selectedDateString);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.of(context).pop(false);
        return ;
      },
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: Container(
            color: primaryColor,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    color: primaryColor,
                    // height: MediaQuery.of(context).size.height * 0.5 - 24,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Expense",
                                style: font.merge(
                                  TextStyle(
                                    color: accentColor,
                                    fontSize: MediaQuery.of(context).size.width * 0.07
                                  )
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  if(formKey.currentState.validate()){
                                    print(name.text);
                                    print(amount.text);
                                    print(selectedDateString);
                                    print(currentCategory);
                                    print(currentCluster);
                                    expense.name = name.text;
                                    expense.amount = amount.text;
                                    expense.category_id = currentCategory;
                                    expense.cluster_id = currentCluster == '0' ? null : currentCluster;
                                    print(expense.cluster_id);
                                    expense.expense_date = selectedDateString;
                                    Navigator.of(context).pop(expense);
                                  }
                                },
                                child: Icon(
                                  Icons.done,
                                  size: MediaQuery.of(context).size.width * 0.07,
                                  color: accentColor,
                                ),
                              )
                            ],
                          )
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Row(
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
                                                        color: accentColor
                                                    )
                                                ),
                                              )
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                              child: Icon(
                                                Icons.calendar_today_rounded,
                                                size: MediaQuery.of(context).size.width * 0.06,
                                                color: accentColor,
                                              )
                                          )
                                        ],
                                      ),
                                    )
                                ),
                              ),

                            ],
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
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
                                fontSize: MediaQuery.of(context).size.width * 0.06,
                                color: accentColor,
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
                                  borderSide: BorderSide(color: secondColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: borderRadius12,
                                  borderSide: BorderSide(color: accentColor)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: borderRadius12,
                                  borderSide: BorderSide(color: red)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: borderRadius12,
                                  borderSide: BorderSide(color: accentColor)),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      color: accentColor,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
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
                                    fontSize: MediaQuery.of(context).size.width * 0.045,

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
                            Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 30, bottom: 30),
                                    child: Text(
                                      "Category",
                                      style: font.merge(
                                          TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: grey,
                                              fontSize: MediaQuery.of(context).size.width * 0.045
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
                                                  top: BorderSide(color: primaryColor),
                                                  bottom: BorderSide(color: primaryColor),
                                                )
                                            ),
                                          ),
                                          CarouselSlider(
                                            carouselController: carouselController,
                                            options: CarouselOptions(
                                              height: 40,
                                              initialPage: settingsRepo.categories.indexOf(settingsRepo.getCategoryById(currentCategory)),
                                              viewportFraction: 0.34,
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
                                                              fontSize: MediaQuery.of(context).size.width * 0.035
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
                      )
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}