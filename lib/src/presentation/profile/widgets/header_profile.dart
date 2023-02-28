import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class HeaderProfilePage extends StatefulWidget {
  const HeaderProfilePage({Key? key}) : super(key: key);

  @override
  State<HeaderProfilePage> createState() => _HeaderProfilePageState();
}

class _HeaderProfilePageState extends State<HeaderProfilePage> {
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(177, 40, 48, 1),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => showMyBottomSheet(),
                child: ClipOval(
                  child: image == null
                      ? Image.asset("assets/coffee_logo.jpg", height: 80)
                      : Image.file(File(image!.path), height: 80),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: const [
                        Text(
                          "DRIPS: 0",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        VerticalDivider(
                          color: Colors.white,
                          width: 2,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "THÀNH VIÊN",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  void showMyBottomSheet() {
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
              itemAction("Chụp hình", () async {
                Navigator.pop(context);
                var status = await Permission.camera.status;
                if (status.isDenied) {
                  await Permission.camera.request();
                }
                status = await Permission.camera.status;
                if (status.isGranted) pickAvatar(true);
              }),
              itemAction("Chọn hình từ thư viện", () async {
                Navigator.pop(context);
                var status = await Permission.storage.status;
                if (status.isDenied) {
                  await Permission.storage.request();
                }
                status = await Permission.storage.status;
                if (status.isGranted) pickAvatar(false);
              }),
              itemAction("Xem hình trang cá nhân", () {}),
              itemAction("Xóa hình trang cá nhân", () {}),
              itemAction("Hủy", () => Navigator.pop(context)),
            ],
          ),
        );
      },
    );
  }

  void pickAvatar(bool checkCamera) async {
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
          setState(() => image = XFile(cropImage.path));
        }
      }
    } on PlatformException catch (_) {}
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
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
