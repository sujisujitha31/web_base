import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
// import 'package:neovault_admin/utils.dart' as u;
import 'package:dio/dio.dart' as d;
import 'package:http_parser/http_parser.dart';
import 'utils.dart' as u;

browseAndDoPlatformRelatedChanges(List<String> acceptableExtension,
    Function(d.FormData formdata) callBack) async {
  Uint8List? bytes;
  String? fileName;
  String? extension;
  if (kIsWeb) {
    PlatformFile? browsedFile = await browseFileFromWeb();
    if (browsedFile != null) {
      fileName = browsedFile.name;
      bytes = browsedFile.bytes;
      extension = browsedFile.extension;
    }
  } else {
    // TODO: here i have to write android related code while
    //browsing file from android device
// -----------------------------------------------------
    // XFile? browsedFile = await browseFileFromAndroid();

    // if (browsedFile != null) {
    //   fileName = browsedFile.path.split('/').last;
    //   extension = fileName.split(".").last;
    //   bytes = await browsedFile.readAsBytes();
    // }
  }
  if (bytes != null) {
    // print("byte is $bytes");
    print("extension is $extension");

    if (acceptableExtension.contains(extension)) {
      // Get.defaultDialog(
      //     title: "Make sure this is right presription.",
      //     content: Image.memory(
      //       bytes,
      //       height: 300,
      //       width: 250,
      //     ),
      //     actions: [
      //       ElevatedButton(
      //           onPressed: () {
      //             // getFormData(bytes!, fileName!, app, extension!);
      //           },
      //           child: const u.PoppinsText(
      //             text: "Confirm",
      //           ))
      //     ]);
      getFormData(bytes, fileName!, extension!, (d.FormData data) {
        callBack(data);
      });
    } else {
      u.showToastText("Format did not match");
    }
  }
  return null;
}

Future<PlatformFile?> browseFileFromWeb() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null) {
    PlatformFile file = result.files.first;
    print("file going to be returned");
    return file;
  }
  return null;
}

getFormData(Uint8List bytes, String fileName, String extension,
    Function(d.FormData) callBack) {
  print("file name is $fileName");
  print("extension is $extension");
  d.FormData formData = d.FormData.fromMap({
    "type": "product",
    "file_to_upload": [
      d.MultipartFile.fromBytes(
        bytes,
        filename: fileName,
        contentType: extension.trim() == "pdf"
            ? MediaType('application', 'pdf')
            : (extension.trim() == "jpg" || extension.trim() == "png"
                ? MediaType('image', extension.trim())
                : MediaType("video", "mp4")),
      ),
    ]
  });
  print("form data going to be returned");
  callBack(formData);
}
