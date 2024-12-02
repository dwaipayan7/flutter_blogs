import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blogs/core/theme/app_pallete.dart';
import 'package:flutter_blogs/core/utils/pick_image.dart';
import 'package:flutter_blogs/feature/blog/presentation/widgets/blog_editor.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics = [];

  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              //TODO
            },
            icon: const Icon(
              Icons.done_rounded,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  selectImage();
                },
                child: DottedBorder(
                    color: AppPallete.borderColor,
                    dashPattern: const [10, 4],
                    radius: const Radius.circular(10),
                    borderType: BorderType.RRect,
                    strokeCap: StrokeCap.round,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    child: image != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(15), // Rounded corners
                      child: Image(
                        image: FileImage(image!),
                        fit: BoxFit.cover,
                      ),
                    )
                        : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_open,
                          size: 40,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Select Image",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),

                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    'Technology',
                    'Business',
                    'Programming',
                    'Entertainment',
                  ]
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedTopics.contains(e)) {
                                  selectedTopics.remove(e);
                                } else {
                                  selectedTopics.add(e);
                                }
                              });
                              if (kDebugMode) {
                                print(selectedTopics);
                              }
                            },
                            child: Chip(
                                color: selectedTopics.contains(e)
                                    ? const WidgetStatePropertyAll(
                                        AppPallete.gradient1)
                                    : null,
                                label: Text(e),
                                side: selectedTopics.contains(e)
                                    ? const BorderSide(
                                        color: AppPallete.borderColor)
                                    : null),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              BlogEditor(controller: titleController, hintText: 'Blog Title'),
              const SizedBox(
                height: 15,
              ),
              BlogEditor(
                  controller: contentController, hintText: 'Blog Content')
            ],
          ),
        ),
      ),
    );
  }
}
