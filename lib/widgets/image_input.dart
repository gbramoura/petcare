import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Color color;
  final TextEditingController controller;
  final EdgeInsetsGeometry? margin;

  const ImageInput({
    super.key,
    required this.color,
    required this.controller,
    this.margin,
  });

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  _pick() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      return;
    }

    setState(() {
      widget.controller.text = pickedFile.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          widget.margin ?? EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: _pick,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: _image(),
        ),
      ),
    );
  }

  Widget _image() {
    if (widget.controller.text.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.photo_camera,
            size: 80,
          ),
          SizedBox(height: 5),
          Text(
            'Clique para adicionar uma foto',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      );
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: FileImage(
            File(widget.controller.text),
          ),
        ),
      ),
    );
  }
}
