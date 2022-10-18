import 'dart:io';

class MediaUpload {
  List<int> pictureBytes;
  String fileName;
  String mediaType;
  File  file;
  MediaUpload(this.pictureBytes, this.fileName, this.mediaType, this.file);
}