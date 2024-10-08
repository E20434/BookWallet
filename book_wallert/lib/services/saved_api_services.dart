import 'package:book_wallert/ipaddress.dart';
import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SavedService {
  final int userId;

  SavedService(this.userId);

  Future<List<BookModel>> fetchBooks() async {
    final response = await http.get(
      Uri.parse('${ip}/api/saved-items/books/$userId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // Convert JSON data to List<BookModel>
      return data.map((item) => BookModel.fromJson(item['book'])).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<List<ReviewModel>> fetchReviews() async {
    final response = await http.get(
      Uri.parse('${ip}/api/saved-items/reviews/$userId'),
    );

    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // Convert JSON data to List<ReviewModel>
      return data.map((item) => ReviewModel.fromJson(item['post'])).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  Future<List<User>> fetchUsers() async {
    final response = await http.get(
      Uri.parse('${ip}/api/saved-items/profiles/$userId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // Convert JSON data to List<User>
      return data.map((item) => User.fromJson(item['userDetails'])).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> insertReviewToSaved(String? token, int reviewId) async {
    final url = Uri.parse('${ip}/api/saved-items/save/review');
    final body = json.encode({
      'token': token,
      'relevant_id': reviewId,
    });
    print(111);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json'
        }, // Set the Content-Type header
        body: body,
      );

      if (response.statusCode == 200) {
        print(' Review Saved successfully');
      } else {
        print('Failed to insert Saved: ${response.body}');
      }
    } catch (e) {
      print('Error inserting Saved: $e');
    }
  }

  Future<void> insertBookToSaved(String? token, int bookId) async {
    final url = Uri.parse('${ip}/api/saved-items/save/book');
    final body = json.encode({
      'token': token,
      'relevant_id': bookId,
    });
    print(token);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json'
        }, // Set the Content-Type header
        body: body,
      );

      if (response.statusCode == 200) {
        print('Book saved successfully');
      } else {
        print('Failed to insert Saved: ${response.body}');
      }
    } catch (e) {
      print('Error inserting Saved: $e');
    }
  }

  Future<void> insertProfileToSaved(String token, int userId) async {
    final url = Uri.parse('${ip}/api/saved-items/save/profile');
    final body = json.encode({
      'token': token,
      'relevant_id': userId,
    });

    print(token);
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        print('profile saved successfully');
      } else {
        print('Failed to save user profile: ${response.body}');
      }
    } catch (e) {
      print('Error saving user profile: $e');
    }
  }
}
