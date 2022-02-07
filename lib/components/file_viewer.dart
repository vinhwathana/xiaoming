import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xiaoming/models/utils/attachment.dart';
import 'package:xiaoming/services/file_service.dart';
import 'package:xiaoming/utils/constant.dart';

class FileViewer {
  final fileService = FileService();

  Future<void> displayFile(context, List<Attachment?> attachmentList) async {
    Attachment? attachment;
    if (attachmentList.length > 1) {
      await showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.only(top: 20, left: 20),
                margin: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                // color: Colors.transparent,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Select Files",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ...List.generate(attachmentList.length, (index) {
                      if (attachmentList[index] != null) {
                        return ListTile(
                          title: Text(attachmentList[index]!.fileName ?? ""),
                          onTap: () {
                            attachment = attachmentList[index];
                            Get.back();
                          },
                        );
                      } else {
                        return Container();
                      }
                    }),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
    else if (attachmentList.length == 1 && attachmentList[0] != null) {
      attachment = attachmentList[0];
    }

    if (attachment == null ||
        attachment!.id == null ||
        attachment!.fileName == null) {
      print("Attachment null");
      return;
    }
    await fileService.getFile(attachment!.id.toString()).then((response) async {
      if (response == null) {
        return;
      }
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final fileName = attachment!.fileName;

        //Find applicationDirectory
        final documentsDir = (await getApplicationDocumentsDirectory()).path;
        //Create file with file name in the Application dir
        final file = await File('$documentsDir/$fileName').create();
        file.writeAsBytesSync(bytes);
        await OpenFile.open(file.path);
      }
    });
  }
}
