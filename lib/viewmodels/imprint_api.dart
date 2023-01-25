import 'dart:convert';
import 'dart:math';
import 'package:wortschatz/view/terms_view.dart';
import 'package:flutter/services.dart';

class ImprintAPI {
  int? id;
  String? type;
  String? content;

  ImprintAPI({
    this.id,
    this.type,
    this.content
  });

  ImprintAPI.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    type = json['type'];
    content = json['content'];
  }
}

