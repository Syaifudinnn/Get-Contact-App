class ApiConfig {
  static const String baseUrl =
      'http://10.0.2.2:8000/api'; // Replace with your API URL

  // API Endpoints
  static const String login = '/login';

  // API Timeouts
  static const int connectTimeout = 3000;
  static const int receiveTimeout = 3000; 

  // API Headers
  static Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
}
