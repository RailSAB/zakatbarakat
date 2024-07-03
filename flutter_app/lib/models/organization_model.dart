import 'package:flutter/material.dart';

class Organization{
  final String? id;
  final String? name;
  final Uri link;
  final String? description;
  final NetworkImage? logo;
  final List<String>? categories;
  final List<String>? countries;

  Organization({
    this.id,
    this.name,
    required this.link,
    this.description,
    this.logo,
    this.categories,
    this.countries,
  });
}