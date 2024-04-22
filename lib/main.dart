// ignore_for_file: must_be_immutable, avoid_print, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/core/bloc_observer.dart';
import 'package:gp/cubits/cubit/cubit/predict_cubit.dart';
import 'package:gp/cubits/cubit/getvideo_cubit.dart';
import 'package:gp/widgets/predict.dart';
import 'package:gp/widgets/word_view_body.dart';
import 'package:chewie/chewie.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetvideoCubit(),
        ),
        // BlocProvider(
        //   // create: (context) => PredictCubit(),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Homeview(),
      ),
    );
  }
}

class Homeview extends StatelessWidget {
  Homeview({super.key});
  String gg = 'الكلمات المتاحه';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetvideoCubit, GetvideoState>(
        listener: (context, state) {
      if (state is GetvideoSucces) {
        // make a snackbar

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Done'),
            backgroundColor: Colors.green,
          ),
        );
        gg = 'الفيديو المسجل';
      } else if (state is GetvideoFail) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please try again'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: BlocBuilder<GetvideoCubit, GetvideoState>(
            builder: (context, state) {
              return Text(gg);
            },
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            showCupertinoModalPopup(
              context: context,
              builder: (context) => const CupertinoActionSheet(
                actions: [
                  SheetAction(text: 'Video Gallery', s: 0),
                  SheetAction(text: 'Camera Video capture One second', s: 1),
                  SheetAction(text: 'Camera Video capture Two second', s: 2),
                ],
              ),
            );
          },
          child: const Icon(Icons.camera_alt_rounded),
        ),
        body: (state is GetvideoSucces)
            ? Column(
                children: [
                  Container(
                    color: Colors.transparent,
                    height: 300,
                    width: double.infinity,
                    child: Center(
                      child: Chewie(
                        controller: ChewieController(
                          videoPlayerController:
                              BlocProvider.of<GetvideoCubit>(context)
                                  .controller!,
                          autoPlay: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () async {
                      gg = 'الكلمات المتاحه';
                      print(
                          "FADY :: CONTROLLER :: ${BlocProvider.of<GetvideoCubit>(context).controller!}");
                      context.read<GetvideoCubit>().justState();
                      print('NAVIGATORRRR');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Predict();
                      }));
                    },
                    child: const Text("Done , Please Predict"),
                  ),
                ],
              )
            : const WordsViewBody(),
      );
    }
        // },
        );
  }
}

class SheetAction extends StatelessWidget {
  const SheetAction({
    super.key,
    required this.text,
    required this.s,
  });
  // String text = 'Camera Video capture Two second';
  final String text;
  final int s;
  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheetAction(
      child: Text(text),
      onPressed: () {
        Navigator.of(context).pop();

        if (s == 1) {
          BlocProvider.of<GetvideoCubit>(context).getVideoFromCameraOneSecond();
        } else if (s == 2) {
          BlocProvider.of<GetvideoCubit>(context).getVideoFromCameraTwoSecond();
        } else {
          BlocProvider.of<GetvideoCubit>(context).getVideoFromGallery();
        }
      },
    );
  }
}
