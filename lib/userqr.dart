import 'dart:io';
import 'dart:ui';

import 'package:flutter/rendering.dart';

import 'userdetails.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

/*void main() {
  runApp(DownloadQRExample();
}*/

class DownloadQRExample extends StatefulWidget {
  final String qrData;
  DownloadQRExample({required this.qrData});

  static String id = 'downloadqr';
  @override
  _DownloadQRExampleState createState() => _DownloadQRExampleState();
}

class _DownloadQRExampleState extends State<DownloadQRExample> {
  String _qrData = '';
  GlobalKey _qrKey = GlobalKey();
  @override
  void initState() {
    super.initState();

    // Get the data passed from the previous page
    final route = ModalRoute.of(context);
    if (route != null) {
      _qrData = route.settings.arguments as String;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download QR Example'),
      ),
      body: Center(
        child: RepaintBoundary(
          key: _qrKey,
          child: QrImage(
            data: _qrData,
            version: QrVersions.auto,
            size: 200.0,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _downloadQR();
        },
        child: Icon(Icons.file_download),
      ),
    );
  }

  Future<void> _downloadQR() async {
    // Get documents directory
    final directory = await getApplicationDocumentsDirectory();

    // Generate QR code as image data
    final imageData = await _getQRImageData();

    // Save image data to file
    final file = await File('${directory.path}/qr.png').create();
    await file.writeAsBytes(imageData);

    // Show a snackbar to indicate that the QR code was saved
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('QR code saved to documents directory'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<Uint8List> _getQRImageData() async {
    // Get the RenderRepaintBoundary widget
    final boundary =
        _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    // Render QR code to image data
    final image = await boundary.toImage(pixelRatio: 2.0);
    final imageData = await image.toByteData(format: ImageByteFormat.png);

    return imageData!.buffer.asUint8List();
  }
}
