import 'dart:convert';
import 'dart:io';

import 'package:fl_egypt_trust/main.dart';
import 'package:fl_egypt_trust/models/utils/language/localizations_delegate.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';
part 'document_model.g.dart';

@JsonSerializable()
class DocumentModel {

  @JsonKey(name: 'ORDName')
  String? oRDName;
  @JsonKey(name: 'ORDBase64Doc')
  String? oRDBase64Doc;


  String? filePath;

  String? error;

  bool isImage = false;


  DocumentModel({
      this.oRDName,
      this.oRDBase64Doc,});

  factory DocumentModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentModelFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentModelToJson(this);



  Future<bool> isValidDoc()async{
    error = null;
    if(oRDBase64Doc == null || oRDBase64Doc?.isEmpty == true){
      error = appLocalization.errorUploadDocumentImage;
      return false;
    }else {

      File ff = File(filePath ?? '');
      int fileSize = await ff.length();
      logger.e('file length : $fileSize');
      if(fileSize > _maxFileSize){
        error = appLocalization.errorDocumentSize;
        return false;
      }
    }

    if(oRDName == null || oRDName?.isEmpty == true){
      error = appLocalization.documentNameRequired;
      return false;
    }

    return true;
  }
}


const int _maxFileSize = 10 * 1024 * 1024;