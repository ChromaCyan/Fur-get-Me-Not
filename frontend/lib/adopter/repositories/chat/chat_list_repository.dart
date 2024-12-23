import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fur_get_me_not/adopter/models/chat/chat.dart';
import 'package:fur_get_me_not/adopter/models/chat/chat_list.dart';

class AdopterChatRepository {
  final String baseUrl = 'http://192.168.18.235:5000';
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<String?> getToken() async {
    return await storage.read(key: 'jwt');
  }

  // Fetch chat list for the adopter
  Future<List<AdopterChatList>> fetchAdopterChatList() async {
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
            .map((data) => AdopterChatList.fromJson(data))
            .toList();
      } else {
        throw Exception('Failed to load chat list: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error fetching chat list: $error');
      throw Exception('Error fetching chat list');
    }
  }

  // Fetch messages for a specific chat
  Future<List<AdopterChatMessage>> fetchMessagesForUser(
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

      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((data) => AdopterChatMessage.fromJson(data))
            .toList();
      } else {
        throw Exception('Failed to load messages: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error fetching messages: $error');
      throw Exception('Error fetching messages');
    }
  }

  Future<String> sendMessage(String content, String otherUserId) async {
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

      if (response.statusCode != 200) {
        throw Exception('Failed to send message: ${response.reasonPhrase}');
      }

      final Map<String, dynamic> responseData = json.decode(response.body);

      // Ensure the response contains the chatId
      if (responseData['chatId'] == null) {
        throw Exception('No chat ID returned from the server');
      }

      return responseData['chatId'];
    } catch (error) {
      print('Error sending message: $error');
      throw Exception('Error sending message');
    }
  }
}
