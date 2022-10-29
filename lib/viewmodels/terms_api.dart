import 'dart:convert';
import 'dart:math';
import 'package:wortschatz/view/terms_view.dart';
import 'package:flutter/services.dart';

class TermsAPI {
  int? id;
  String? type;
  String? content;

  TermsAPI({
    this.id,
    this.type,
    this.content
  });

  TermsAPI.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    type = json['type'];
    content = json['content'];
  }
}

