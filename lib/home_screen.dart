import 'dart:convert';

import 'package:flutter_application_1/app_theme.dart';
import 'package:flutter/material.dart';
import 'model/homelist.dart';
import 'design_course/design_course_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/design_course/category_list_view.dart';
import 'package:flutter_application_1/design_course/course_info_screen.dart';
import 'package:flutter_application_1/design_course/popular_course_list_view.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  String data = "https://91.com.tr/";
  String qrData = "";
  String categoryId = "search";
  String serticate = '';
  List category = [];

  CategoryType categoryType = CategoryType.ui;
  List<HomeList> homeList = HomeList.homeList;
  AnimationController? animationController;
  bool multiple = true;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  void qrCode() {
    FlutterBarcodeScanner.scanBarcode("#000000", "Cancel", true, ScanMode.QR)
        .then((value) {
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(value),
        content: Text("This is my message."),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  appBar(),
                  Expanded(
                    child: FutureBuilder<bool>(
                      future: getData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        } else {
                          return Container(
                            color: DesignCourseAppTheme.nearlyWhite,
                            child: Scaffold(
                              backgroundColor: Colors.transparent,
                              body: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: MediaQuery.of(context).padding.top,
                                  ),
                                  getAppBarUI(),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: Column(
                                          children: <Widget>[
                                            getCategoryUI(),
                                            Flexible(
                                              child: getPopularCourseUI(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '',
                  style: TextStyle(
                    fontSize: 22,
                    color: AppTheme.darkText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              color: Colors.white,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    multiple ? Icons.dashboard : Icons.view_agenda,
                    color: AppTheme.dark_grey,
                  ),
                  onTap: () {
                    setState(() {
                      multiple = !multiple;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getCategoryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            '',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: <Widget>[
              getButtonUI(CategoryType.ui, categoryType == CategoryType.ui),
              const SizedBox(
                width: 16,
              ),
              getButtonUI(
                  CategoryType.coding, categoryType == CategoryType.coding),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        getSearchBarUI(),
      ],
    );
  }

// post data 
  sendCertificateCode() {
    String code = this.serticate;
      var body = jsonEncode({ "sertificate_no" : this.serticate });

    Uri url = Uri.parse("https://portal.intcert.com.tr/api/check",);
      this.setState(() {
        category = [];
      });

 return http.post(url,
        headers: {
          "content-Type": "application/json",
          },
        body: body
  ).then((value) => {
      this.setState((){
        category = jsonDecode(value.body);
      })
  });

}

  void moveTo() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => CourseInfoScreen(),
      ),
    );
  }

  Widget getPopularCourseUI() {

    if(!category.isEmpty) {
 return Padding(
      padding: const EdgeInsets.only(top: 0.0, left: 0, right: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
         <Widget>[
          CategoryListView(
            category
        ),
          // listview gelecek
        ],
      ),
    );
    }else{
       return Padding(
      padding: const EdgeInsets.only(top: 0.0, left: 0, right: 0),
      child: Text(
        "Sertifika Bulunamadı"
      )
    );
    }
  
  }

  void scanQrCode() {
    FlutterBarcodeScanner.scanBarcode("#000000", "Cancel", true, ScanMode.QR)
        .then((value) {
          
           String code = value;
      var body = jsonEncode({ "sertificate_no" : value });

    Uri url = Uri.parse("https://portal.intcert.com.tr/api/check",);
      this.setState(() {
        category = [];
      });

 return http.post(url,
        headers: {
          "content-Type": "application/json",
          },
        body: body
  ).then((value) => {
      this.setState((){
        category = jsonDecode(value.body);
      })
  });
    });
  }

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    String txt = '';
    if (CategoryType.ui == categoryTypeData) {
      txt = 'Arama';
    } else if (CategoryType.coding == categoryTypeData) {
      txt = 'QR';
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: isSelected
                ? DesignCourseAppTheme.nearlyBlue
                : DesignCourseAppTheme.nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: DesignCourseAppTheme.nearlyBlue)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              setState(() {
                categoryType = categoryTypeData;
                if (categoryTypeData == CategoryType.ui) {
                  categoryId = "search";
                } else {
                  categoryId = "qr";
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: isSelected
                        ? DesignCourseAppTheme.nearlyWhite
                        : DesignCourseAppTheme.nearlyBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getSearchBarUI() {
    if (categoryId == 'search') {
      return Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              height: 40,
              child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: null),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          margin: const EdgeInsets.only(left: 35, right: 35),
          decoration: BoxDecoration(
            color: HexColor('#F8FAFB'),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(13.0),
              bottomLeft: Radius.circular(13.0),
              topLeft: Radius.circular(13.0),
              topRight: Radius.circular(13.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: TextFormField(
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: DesignCourseAppTheme.nearlyBlue,
                    ),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Sorgulamak için yazınız...',
                      border: InputBorder.none,
                      helperStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: HexColor('#B9BABC'),
                      ),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: HexColor('#B9BABC'),
                      ),
                    ),
                    onEditingComplete: () {
                      print("sdasd");
                    },
                    onChanged: (value) {
                      this.serticate = value;
                    },
                  ),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  sendCertificateCode();
                },
                child: Icon(Icons.search, color: HexColor('#B9BABC')),
              ),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.all(25),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: DesignCourseAppTheme.nearlyBlue,
                    minimumSize: const Size.fromHeight(50)),
                child: Text(
                  'Sorgula',
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () {
                  sendCertificateCode();
                },
              ),
            ))
      ]);
    } else {
      return Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              height: 40,
              child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: null),
            ),
          ],
        ),
       
        Container(
            margin: EdgeInsets.all(25),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: DesignCourseAppTheme.nearlyBlue,
                    minimumSize: const Size.fromHeight(50)),
                child: Text(
                  'Qr Kod Tarat' + qrData,
                  style: TextStyle(fontSize: 20.0),
                ),
              
                onPressed: () {
                  scanQrCode();
                },
              ),
            ))
      ]);
    }
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Hoşgeldiniz',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: DesignCourseAppTheme.grey,
                  ),
                ),
                Text(
                  'Sorgulama Ekranı',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color: DesignCourseAppTheme.darkerText,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 60,
            height: 60,
            child: Image.asset('assets/images/logo.png'),
          )
        ],
      ),
    );
  }
}

enum CategoryType {
  ui,
  coding,
}

class HomeListView extends StatelessWidget {
  const HomeListView(
      {Key? key,
      this.listData,
      this.callBack,
      this.animationController,
      this.animation})
      : super(key: key);

  final HomeList? listData;
  final VoidCallback? callBack;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: AspectRatio(
              aspectRatio: 1.5,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.asset(
                        listData!.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.grey.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        onTap: callBack,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
