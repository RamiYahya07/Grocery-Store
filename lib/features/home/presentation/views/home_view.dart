import 'package:flutter/material.dart';
import 'package:rw_test/features/home/presentation/views/widgets/Home_view_body.dart';
import 'package:rw_test/features/home/presentation/views/widgets/home_view_appBar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomeViewAppBar(),
      body:  HomeViewBody(),
    );
  }
}
