import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kamionchi/utils/app_colors.dart' as AppColor;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List? popularBooks;

  readData() async {
  try {
    String s = await DefaultAssetBundle.of(context).loadString("json/popularBooks.json");
    setState(() {
      popularBooks = json.decode(s);
    });
  } catch (e) {
    print("Error On Load File : $e");
  }
}


  @override
  void initState() {
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // setting icon 
                    Icon(Icons.settings, size: 24, color: Colors.black,),
                
                    // search & notification icons row
                    Row(
                      spacing: 10,
                      children: [
                        Icon(Icons.search),
                        Icon(Icons.notifications_active),
                      ],
                    )
                  ],
                ),
              ),

              SizedBox(height: 20,),

            //  title row
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20,),
                    child: Text('Popular Books', style: TextStyle(fontSize: 20),),
                  )
                ],
              ),

              SizedBox(height: 20,),

              // slider section 
              SizedBox(
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: -20,
                      right: 0,
                      child: SizedBox(
                        height: 180,
                        child: PageView.builder(
                          controller: PageController(viewportFraction: 0.8),
                          itemCount: popularBooks == null ? 0 : popularBooks?.length,
                          itemBuilder: (_, i) {
                            return Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  // image: AssetImage('assets/images/mess.jpg'),
                                  image: AssetImage(popularBooks?[i]["img"]),
                                  fit: BoxFit.fill
                                )
                              ),
                            );
                          }
                        ),
                      ),
                    )
                  ],
                ),
              ),
              
            ],
          ),
        )
      ),
    );
  }
}