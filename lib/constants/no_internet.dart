// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyFailureNoInternetView extends StatelessWidget {

  final AsyncSnapshot<ConnectivityResult> snapshot;
  final Widget widgets;
  const EmptyFailureNoInternetView({
    Key? key,
    required this.snapshot,
    required this.widgets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch(snapshot.connectionState){
      case ConnectionState.active:
      final state=snapshot.data;
      switch(state){
        case ConnectivityResult.none:
        return Center(child:  Lottie.asset('assets/lottiesfile/no_internet.json',
                                  fit: BoxFit.cover),
                            );
        default:
        return widgets;
      }
      default:
      return Text('');
    }
  }
}
