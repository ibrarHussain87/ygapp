import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/providers/family_list_provider.dart';
import 'package:yg_app/providers/fiber_specification_provider.dart';
import 'package:yg_app/providers/post_fiber_provider.dart';
import 'package:yg_app/providers/post_yarn_provider.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/pages/auth_pages/login/signin_page.dart';
import 'package:yg_app/pages/main_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yg_app/providers/sync_provider.dart';

import 'api_services/api_service_class.dart';
import 'app_database/app_database_instance.dart';
import 'model/response/common_response_models/countries_response.dart';
import 'providers/fabric_specifications_provider.dart';
import 'providers/filter_fabric_provider.dart';
import 'providers/post_fabric_provider.dart';
import 'providers/stocklot_provider.dart';
import 'providers/yarn_specifications_provider.dart';
import 'helper_utils/app_constants.dart';
import 'helper_utils/connection_status_singleton.dart';
import 'notification/notification.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  await init();
  runApp(YgApp());
}

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  ///Set preferred orientation to portrait
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setupLocators();
  await FCM.initialize(flutterLocalNotificationsPlugin);
  await Firebase.initializeApp();


}

class YgApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StocklotProvider>(create: (_) => StocklotProvider()),
        ChangeNotifierProvider<YarnSpecificationsProvider>(create: (_) => YarnSpecificationsProvider()),
        ChangeNotifierProvider<FabricSpecificationsProvider>(create: (_) => FabricSpecificationsProvider()),
        ChangeNotifierProvider<PostFabricProvider>(create: (_) => PostFabricProvider()),
        ChangeNotifierProvider<FilterFabricProvider>(create: (_) => FilterFabricProvider()),
        ChangeNotifierProvider(create: (_)=> locator<PostYarnProvider>()),
        ChangeNotifierProvider(create: (_)=> locator<FiberSpecificationProvider>()),
        ChangeNotifierProvider(create: (_)=> locator<PostFiberProvider>()),
        ChangeNotifierProvider(create: (_)=> locator<FamilyListProvider>()),
        ChangeNotifierProvider(create: (_)=> locator<SyncProvider>()),
      ],
      child: MaterialApp(
        title: 'Splash Screen',
        theme: ThemeData(
            primaryColor: lightBlueTabs,
            primarySwatch: Colors.green,
            /*/*fontFamily: 'Metropolis',*/*/
            textTheme:
            GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),),
        home: YgAppPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class YgAppPage extends StatefulWidget {
  @override
  _YgAppPageState createState() => _YgAppPageState();
}

class _YgAppPageState extends State<YgAppPage> with TickerProviderStateMixin {
  String notificationTitle = 'No Title';
  String notificationBody = 'No Body';
  String notificationData = 'No Data';

  // state variables                           <-- state
  final _myDuration = const Duration(seconds: 1);
  double heightC1 = 1.0;
  double heightC2 = 1.0;
  double widthC1 = 80.0;
  double widthC2 = 80.0;
  late Timer _timer;
  late AnimationController _controller;
  late Animation<double> _animation;


  _YgAppPageState() {
    _timer = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _incrementCounter();
      });
    });
  }

  void _firebaseCrash() async {
    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }
    // FirebaseCrashlytics.instance.crash();
  }


  void _incrementCounter() {
    setState(() {
      heightC1 = MediaQuery.of(context).size.width * 0.5;
      heightC2 = MediaQuery.of(context).size.width * 0.8;
      widthC1 = MediaQuery.of(context).size.width * 0.5;
      widthC2 = MediaQuery.of(context).size.width * 0.8;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications(flutterLocalNotificationsPlugin);
    firebaseMessaging.setDeviceToken();

    firebaseMessaging.streamCtlr.stream.listen(_changeData);
    firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
    firebaseMessaging.titleCtlr.stream.listen(_changeTitle);

    _firebaseCrash();
    _synData();

    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 6000),
        vsync: this,
        lowerBound: 0,
        upperBound: 1);

    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

    _controller.forward();

    Timer(const Duration(seconds: 5), () async {
      bool userLogin = await SharedPreferenceUtil.getBoolValuesSF(IS_LOGIN);

      check().then((intenet) {
        if (intenet) {
          // Internet Present Case
          if (userLogin) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MainPage()));
          } else {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SignInPage()));
//                MaterialPageRoute(builder: (context) => const LoginPage()));
          }
        } else {
          showInternetDialog(
              no_internet_available_msg, check_internet_msg, context, () {
            Navigator.pop(context);
          });
        }
      });
    });
  }

  _changeData(String msg) {
    if (mounted) {
      setState(() => notificationData = msg);
    }
  }

  _changeBody(String msg) {
    if (mounted) {
      setState(() => notificationBody = msg);
    }
  }

  _changeTitle(String msg) {
    if (mounted) {
      setState(() => notificationTitle = msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    //Set the fit size (fill in the screen size of the device in the design) If the design is based on the size of the 360*690(dp)
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: const Size(360, 690),
        orientation: Orientation.portrait);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -(MediaQuery.of(context).size.width * 0.1),
            left: -(MediaQuery.of(context).size.width * 0.2),
            child: AnimatedContainer(
              height: heightC1,
              width: widthC1,
              duration: _myDuration,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [
                      Color(0xFF30BDD1),
                      Color(0xFF0FD0CD),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.only(
                  topRight:
                      Radius.circular(MediaQuery.of(context).size.width * 0.25),
                  topLeft:
                      Radius.circular(MediaQuery.of(context).size.width * 0.4),
                  bottomRight:
                      Radius.circular(MediaQuery.of(context).size.width * 0.4),
                  bottomLeft:
                      Radius.circular(MediaQuery.of(context).size.width * 0.3),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -(MediaQuery.of(context).size.width * 0.1),
            right: -(MediaQuery.of(context).size.width * 0.2),
            child: AnimatedContainer(
              height: heightC2,
              width: widthC2,
              duration: _myDuration,
              decoration: BoxDecoration(
                // color: _myValue,
                gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFFC137),
                      Color(0xFFFF8C31),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        MediaQuery.of(context).size.width * 0.7),
                    topRight: Radius.circular(
                        MediaQuery.of(context).size.width * 0.3),
                    bottomLeft: Radius.circular(
                        MediaQuery.of(context).size.width * 0.1),
                    bottomRight: Radius.circular(
                        MediaQuery.of(context).size.width * 0.3)),
              ),
            ),
          ),
          // FadeIn
          Positioned.fill(
              child: FadeTransition(
            opacity: _animation,
            child: Align(
                alignment: Alignment.center,
                child: Image.asset(logoImage, height: 84.w, width: 84.w)),
          ))
        ],
      ),
    );
  }


  Future<bool> _synData() async {
    bool dataSynced = await SharedPreferenceUtil.getBoolValuesSF(SYNCED_KEY);
    Logger().e(dataSynced.toString());
    if (!dataSynced) {
      await Future.wait([

        // For getting countries
        ApiService.syncCountriesCall().then((
            CountriesSyncResponse response) {
          if (response.status!) {
            Logger().e("Countries Sync got successfully : " +
                response.toString());
            AppDbInstance().getDbInstance().then((value) async {
              await Future.wait([
                value.countriesDao
                    .insertAllCountry(response.data!.countries),
              ]);
            });
          }
        })


      ]);
    }

    return true;
  }

}
