import 'dart:convert';
import 'package:http/http.dart';
import 'package:nyobadoang/entity/user.dart'; // Import the User class
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

class UserClient {
  static final String url = '10.0.2.2:8000'; // Change to your API URL
  static final String endpoint = '/api/users'; // Adjust endpoint if necessary

  // Method for user login
  static Future<bool> login(String email, String password) async {
    try {
      var response = await post(
        Uri.http(url, '$endpoint/login'), // Adjust endpoint for login
        headers: {"Content-Type": "application/json"},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        // Save email to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userEmail', email);
        return true; // Login successful
      } else {
        return false; // Login failed
      }
    } catch (e) {
      print("Login error: $e"); // Log error for debugging
      return false; // Handle error
    }
  }

  // Method to create a user
  static Future<bool> create(User user) async {
    try {
      var response = await post(
        Uri.http(url, endpoint),
        headers: {"Content-Type": "application/json"},
        body: user.toRawJson(),
      );

      return response.statusCode == 201; // HTTP 201 Created
    } catch (e) {
      print("Create user error: $e"); // Log error for debugging
      return false; // Handle error
    }
  }

  // Method to fetch the current user data from API
  static Future<User?> fetchUser() async {
    try {
      // Fetch user email from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('userEmail');

      if (email == null) {
        print("No user email found in SharedPreferences.");
        return null;
      }

      var response = await get(
        Uri.http(url, '$endpoint/email/$email'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        // Parse user data
        var jsonData = json.decode(response.body);
        return User.fromJson(jsonData); // Assuming your User class has a fromJson method
      } else {
        print("Failed to fetch user. Status Code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Fetch user error: $e");
      return null;
    }
  }

  // Method to get the user data (reused fetchUser)
  static Future<User?> getUserData() async {
    try {
      // Fetch user data via fetchUser
      User? user = await fetchUser();
      if (user != null) {
        print("User data fetched successfully");
        return user;  // Return user data if successful
      } else {
        print("No user data found");
        return null;  // Return null if no data found
      }
    } catch (e) {
      print("Error in getting user data: $e");
      return null;  // Return null in case of an error
    }
  }
}
