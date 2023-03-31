import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../widgets/custom_app_bar.dart';
import 'configs_screen.dart';

class QRViewArgs{
  final String?signature;
  QRViewArgs({this.signature});
}


QRViewArgs qrArgs=QRViewArgs();
class QRViewReader extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _QRViewReaderState();
  }

}

class _QRViewReaderState extends State<QRViewReader> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context:context).call(),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              overlay: QrScannerOverlayShape(),
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                  'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if(result!.code!.isNotEmpty){
          qrArgs=QRViewArgs(signature: result!.code);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context)=>const SDConfigsScreen(),), (route) => false);
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}