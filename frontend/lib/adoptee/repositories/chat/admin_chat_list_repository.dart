import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fur_get_me_not/adoptee/models/chat/admin_chat.dart';
import 'package:fur_get_me_not/adoptee/models/chat/admin_chat_list.dart';

class AdminChatRepository {
  final String baseUrl = 'http://192.168.115.106:5000';
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<String?> getToken() async {
    return await storage.read(key: 'jwt');
  }

  // Fetch chat list for the admin
  Future<List<AdminChatList>> fetchAdminChatList() async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/chats/chat-list'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((data) => AdminChatList.fromJson(data))
            .toList();
      } else {
        throw Exception('Failed to load chat list: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error fetching chat list: $error');
      throw Exception('Error fetching chat list: $error');
    }
  }

  // Fetch messages for a specific chat
  Future<List<AdminChatMessage>> fetchMessagesForUser(
      String otherUserId) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/messages/$otherUserId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((data) => AdminChatMessage.fromJson(data))
            .toList();
      } else {
        throw Exception('Failed to load messages: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error fetching messages: $error');
      throw Exception('Error fetching messages');
    }
  }

  Future<void> sendMessage(String content, String otherUserId) async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/messages/new-message'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'content': content,
          'otherUserId': otherUserId,
        }),
      );

      print('Response body: ${response.body}');

      if (response.statusCode != 200) {
        // Log additional information for debugging
        print(
            'Failed to send message: ${response.reasonPhrase}, Body: ${response.body}');
        throw Exception('Failed to send message: ${response.reasonPhrase}');
      }

      // Optionally parse the response if needed
      final responseData = json.decode(response.body);
    } catch (error) {
      print('Error sending message: $error');
      throw Exception('Error sending message');
    }
  }
}
