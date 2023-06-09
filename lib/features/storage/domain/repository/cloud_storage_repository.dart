


import 'dart:io';

abstract class CloudStorageRepository{
  Future<String> uploadProfileImage({required File file});
  Future<String> uploadGroupImage({required File file});
}