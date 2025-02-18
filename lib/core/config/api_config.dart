class ApiConfig {
  static const String baseUrl =
      'http://10.0.2.2:8000/api'; // Replace with your API URL

  // API Endpoints
  static const String login = '/login';
  static const String contact = '/contacts';
  static const String contactSearch = '/searchContacts';
  static const String user = '/user';
  static const String visibility = '/user/update-visibility';
  static const String spamProtect = '/user/update-spam-protection';

  // API Timeouts
  static const int connectTimeout = 3000;
  static const int receiveTimeout = 3000;

  // API Headers
  static Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
}
