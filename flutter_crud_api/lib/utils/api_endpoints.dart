class ApiEndPoints {
  static const String baseUrl =
      'https://flutter-crud-api.free.beeceptor.com/api/users/';

  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = '/register';
  final String loginEmail = '/login';
}
