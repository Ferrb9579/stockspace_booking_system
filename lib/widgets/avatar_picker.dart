import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/ThemeController.dart';

class UAvatarPicker extends StatefulWidget {
  final File? initialImage;
  final Function(File) onImagePicked;

  const UAvatarPicker({
    Key? key,
    this.initialImage,
    required this.onImagePicked,
  }) : super(key: key);

  @override
  _UAvatarPickerState createState() => _UAvatarPickerState();
}

class _UAvatarPickerState extends State<UAvatarPicker> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  late ThemeController themerController;

  @override
  void initState() {
    super.initState();
    _image = widget.initialImage;
    themerController = Get.find<ThemeController>();
  }

  Future<void> _getImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File? croppedFile = await _cropImage(File(pickedFile.path));
      if (croppedFile != null) {
        setState(() {
          _image = croppedFile;
        });
        widget.onImagePicked(croppedFile);
      }
    }
  }

  Future<File?> _cropImage(File imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressFormat: ImageCompressFormat.png,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Avatar',
          toolbarColor: themerController.currentTheme.value.primary,
          toolbarWidgetColor: themerController.currentTheme.value.primaryForeground,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          activeControlsWidgetColor: themerController.currentTheme.value.primary,
        ),
        IOSUiSettings(
          title: 'Crop Avatar',
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
        ),
      ],
    );

    if (croppedFile != null) {
      return File(croppedFile.path);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _getImage,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: _image != null ? FileImage(_image!) : AssetImage('assets/images/avt2.jpg') as ImageProvider,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: themerController.currentTheme.value.background,
              radius: 18,
              child: Icon(Icons.camera_alt, size: 18, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
