import 'package:expensemanager/elements/add_expense.dart';
import 'package:expensemanager/pages/account_page.dart';
import 'package:expensemanager/pages/change_password.dart';
import 'package:expensemanager/pages/clusterdetail_page.dart';
import 'package:expensemanager/pages/clusters_page.dart';
import 'package:expensemanager/pages/colorspage.dart';
import 'package:expensemanager/pages/edit_profile.dart';
import 'package:expensemanager/pages/expenses_detail.dart';
import 'package:expensemanager/pages/home_page.dart';
import 'package:expensemanager/pages/login_page.dart';
import 'package:expensemanager/pages/logo_page.dart';
import 'package:expensemanager/pages/settings_page.dart';
import 'package:expensemanager/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/LoginPage':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/SignupPage':
        return MaterialPageRoute(builder: (_) => SignupPage());
      case '/HomePage':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/ExpensesPage':
        return MaterialPageRoute(builder: (_) => ExpensesDetail(routeArgument: args,));
      case '/Account':
        return MaterialPageRoute(builder: (_) => AccountPage());
      case '/Clusters':
        return MaterialPageRoute(builder: (_) => ClusterPage());
      case '/ClusterDetail':
        return MaterialPageRoute(builder: (_) => ClusterDetail(routeArgument: args,));
      case '/Settings':
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case '/Colors':
        return MaterialPageRoute(builder: (_) => ColorsPage());
      case '/AddExpense':
        return MaterialPageRoute(builder: (_) => AddExpense(routeArgument: args,));
      case '/EditProfile':
        return MaterialPageRoute(builder: (_) => EditProfile());
      case '/ChangePassword':
        return MaterialPageRoute(builder: (_) => ChangePassword(routeArgument: args,));
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
