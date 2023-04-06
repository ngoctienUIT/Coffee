import 'dart:io';

import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/presentation/view_image/screen/view_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

void showMyBottomSheet(BuildContext context, Function(File? image) onPick) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Container(
        height: 350,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            itemAction("take_photo".translate(context), () async {
              Navigator.pop(context);
              var status = await Permission.camera.status;
              if (status.isDenied) {
                await Permission.camera.request();
              }
              status = await Permission.camera.status;
              if (status.isGranted) onPick(await pickAvatar(true));
            }),
            itemAction("select_image_gallery".translate(context), () async {
              Navigator.pop(context);
              var status = await Permission.storage.status;
              if (status.isDenied) {
                await Permission.storage.request();
              }
              status = await Permission.storage.status;
              if (status.isGranted) onPick(await pickAvatar(false));
            }),
            itemAction("see_product_picture".translate(context), () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ViewImage(url: ""),
                  ));
            }),
            itemAction("delete_product_image".translate(context), () {
              Navigator.pop(context);
              onPick(null);
            }),
            itemAction(
                "cancel".translate(context), () => Navigator.pop(context)),
          ],
        ),
      );
    },
  );
}

Future<File?> pickAvatar(bool checkCamera) async {
  XFile? pickImage = await ImagePicker().pickImage(
      source: checkCamera ? ImageSource.camera : ImageSource.gallery);
  try {
    if (pickImage != null) {
      final cropImage = await ImageCropper().cropImage(
        sourcePath: pickImage.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.square],
      );
      if (cropImage != null) {
        return File(cropImage.path);
      }
    }
  } on PlatformException catch (_) {}
  return null;
}

Widget itemAction(String text, Function onPress) {
  return InkWell(
    onTap: () => onPress(),
    child: SizedBox(
      width: double.infinity,
      height: 70,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
