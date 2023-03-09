import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

void dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

// TODO clear (extern) when sharing, also include the Othia logo in the share message
void openShare(String shareString, BuildContext context) async {
  urlFileShare(context);
  // await Share.shareXFiles(['/yourPath/myItem.png'], text: 'Image Shared');
  Share.share(shareString);
}

void closeSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
}

Future<Null> urlFileShare(context) async {
  final RenderBox box = context.findRenderObject();
  if (Platform.isAndroid) {
    // final documentDirectory = (await getExternalStorageDirectory())!.path;
    //   final byteData = await rootBundle.load('assets/images/othia_logo.png');

    final file =
        XFile('${(await getTemporaryDirectory()).path}/images/othia_logo.png');
    // await file.(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    print('file.name ${file.path}');
    List<XFile> asd = [file];
    await Share.shareXFiles(asd,
        subject: 'URL File Share',
        text: 'Hello, check your share files!',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  } else {
    Share.share('Hello, check your share files!',
        subject: 'URL File Share',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
