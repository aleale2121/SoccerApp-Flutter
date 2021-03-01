import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/result/result.dart';
import '../widgets/result_comp_user.dart';
import 'splash_screen.dart';

class UserResultsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResultsBloc, ResultStates>(
      listener: (context, state) {},
      builder: (_, state) {
        print(state.toString());
        if (state is ResultsFetchingState) {
          return SplashScreen(title: 'Fetching Results');
        } else if (state is ResultsFetchedState) {
          final results = state.results;

          return ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: results.length,
              itemBuilder: (_, idx) => ResultComponent(result: results[idx]));
        } else if (state is ResultsEmptyState) {
          return SplashScreen(title: 'No Fixtures Found');
        } else {
          return SplashScreen(title: 'Failed to load results');
        }
      },
    );
  }
}
