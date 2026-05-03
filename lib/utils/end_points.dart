class ApiEndpoints {
  static const baseUrl = "https://authapi-production-2216.up.railway.app";
  static const signup = "$baseUrl/api/v1/auth/signup";
  static const login = "$baseUrl/api/v1/auth/login";
  static const otpVerify = "$baseUrl/api/v1/auth/login/verify-otp";
  static const createItem = "$baseUrl/api/v1/items";
  static const getItem = "$baseUrl/api/v1/items";
  // static const deleteItem = "$baseUrl/api/v1/items/{{itemId}}";
}