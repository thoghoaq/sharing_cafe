import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  final bool fromSplash;
  const DashboardScreen({Key? key, required this.pageIndex, this.fromSplash = false}) : super(key: key);

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text("đấy là màn hình dashboard"),);
  }
}