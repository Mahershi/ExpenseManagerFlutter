import 'package:expensemanager/elements/outlinebutton.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:expensemanager/models/cluster_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClusterEditDialog extends StatefulWidget{
  ClusterModel cluster;

  ClusterEditDialog({this.cluster});

  @override
  PageState createState() => PageState();
}

class PageState extends State<ClusterEditDialog>{
  TextEditingController name = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    if(widget.cluster.id != null){
      name = TextEditingController(text: widget.cluster.name);
    }
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        CustomButton(
          text: "Cancel",
          onpressed: (){
            Navigator.of(context).pop(false);
          },
          bgColor: red,
          textColor: white,
        ),
        SizedBox(
          width: 5,
        ),
        CustomButton(
          text: "Save",
          onpressed: (){
            widget.cluster.name = name.text;
            Navigator.of(context).pop(widget.cluster);
          },
          bgColor: primaryColor,
          textColor: white,
        ),
      ],
      title: Text(
        widget.cluster.id != null ? "Edit Cluster" : "New Cluster",
        style: font.merge(
          TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.05,
            color: primaryColor
          )
        ),
      ),
      content: Container(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: name,
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return "Cluster Name Required";
                    }
                    else if(value.length > 15){
                      return "Max 15 Characters";
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
            ],
          ),
        )
      ),
    );
  }
}