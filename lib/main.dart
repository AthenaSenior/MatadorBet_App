import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

bool hasNetwork = false;

 void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
     SystemUiOverlay.bottom,
   ]);
  runApp(MyApp());
  }

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StartState();
  }
}

class StartState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }
  static const String oneSignalAppID = 'ff5ab3fc-ea74-4df1-b404-dc621b572ec4';

  Future<void> initPlatformState() async{
    OneSignal.shared.setAppId(oneSignalAppID);
  }

  void checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        hasNetwork = false;
      });
    } else {
      setState(() {
        hasNetwork = true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    checkConnectivity();
    if (hasNetwork) {
       startTime();
      return Scaffold(
        body: Center(child:

        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/arkaplann.jpg"),
                fit: BoxFit.cover),
          ),
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 125),
              Center(child: Image.asset("images/mobil-logo.png")
              ),
              const Center(
                  child: Text("for iOS", style: TextStyle(color: Colors.white))
              ),
              const SizedBox(height: 50),
              Center(
                child: Visibility(
                  child: SizedBox(height: 100, width: 100,
                      child: Image.asset("images/Loading.gif")
                  ),
                ),
              ),

              // ),
              const SizedBox(height: 50),

// ------  To be continued -- AthenaApps ---------
            ],
          ),
        ),
        ),
      );
    }
    else {
      return Scaffold(
        body: Center(child:

        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/arkaplann.jpg"),
                fit: BoxFit.cover),
          ),
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 125),
              Center(child: Image.asset("images/mobil-logo.png")
              ),
              const Center(
                  child: Text("for iOS", style: TextStyle(color: Colors.white))
              ),
              const SizedBox(height: 50),
              const Center(
                child: Visibility(
                    child: Text(
                        "Internet bağlantısı yok. Bağlantı sağlayıp devam edin.",
                        style: TextStyle(color: Colors.red))
                ),
              ),
              // ),
              const SizedBox(height: 50),

// ------  To be continued -- AthenaApps ---------
            ],
          ),
        ),
        ),
      );
    }
  }

  startTime() async {
    var duration = const Duration(seconds: 6);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => SecondView()
    )
    );
  }



}


/********* MATADORBET SCREEN ***************/
/// ** Separate the classes. **********/



class SecondView extends StatelessWidget {
  late WebViewController _controll;


  void checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
        hasNetwork = false;
    } else {
        hasNetwork = true;
    }
  }


  @override
  Widget build(BuildContext context) {
    checkConnectivity();
    if (hasNetwork) {
      return Scaffold(
        body: Center(child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Expanded(
              child: SizedBox(
                width: double.infinity, height: double.infinity,
                child: Visibility(
                  child: WillPopScope(
                    onWillPop: () async {
                      if (await _controll.canGoBack()) {
                        _controll.goBack();
                      }
                      return Future.value(false);
                    },
                    child: WebView(
                      javascriptMode: JavascriptMode.unrestricted,
                      initialUrl: 'https://rebrand.ly/matadorgiris',
                      zoomEnabled: false,
                      onWebViewCreated: ( webViewController) {
                        _controll=webViewController;
                      },
                ),
                    ),
                ),
              ),
            ),

// ------  To be continued -- AthenaApps ---------
          ],
        ),
        ),
      );
    }
    else {
      return Scaffold(
        body: Center(child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Expanded(
              child: SizedBox(
                width: double.infinity, height: double.infinity,

                child:

                Center(
                    child: Text("Internet bağlantısı sağlayıp tekrar deneyin.", style: TextStyle(color: Colors.black)),
                ),
              ),
            ),
// ------  To be continued -- AthenaApps ---------
          ],
        ),
        ),
      );

    }

  }
}



