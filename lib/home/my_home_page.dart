import 'package:flutter/material.dart';
import 'package:kamionchi/utils/app_colors.dart' as AppColor;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Row(
                children: [
                  
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}