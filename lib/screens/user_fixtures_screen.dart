import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/fixture/fixture.dart';
import '../widgets/fixture_comp_user.dart';
import 'splash_screen.dart';

class UserFixturesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FixturesBloc, FixtureStates>(
      listener: (context, state) {},
      builder: (_, state) {
        if (state is FixturesFetchingState) {
          return SplashScreen(title: 'Fetching Fixtures');
        } else if (state is FixturesFetchedState) {
          final fixtures = state.fixtures;

          return ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: fixtures.length,
              itemBuilder: (_, idx) =>
                  FixtureComponent(fixture: fixtures[idx]));
        } else if (state is FixturesEmptyState) {
          return SplashScreen(title: 'No fixture Added');
        } else {
          return SplashScreen(title: 'Failed to load fixtures');
        }
      },
    );
  }
}
