class ApiConfig {
  static const String baseUrl =
      'http://127.0.0.1:8000/api/'; // Replace with your API URL

  // API Endpoints
  static const String login = '/login';

  // API Timeouts
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds

  // API Headers
  static Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
}
