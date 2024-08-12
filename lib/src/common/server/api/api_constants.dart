class ApiConst {
  static const connectionTimeout = 20000;
  static const sendTimeout = 20000;

  static const baseUrl = 'https://online.atomic.uz/';
  static const version = '';

  // Courses api
  static const login = '/api/login';
  static const register = '/api/register';
  static const createCategory = "/api/categories";
  static const getAllCategories = "/api/categories";
  static const createExpense = "/api/transactions";
  static const getAllExpenses = "/api/transactions";
  static const editCategory = "/api/categories";
  static const deleteCategory = "/api/categories";
  static const uploadAvatar = "/api/avatar";

}

class ApiParams {
  const ApiParams._();

  static Map<String, dynamic> emptyParams() => <String, dynamic>{};
}
