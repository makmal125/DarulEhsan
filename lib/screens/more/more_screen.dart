import 'dart:io';

import 'package:darulehsan/screens/more/duain/duain_main_screen.dart';
import 'package:darulehsan/screens/more/gallery/gallery_screen.dart';
import 'package:darulehsan/screens/more/taqwim/taqwim_pages_view.dart';
import 'package:darulehsan/utilities/keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: depend_on_referenced_packages
import 'package:yaml/yaml.dart';

class MoreMainScreen extends StatefulWidget {
  const MoreMainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MoreMainScreen();
}

class _MoreMainScreen extends State<MoreMainScreen> {
  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    initPackageInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
  }

  Future<void> openWhatsapp(
      {required BuildContext context,
      required String text,
      required String number}) async {
    var whatsapp = number; //+92xx enter like this
    var whatsappURlAndroid = "whatsapp://send?phone=$whatsapp&text=$text";
    var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(Uri.parse(
          whatsappURLIos,
        ));
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    }
  }

  Future<void> makePhoneCall(
      {required BuildContext context, required String number}) async {
    var phoneURlAndroid = "tel:$number";
    var phoneURLIos = "tel://$number";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(phoneURLIos))) {
        await launchUrl(Uri.parse(
          phoneURLIos,
        ));
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Phone not installed")));
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(phoneURlAndroid))) {
        await launchUrl(Uri.parse(phoneURlAndroid));
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Phone not installed")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('مزید'),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(2, 67, 4, 1),
          // actions: const [
          //   // ElevatedButton(
          //   //   onPressed:() => googleSignin(),
          //   //   style: ElevatedButton.styleFrom(
          //   //     shape: const CircleBorder(),
          //   //     padding: const EdgeInsets.all(10),
          //   //     backgroundColor: Colors.green, // <-- Button color
          //   //     foregroundColor: Colors.green, // <-- Splash color
          //   //   ),
          //   //   child: const Icon(FontAwesomeIcons.solidUser, color: Colors.white),
          //   // ),
          // ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            children: [
              // ListTile(
              //   textColor: Colors.black,
              //   iconColor: Colors.green,
              //   leading: const CircleAvatar(
              //     backgroundColor: Color.fromRGBO(2, 67, 4, 1),
              //     radius: 20,
              //     foregroundColor: Color.fromRGBO(2, 67, 4, 1),
              //     child: ImageIcon(
              //       AssetImage("images/praying_hands.png"),
              //       color: Colors.white,
              //       size: 24,
              //     ),
              //   ),
              //   title: const Text(
              //     "مسنون دعائیں",
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //   ),
              //   //subtitle: const Text("روز مرہ کی دعائیں"),
              //   trailing: const Icon(FontAwesomeIcons.circleArrowLeft),
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const DuainMainScreen()));
              //   },
              // ),
              // const Divider(
              //   height: 3,
              //   thickness: 1,
              //   indent: 15,
              //   endIndent: 15,
              //   color: Color.fromRGBO(2, 67, 4, 1),
              // ),
              ListTile(
                textColor: Colors.black,
                iconColor: Colors.green,
                leading: const CircleAvatar(
                  backgroundColor: Color.fromRGBO(2, 67, 4, 1),
                  radius: 20,
                  foregroundColor: Color.fromRGBO(2, 67, 4, 1),
                  child: ImageIcon(
                    AssetImage("images/taqwim_icon.png"),
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                title: const Text(
                  "تقویمِ دارُلاحسان",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                //subtitle: const Text(""),
                trailing: const Icon(Icons.arrow_circle_left_outlined),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TaqwimPageViewScreen()));
                },
              ),
              const Divider(
                height: 3,
                thickness: 1,
                indent: 15,
                endIndent: 15,
                color: Color.fromRGBO(2, 67, 4, 1),
              ),
              ListTile(
                textColor: Colors.black,
                iconColor: Colors.green,
                leading: const CircleAvatar(
                  backgroundColor: Color.fromRGBO(2, 67, 4, 1),
                  radius: 20,
                  foregroundColor: Color.fromRGBO(2, 67, 4, 1),
                  child: Icon(FontAwesomeIcons.images, color: Colors.white),
                ),
                title: const Text(
                  "تصاویر",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                //subtitle: const Text(""),
                trailing: const Icon(Icons.arrow_circle_left_outlined),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GalleryMainScreen()));
                },
              ),
              const Divider(
                height: 3,
                thickness: 1,
                indent: 15,
                endIndent: 15,
                color: Color.fromRGBO(2, 67, 4, 1),
              ),
              ListTile(
                textColor: Colors.black,
                iconColor: Colors.green,
                leading: const CircleAvatar(
                  backgroundColor: Color.fromRGBO(2, 67, 4, 1),
                  radius: 20,
                  foregroundColor: Color.fromRGBO(2, 67, 4, 1),
                  child: Icon(Icons.info, color: Colors.white),
                ),
                title: const Text(
                  "معلومات",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                //subtitle: const Text(""),
                trailing: const Icon(Icons.arrow_circle_up),
                onTap: () => information(context),
              ),
              const Divider(
                height: 3,
                thickness: 1,
                indent: 15,
                endIndent: 15,
                color: Color.fromRGBO(2, 67, 4, 1),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Text('Version: ${packageInfo.version}'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void information(context) async {
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      // color is applied to main screen when modal bottom screen is displayed
      //barrierColor: Colors.greenAccent,
      //background color for modal bottom screen
      backgroundColor: Colors.white,
      //elevates modal bottom screen
      elevation: 10,
      // gives rounded corner to modal bottom screen
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      builder: (BuildContext context) {
        // UDE : SizedBox instead of Container for whitespaces
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Card(
            borderOnForeground: false,
            color: Colors.white24,
            elevation: 10,
            // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            // Set the clip behavior of the card
            clipBehavior: Clip.antiAliasWithSaveLayer,
            // Define the child widgets of the card
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
                  Image.asset(
                    'images/hq720.jpg',
                    height: 260,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.high,
                  ),
                  // Add a container with padding that contains the card's title, text, and buttons
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // Display the card's title using a font size of 24 and a dark grey color
                        Text(
                          "میاں محمد مقصود احمد",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey[800],
                          ),
                        ),
                        // Add a space between the title and the text
                        Container(height: 10),
                        // Display the card's text using a font size of 15 and a light grey color
                        Text(
                          '(صوفی محمد برکت علی قدس سرہ العزیز کے پوتے)',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'والد: ',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'میاں محمد انور',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 50,
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                          color: Color.fromRGBO(2, 67, 4, 1),
                        ),
                        // Add a row with two buttons spaced apart and aligned to the right side of the card
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // Add a spacer to push the buttons to the right side of the card

                            // Add a text button labeled "SHARE" with transparent foreground color and an accent color for the text
                            TextButton(
                              child: const Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Color.fromRGBO(2, 67, 4, 1),
                                    radius: 20,
                                    foregroundColor:
                                        Color.fromRGBO(2, 67, 4, 1),
                                    child:
                                        Icon(Icons.call, color: Colors.white),
                                  ),
                                  Text(
                                    'فون',
                                    style: TextStyle(
                                      color: Color.fromRGBO(2, 67, 4, 1),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                
                                makePhoneCall(
                                    context: context, number: PHONE_NUMBER);
                              },
                            ),
                            // Add a text button labeled "EXPLORE" with transparent foreground color and an accent color for the text
                            TextButton(
                              child: const Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Color.fromRGBO(2, 67, 4, 1),
                                    radius: 20,
                                    foregroundColor:
                                        Color.fromRGBO(2, 67, 4, 1),
                                    child: Icon(FontAwesomeIcons.whatsapp,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'واٹس ایپ',
                                    style: TextStyle(
                                      color: Color.fromRGBO(2, 67, 4, 1),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                
                                openWhatsapp(
                                    context: context,
                                    text: '',
                                    number: WHATSAPP_NUMBER);
                              },
                            ),
                            TextButton(
                              child: const Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Color.fromRGBO(2, 67, 4, 1),
                                    radius: 20,
                                    foregroundColor:
                                        Color.fromRGBO(2, 67, 4, 1),
                                    child: Icon(Icons.location_city_sharp,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'مقام',
                                    style: TextStyle(
                                      color: Color.fromRGBO(2, 67, 4, 1),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                MapsLauncher.launchCoordinates(
                                    31.6690799, 73.2762327, 'دارُلاحسان');
                              },
                            ),
                            TextButton(
                              child: const Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Color.fromRGBO(2, 67, 4, 1),
                                    radius: 20,
                                    foregroundColor:
                                        Color.fromRGBO(2, 67, 4, 1),
                                    child:
                                        Icon(Icons.email, color: Colors.white),
                                  ),
                                  Text(
                                    'ای میل',
                                    style: TextStyle(
                                      color: Color.fromRGBO(2, 67, 4, 1),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                
                                final Uri emailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: EMAIL_ADDRESS);

                                launchUrl(emailLaunchUri);
                              },
                            ),
                            TextButton(
                              child: const Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Color.fromRGBO(2, 67, 4, 1),
                                    radius: 20,
                                    foregroundColor:
                                        Color.fromRGBO(2, 67, 4, 1),
                                    child: Icon(Icons.web, color: Colors.white),
                                  ),
                                  Text(
                                    'ویب',
                                    style: TextStyle(
                                      color: Color.fromRGBO(2, 67, 4, 1),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                
                                makePhoneCall(
                                    context: context, number: WEB_PHONE_NUMBER);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 200,
                        ),
                      ],
                    ),
                  ),
                  // Add a small space between the card and the next widget
                  Container(height: 5),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
