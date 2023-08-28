import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee/injection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee/src/presentation/view_image/screen/view_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/services/bloc/service_bloc.dart';
import '../../../core/services/bloc/service_event.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../data/models/user.dart';
import '../../store/widgets/item_loading.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class HeaderProfilePage extends StatefulWidget {
  const HeaderProfilePage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<HeaderProfilePage> createState() => _HeaderProfilePageState();
}

class _HeaderProfilePageState extends State<HeaderProfilePage> {
  File? image;
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.statusBarColor,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imageWidget(),
              const SizedBox(height: 15),
              Text(
                AppLocalizations.of(context).member.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget imageWidget() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) =>
          current is EditProfileSate ||
          current is ChangeAvatarState ||
          current is DeleteAvatarState,
      builder: (context, state) {
        if (state is EditProfileSate) isEdit = state.isEdit;
        if (state is DeleteAvatarState) {
          widget.user.imageUrl = null;
          context
              .read<ServiceBloc>()
              .add(ChangeUserInfoEvent(getIt<User>().copyWith(imageUrl: null)));
        }
        return InkWell(
          onTap: widget.user.imageUrl != null || isEdit
              ? () => showMyBottomSheet()
              : null,
          child: ClipOval(
            child: image == null
                ? widget.user.imageUrl == null
                    ? Image.asset(AppImages.imgNonAvatar, height: 80)
                    : CachedNetworkImage(
                        height: 80,
                        width: 80,
                        imageUrl: widget.user.imageUrl ?? "",
                        placeholder: (context, url) => itemLoading(80, 80, 90),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                : Image.file(image!, height: 80),
          ),
        );
      },
    );
  }

  void showMyBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Container(
          height: isEdit ? 350 : 150,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              if (isEdit)
                itemAction(AppLocalizations.of(context).takePhoto, () async {
                  Navigator.pop(context);
                  var status = await Permission.camera.status.isGranted;
                  if (!status) {
                    status = await Permission.camera.request().isGranted;
                  }
                  if (status) pickAvatar(true);
                }),
              if (isEdit)
                itemAction(AppLocalizations.of(context).selectImageGallery,
                    () async {
                  Navigator.pop(context);
                  bool isStoragePermission = false;
                  bool isPhotosPermission = false;
                  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
                  if (androidInfo.version.sdkInt >= 33) {
                    isPhotosPermission =
                        await Permission.photos.status.isGranted;
                    if (!isPhotosPermission) {
                      isPhotosPermission =
                          await Permission.photos.request().isGranted;
                    }
                    if (isPhotosPermission) pickAvatar(false);
                  } else {
                    isStoragePermission =
                        await Permission.storage.status.isGranted;
                    if (!isStoragePermission) {
                      isStoragePermission =
                          await Permission.storage.request().isGranted;
                    }
                    if (isStoragePermission) pickAvatar(false);
                  }
                }),
              itemAction(AppLocalizations.of(context).viewProfilePicture, () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ViewImage(url: widget.user.imageUrl!),
                    ));
              }),
              if (isEdit)
                itemAction(AppLocalizations.of(context).deleteProfilePicture,
                    () {
                  Navigator.pop(context);
                  context
                      .read<ProfileBloc>()
                      .add(DeleteAvatarEvent(widget.user));
                }),
              itemAction(
                AppLocalizations.of(context).cancel,
                () => Navigator.pop(context),
              ),
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
          image = File(cropImage.path);
          if (context.mounted) {
            context.read<ProfileBloc>().add(PickAvatarEvent(image!.path));
          }
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
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
