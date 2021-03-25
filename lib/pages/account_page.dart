import 'package:expensemanager/controllers/account_controller.dart';
import 'package:expensemanager/elements/account_item.dart';
import 'package:expensemanager/elements/back_button_app_bar.dart';
import 'package:expensemanager/helpers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:expensemanager/repositories/user_repo.dart' as userRepo;
import 'package:shared_preferences/shared_preferences.dart';


class AccountPage extends StatefulWidget{
  @override
  PageState createState() => PageState();
}

class PageState extends StateMVC<AccountPage>{
  AccountController _con;
  PageState() : super(AccountController()){
    _con = controller;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        // color: primaryColor,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20, right: 20, left: 20, bottom: 40),
              decoration: BoxDecoration(
                color: primaryColor,
                // borderRadius: BorderRadius.only(bottomLeft: radius30, bottomRight: radius30)
                image: DecorationImage(
                  image: AssetImage(
                    'assets/img/background.jpg',
                  ),
                  colorFilter: ColorFilter.mode(primaryColor.withOpacity(0.5), BlendMode.dstATop),
                  fit: BoxFit.cover
                )
              ),
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    // decoration: BoxDecoration(border: testBorder),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: white),
                                  borderRadius: borderRadius12
                              ),
                              child: Icon(
                                Icons.chevron_left,
                                color: white,
                              )
                          ),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: white, width: 2)
                                ),
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Image.asset(
                                'assets/img/profile.png',
                                // width: MediaQuery.of(context).size.width * 0.2,
                                color: white,
                              )
                            ),
                            Transform.translate(
                              offset: Offset(MediaQuery.of(context).size.width * 0.15, 0),
                              child: Container(
                                padding: EdgeInsets.all(4),
                                width: MediaQuery.of(context).size.width * 0.06,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: white, width: 2),
                                  color: white
                                ),
                                child: Icon(
                                  Icons.edit,
                                  size: MediaQuery.of(context).size.width * 0.03
                                )
                              ),
                            )
                          ],
                        ),
                        Container(
                          child: Text(
                            "v 1.0.0",
                            style: font.merge(
                              TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.03,
                                color: white,
                                letterSpacing: 1.3
                              )
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text(
                      userRepo.currentUser.name,
                      style: font.merge(
                          TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                              color: white,
                              letterSpacing: 1.3
                          )
                      ),
                    )
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.65 + 40,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(topLeft: radius20, topRight: radius20)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            AccountItem(text: "Edit Profile", imagePath: 'assets/img/edit.png',),
                            InkWell(
                              child: AccountItem(
                                text: "My Clusters", imagePath: 'assets/img/cluster.png',
                              ),
                              onTap: (){
                                Navigator.of(context).pushNamed('/Clusters');
                              },
                            ),
                            AccountItem(text: "Settings", imagePath: 'assets/img/settings.png',),
                            // AccountItem(text: "Delete Account", myIcon: Icons.delete_forever,)
                          ],
                        )
                      ),
                    ),
                    InkWell(
                      onTap: ()async{
                        SharedPreferences _pref = await SharedPreferences.getInstance();
                        await _pref.remove('user');
                        Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage', (route) => false);
                      },
                      child: Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: borderRadius20
                        ),
                        child: Text(
                          "Logout",
                          style: font.merge(
                            TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                              color: white
                            )
                          ),
                        )
                      ),
                    )
                  ],
                )
              )
            )
          ],
        )
      ),
    );
  }
}