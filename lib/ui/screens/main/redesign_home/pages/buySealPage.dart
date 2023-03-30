import 'dart:io';

import 'package:fl_egypt_trust/ui/screens/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class BuySealPage extends StatefulWidget {
  const BuySealPage({Key? key}) : super(key: key);

  @override
  State<BuySealPage> createState() => _BuySealPageState();
}

class _BuySealPageState extends State<BuySealPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    call();
  }

  String valFromNative='';

  Future<void> call() async {
    const channel = MethodChannel('com.example.native_method_channel');


    await channel.invokeMethod('onCreate1').then((value) {
      print("value form b=native is ${value.toString()}");

      setState(() {
        valFromNative =value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context).call(),
      body: Container(
        child: Center(
          child: Text(valFromNative,style: Theme.of(context).textTheme.bodyMedium,),
        ),
      ),
    );
  }

  Future<File> getFileFromSDCard(String fileName) async {
    final directory = await getExternalStorageDirectory();
    final filePath = '${directory!.path}/$fileName';
    return File(filePath);
  }

  Future<String> readFileFromSDCard(String fileName) async {
    try {
      final file = await getFileFromSDCard(fileName);
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return '';
    }
  }
}
