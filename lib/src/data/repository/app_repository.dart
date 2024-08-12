import 'dart:io';

import '../entity/category_model.dart';

abstract class AppRepository {

  Future<void>createCategory({required String name, required int categoryType});

  Future<CategoryData?>getAllCategories();
  Future<void> deleteCategory(int categoryId)async {}
  Future<void> editCategory({required int categoryId, required String name, required int categoryType})async {}

  Future<void> createExpense({required String date, required double amount, required int type, required int categoryId})async {}

  Future<void> uploadProfileImage(File image);

}


