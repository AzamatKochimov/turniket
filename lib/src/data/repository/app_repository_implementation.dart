import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:l/l.dart';

import '../../common/server/api/api.dart';
import '../../common/server/api/api_constants.dart';
import '../entity/category_model.dart';
import '../entity/expense_model.dart';
import 'app_repository.dart';

@immutable
class AppRepositoryImpl implements AppRepository {
  AppRepositoryImpl._internal();

  static final AppRepositoryImpl _instance = AppRepositoryImpl._internal();

  factory AppRepositoryImpl() => _instance;

  @override
  Future<void> createCategory(
      {required String name, required int categoryType}) async {
    try {
      final String? response = await ApiService.post(
        ApiConst.createCategory,
        <String, dynamic>{
          "name": "$name $categoryType",
        },
        params: {},
      );
      if (response != null) {
        l.i("Category created successfully: $response");
      } else {
        l.e("Failed to create category");
      }
    } catch (e) {
      l.e("Error creating category: $e");
    }
  }

  @override
  Future<CategoryData?> getAllCategories() async {
    try {
      final String? response = await ApiService.get(ApiConst.getAllCategories);
      if (response != null) {
        final CategoryData categoryModel = categoryModelFromJson(response);
        l.i("GetAllCategories Response: ${categoryModel.status}"); // Log response
        l.i("GetAllCategories Categories: ${categoryModel.categories}"); // Log response
        return categoryModel;
      } else {
        l.e("Failed to fetch categories");
        return null;
      }
    } catch (e) {
      l.e("Error fetching categories: $e");
      return null;
    }
  }

  @override
  Future<void> createExpense({required String date, required double amount, required int type, required int categoryId}) async {
    try {
      final String? response = await ApiService.post(
        ApiConst.createExpense,
        <String, dynamic>{
          "date": date,
          "amount": amount,
          "type": type,
          "category_id": categoryId,
        },
        params: {},
      );
      if (response != null) {
        l.i("Expense created successfully: $response");
      } else {
        l.e("Failed to create expense");
      }
    } catch (e) {
      l.e("Error creating expense: $e");
    }
  }

  Future<ExpenseModel?> getAllExpenses() async {
    try {
      final String? response = await ApiService.get(ApiConst.getAllExpenses);
      if (response != null) {
        final ExpenseModel expenseModel = ExpenseModel.fromRawJson(response);
        l.i("GetAllExpenses Response: ${expenseModel.status}");
        l.i("GetAllExpenses Transactions: ${expenseModel.transactions}");
        return expenseModel;
      } else {
        l.e("Failed to fetch expenses");
        return null;
      }
    } catch (e) {
      l.e("Error fetching expenses: $e");
      return null;
    }
  }

  @override
  Future<void> deleteCategory(int categoryId) async {
    try {
      final String? response = await ApiService.delete(
          '${ApiConst.deleteCategory}/$categoryId'
      );
      if (response != null) {
        l.i("Category deleted successfully: $response");
      } else {
        l.e("Failed to delete category");
      }
    } catch (e) {
      l.e("Error deleting category: $e");
    }
  }


  @override
  Future<void> editCategory({required int categoryId, required String name, required int categoryType}) async {
    try {
      final String? response = await ApiService.put(
        '${ApiConst.editCategory}/$categoryId',
        <String, dynamic>{
          "name": "$name $categoryType",
        },
      );
      if (response != null) {
        l.i("Category edited successfully: $response");
      } else {
        l.e("Failed to edit category");
      }
    } catch (e) {
      l.e("Error editing category: $e");
    }
  }

  @override
  Future<void> uploadProfileImage(File image) async {
    try {
      await ApiService.multipart(ApiConst.uploadAvatar, [image]);
    } catch (e) {
      // Handle any errors that occur during the upload
      throw Exception('Failed to upload profile image: $e');
    }
  }
}

