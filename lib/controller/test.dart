import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleDrivePlatformChannel {
  // Remove the `extends PlatformChannel` clause.
  GoogleDrivePlatformChannel();

  Future<String> uploadFile(String filePath) async {
    final result = await const MethodChannel('google_drive_channel')
        .invokeMethod<String>('uploadFile', {'filePath': filePath});
    return result ?? '';
  }

  // Future<List<String>> listVideos() async {

  //   final result = await const MethodChannel('google_drive_channel')
  //       .invokeMethod<List<String>>('listVideos');
  //   return result ?? [];
  // }

  Future<String> downloadFile(String filePath) async {
    final result = await const MethodChannel('google_drive_channel')
        .invokeMethod<String>('downloadFile', {'filePath': filePath});
    return result ?? '';
  }

  Future<List<String>?> listVideos() async {
    // Sign in to Google Drive.
    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signIn();
      final accessToken =
          (await googleSignIn.currentUser!.authHeaders)['Authorization']!;

      // Make a request to the Google Drive API to list the videos.
      final response = await Dio().get(
        'https://www.googleapis.com/drive/v3/files?q="mimeType=\'video/mp4\'"',
        options: Options(
          headers: {
            'Authorization': accessToken,
          },
        ),
      );

      // Parse the response and extract the video URLs.
      final jsonResponse = jsonDecode(response.data) as Map<String, dynamic>;
      final videoUrls = jsonResponse['files'] as List<dynamic>;
      return videoUrls.map((file) => file['id'] as String).toList();
    } catch (e) {
      log(e.toString());
    }
  }
}
