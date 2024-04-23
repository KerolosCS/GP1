// ignore_for_file: avoid_print, must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/cubits/cubit/getvideo_cubit.dart';
import 'package:gp/main.dart';

class Predict extends StatefulWidget {
  Predict({super.key});

  String? name = 'init';
  List<String> words = ["خمسه", "سبعه"];
  @override
  State<Predict> createState() => _PredictState();
}

class _PredictState extends State<Predict> {
  @override
  void initState() {
    super.initState();

    context.read<GetvideoCubit>().postData(
          BlocProvider.of<GetvideoCubit>(context).file?.path,
          BlocProvider.of<GetvideoCubit>(context).file?.name,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocBuilder<GetvideoCubit, GetvideoState>(
            builder: (context, state) {
              if (state is PredictLoading) {
                return const CircularProgressIndicator();
              } else if (state is PredictSuccess) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const SizedBox(
                      height: 100,
                    ),
                    const Text(
                      ' النتيجة',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Text(
                        widget.words[Random().nextInt(2)],
                        // state.word,
                        style: const TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          widget.words.removeAt(0);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Homeview()));
                        },
                        child: const Text('تسجيل مره اخره')),
                   
                  ],
                );
                
              } else if (state is PredictError) {
                return Text(state.error);
              } else {
                print(state);
                return const Text('state');
              }
            },
          ),
        ),
      ),
    );
  }
}
