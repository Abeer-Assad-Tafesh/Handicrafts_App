import 'dart:convert';
import 'dart:io';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:handcrafts/screens/buyer/home/sub_home/product_details_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
class DynamicLinksService {
  static FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  static Future<String> createDynamicLink(int id, int type,
      {String image = ""}) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://handcraftsapp.page.link',
        link: Uri.parse('https://handcraftsapp.page.link/?id=$id&type=$type'),
        androidParameters: const AndroidParameters(
          packageName: "com.example.handcrafts",
          minimumVersion: 0,
        ),
        iosParameters: const IOSParameters(
          bundleId: 'com.example.handcrafts',
          minimumVersion: '0',
        ),
        socialMetaTagParameters: SocialMetaTagParameters(
            title: '',
            // description: event.post?.excerpt,
            imageUrl: Uri.parse(image)),
        navigationInfoParameters: const NavigationInfoParameters(forcedRedirectEnabled: true));
    final ShortDynamicLink shortLink =
    await dynamicLinks.buildShortLink(parameters);
    return shortLink.shortUrl.toString();
  }

  static Future<void> shareData(
      BuildContext context, String imageUrl, String subject) async {
    final bytes = await _getImageBytes(imageUrl);
    final box = context.findRenderObject() as RenderBox?;
    Share.shareFiles([(_getTemporaryImagePath(bytes))], text: subject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  static handleDeepLink(PendingDynamicLinkData dynamicLinkData) {
    PendingDynamicLinkData data = dynamicLinkData;
    Uri deepLink = data.link;
    if (deepLink.queryParameters.containsKey('type')) {
      var propertyType = deepLink.queryParameters['type'];
      int type = int.parse("$propertyType");
      var propertyId = deepLink.queryParameters['id']!;
      int id = int.parse(propertyId);
      switch (type) {
        case 0:
          {
            Get.to(() => ProductDetailsScreen(productId: id,));
            break;
          }
      }
    }
  }

  Future initDynamicLinks(dynamicLinkData) async {
    if (dynamicLinkData != null) {
      handleDeepLink(dynamicLinkData);
    }
  }



  static String _getTemporaryImagePath(Uint8List bytes) {
    // Save the image bytes to a temporary file
    final tempDir = Directory.systemTemp;
    final tempFile = File('${tempDir.path}/shared_image.png');
    tempFile.writeAsBytesSync(bytes);
    return tempFile.path;
  }
  static Future<Uint8List> _getImageBytes(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image from network: $imageUrl');
    }
  }
}
