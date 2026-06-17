import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kamionchi/home/my_tabs.dart';
import 'package:kamionchi/utils/app_colors.dart' as AppColor;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  late ScrollController _scrollController;
  late TabController _tabController;

  List? popularBooks;
  List? books;

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

  readBooksData() async {
    try {
      String s = await DefaultAssetBundle.of(context).loadString("json/books.json");
      setState(() {
        books = json.decode(s);
      });
    } catch (e) {
      print("Error On Load File : $e");
    }
  }


  @override
  void initState() {
    super.initState();
    readData();
    readBooksData();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
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

              Expanded(
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: AppColor.silverBackground,
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(50),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: TabBar(
                              indicatorPadding: EdgeInsetsGeometry.all(8),
  indicatorSize: TabBarIndicatorSize.label,
  labelPadding: EdgeInsets.only(right: 10),
  controller: _tabController,
  isScrollable: true,
                              tabs: [
                                AppTabs(color: AppColor.menu1Color, text: 'Home'),
                                AppTabs(color: AppColor.menu2Color, text: 'Popular'),
                                AppTabs(color: AppColor.menu3Color, text: 'Irendin'),
                                
                              ],
                            ),
                          )
                        ),
                      )
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                        itemCount: books == null ? 0 : books?.length,
                        itemBuilder: (_, i) {
                          return Container(
                            margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.tabVarViewColor,
                                boxShadow: [
                                  BoxShadow(blurRadius: 2, offset: Offset(0, 0), color: Colors.grey.withOpacity(0.2))
                                ]
                              ),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(image: AssetImage("assets/images/podcast2.jpg"))
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.star, size: 24, color: AppColor.starColor,),
                                            SizedBox(width: 5,),
                                            Text(books?[i]['rating'], style: TextStyle(color: AppColor.menu2Color),)
                                          ],
                                        ),
                                        Text(books?[i]['title'], style: TextStyle(fontSize: 14,),),
                                        Text(books?[i]['text'], style: TextStyle(fontSize: 12, color: AppColor.subTitleText),),
                                        SizedBox(height: 10,),
                                        Container(
                                          width: 60,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: AppColor.loveColor
                                          ),
                                          child: Text('Read', style: TextStyle(color: Colors.white,), textAlign: TextAlign.center,),
                                        ),
                                        
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                       Material(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                          title: Text('Content'),
                        ),
                      ),
                       Material(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                          title: Text('Content'),
                        ),
                      ),
                    ]
                  ),
                )
              )
              
            ],
          ),
        )
      ),
    );
  }
}