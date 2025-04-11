import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPreviewScreen extends StatelessWidget {
  final CameraController controller;
  final Future<void> initializeControllerFuture;

  const CameraPreviewScreen({
    Key? key,
    required this.controller,
    required this.initializeControllerFuture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return
          Scaffold(
            body: Stack(
              children: [
                Center(
                  child: 
                    AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: CameraPreview(controller),
                    ),
                ),
                Positioned(
                  bottom: 50,
                  right: 20,
                  child: IconButton.outlined(
                    onPressed: ()=> Navigator.pop(context), 
                    icon: const Icon(Icons.arrow_left_sharp, color: Colors.white)
                  )
                ),
              ]
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
