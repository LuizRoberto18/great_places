import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function? onSelectImage;

  const ImageInput({Key? key, this.onSelectImage}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  @override
  Widget build(BuildContext context) {
    File? _storedImage;

    _takePicture() async {
      final ImagePicker _picker = ImagePicker();
      XFile imageFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
      ) as XFile;
      setState(() {
        _storedImage = File(imageFile.path);
      });

      final appDir = await syspaths.getApplicationDocumentsDirectory();
      String fileName = path.basename(_storedImage!.path);
      final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');
      widget.onSelectImage!(savedImage);
    }
    // _takePicture() async {
    //   final ImagePicker _picker = ImagePicker();
    //   final XFile? imageFile = await _picker.pickImage(source: ImageSource.camera, maxHeight: 1000, maxWidth: 1000);
    //   print(imageFile!.name.toString());
    //   print(imageFile.length());
    //   print(imageFile.mimeType);
    //   if (imageFile != null) {
    //     setState(() {
    //       _storedImage = File(imageFile.path);
    //     });
    //   }
    // }

    return Row(
      children: [
        Container(
            width: 180,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            alignment: Alignment.center,
            child: _storedImage != null
                ? Image.file(
                    File(_storedImage!.path),
                    width: double.infinity,
                    fit: BoxFit.cover,
                    height: 100,
                  )
                : const Text("Nemhuma imagem!")),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: () async {
              _takePicture();
            },
            label: const Text("Tirar foto"),
            style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.primary),
            icon: const Icon(Icons.camera),
          ),
        )
      ],
    );
  }
}
