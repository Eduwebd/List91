import 'package:flutter/material.dart';
import 'package:psxmpc/ui/vendor_ui/dashboard/components/bottom_nav/bottom_navigation_bar.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share/share.dart';

class Subscription extends StatefulWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  get updateSelectedIndexWithAnimation => updateSelectedIndexWithAnimation;

  @override
  void initState() {
    super.initState();
    _initDynamicLinks();
  }

  Future<void> _initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink;

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      // Handle the deep link here, such as navigating to a specific page
    }
  }

  Future<void> _generateDynamicLink() async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'YOUR_DYNAMIC_LINK_DOMAIN',
      link: Uri.parse('YOUR_DEEP_LINK_URL'),
      androidParameters: AndroidParameters(
        packageName: 'YOUR_ANDROID_PACKAGE_NAME',
      ),
      // Other parameters such as iOSParameters can be added here
    );

    // final String shortUrl = (await parameters.buildShortLink()).shortUrl.toString();

    // Share the dynamic link
    Share.share('Check out this link: ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Color.fromARGB(255, 217, 140, 175),
        title: Center(
          child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // Adjust the depth of the text
                ..rotateX(0.1), // Adjust the angle of rotation on the X-axis
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNaviationWidget(
                              currentIndex: 2,
                              updateSelectedIndexWithAnimation:
                                  updateSelectedIndexWithAnimation)));
                },
                child: const Text(
                  "Subscription",
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        color: Colors.white,
                        blurRadius: 1.0,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              )),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Container(
            height: 480,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.green,
                  offset: const Offset(6.2, 6.0),
                  blurRadius: 0.4,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Container(
                  height: 64,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 60,
                          width: 300,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 300,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Prime',
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                  color: Colors
                                      .black, // Choose the color of the shadow
                                  blurRadius:
                                      1.0, // Adjust the blur radius for the shadow effect
                                  offset: Offset(2.0,
                                      2.0), // Set the horizontal and vertical offset for the shadow
                                ),
                              ],
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          left: 30,
                          bottom: 10,
                          top: 10,
                          child: Image.asset(
                              "assets/images/WhatsApp Image 2024-04-17 at 19.53.23.jpeg"))
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 64,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 60,
                          width: 300,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 300,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Startup',
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                  color: Colors
                                      .black, // Choose the color of the shadow
                                  blurRadius:
                                      1.0, // Adjust the blur radius for the shadow effect
                                  offset: Offset(2.0,
                                      2.0), // Set the horizontal and vertical offset for the shadow
                                ),
                              ],
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          left: 30,
                          bottom: 10,
                          top: 10,
                          child: Image.asset(
                              "assets/images/WhatsApp Image 2024-04-17 at 19.53.23.jpeg"))
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 64,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 60,
                          width: 300,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 300,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Start',
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                  color: Colors
                                      .black, // Choose the color of the shadow
                                  blurRadius:
                                      1.0, // Adjust the blur radius for the shadow effect
                                  offset: Offset(2.0,
                                      2.0), // Set the horizontal and vertical offset for the shadow
                                ),
                              ],
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          left: 30,
                          bottom: 10,
                          top: 10,
                          child: Image.asset(
                              "assets/images/WhatsApp Image 2024-04-17 at 19.53.23.jpeg"))
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 64,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 60,
                          width: 300,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 300,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Pro',
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                  color: Colors
                                      .black, // Choose the color of the shadow
                                  blurRadius:
                                      1.0, // Adjust the blur radius for the shadow effect
                                  offset: Offset(2.0,
                                      2.0), // Set the horizontal and vertical offset for the shadow
                                ),
                              ],
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          left: 30,
                          bottom: 10,
                          top: 10,
                          child: Image.asset(
                              "assets/images/WhatsApp Image 2024-04-17 at 19.53.23.jpeg")),
                    ],
                  ),
                ),
SizedBox(
  height: 10,
),
                  ElevatedButton(
                            onPressed: _generateDynamicLink,
                            child: const Text('Share Link'),
                          )
              ],
            ),
          ),
          
        ),
        
      ),
    );
  }
}
