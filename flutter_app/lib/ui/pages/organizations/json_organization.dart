import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/organization_model.dart';
import 'package:http/http.dart' as http;


  Future<List<Organization>> getOrganizations() async {
  final List<Organization> organizations = [];
    try {
      final response = await http.get(Uri.parse('http://158.160.153.243:8000/organization/get-organizations'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print('Total Items: ${jsonData.length}');

        for (var itemData in jsonData) {
          String? id = itemData['id'] as String?;
        List<String>? countries;
        if (itemData.containsKey('countries') && itemData['countries']!= null) {
          var dynamicTags = itemData['countries'];
          countries = (dynamicTags as List<dynamic>).map((country) => country.toString()).toList();
        } else {
          countries = [];
        } 
        print('countries: ${countries}');

        List<String>? categories;
        if (itemData.containsKey('categories') && itemData['categories']!= null) {
          var dynamicTags = itemData['categories'];
          categories = (dynamicTags as List<dynamic>).map((category) => category.toString()).toList();
        } else {
          categories = [];
        } 

          String? name = itemData['name'] as String?;
          Uri link = Uri.parse(itemData["link"]);
          String? description = itemData['description'] as String?;
          NetworkImage? logo = itemData['logo'] != null ? NetworkImage(itemData['logo']) : null;

          organizations.add(Organization(
            id: id,
            name: name,
            link: link,
            description: description,
            logo: logo,
            countries: countries,
            categories: categories,
          ));
        }
        print('organizations: ${organizations}');
        return organizations.toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Null data');
    }
  }


Future<List<String>> getCategories() async {
  final List<String> categories = [];
    try {
      final response = await http.get(Uri.parse('http://158.160.153.243:8000/utility/get-categories'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        for (var itemData in jsonData) {
          String? name = itemData as String?;
          categories.add(name!);
        }
        return categories.toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Null data'); 
    }
}

Future<List<String>> getCountries() async {
  final List<String> countries = [];
    try {
      final response = await http.get(Uri.parse('http://158.160.153.243:8000/utility/get-countries'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        for (var itemData in jsonData) {
          String? name = itemData as String?;
          countries.add(name!);
        }
        return countries.toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Null data'); 
    }
}