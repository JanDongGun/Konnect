import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class CloudStorageService {
  static CloudStorageService instance = CloudStorageService();

  FirebaseStorage _storage;
  Reference _baseRef;

  String _profileImages = "profile_images";
  String _messages = "messages";
  String _images = "images";

  CloudStorageService() {
    _storage = FirebaseStorage.instance;
    _baseRef = _storage.ref();
  }

  Future<TaskSnapshot> uploadUserImage(String _uid, File _image) {
    try {
      return _baseRef.child(_profileImages).child(_uid).putFile(_image);
    } catch (e) {
      print(e);
    }
  }

  Future<TaskSnapshot> uploadMediaMessage(String _uid, File _file) {
    var _timestamp = DateTime.now();
    var _filename = basename(_file.path);
    _filename += "_${_timestamp.toString()}";
    try {
      return _baseRef
          .child(_messages)
          .child(_uid)
          .child(_images)
          .child(_filename)
          .putFile(_file);
    } catch (e) {
      print(e);
    }
  }
}
