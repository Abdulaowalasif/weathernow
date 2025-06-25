import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathernow/cubit/network_cubit.dart';
import 'package:weathernow/screen/home_screen.dart';

import '../model/weather_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NetworkCubit>().getPermission();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NetworkCubit, NetworkState>(
      builder: (context, state) {
        return Center(child: CircularProgressIndicator());
      },
      listener: (context, state) async {
        if (state is LocationPermissionDenied) {
          context.read<NetworkCubit>().getPermission();
        }
        if (state is LocationPermissionGranted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
          await context.read<NetworkCubit>().fetchData();
        }
      },
    );
  }
}
