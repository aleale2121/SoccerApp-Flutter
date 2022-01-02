import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/fixture/fixture.dart';
import '../widgets/fixture_comp_admin.dart';
import 'splash_screen.dart';

class AdminFixturesScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  AdminFixturesScreen({required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FixturesBloc, FixtureStates>(
      listener: (_, state) {
        if (state is FixtureDeletingState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Deleting fixture ......'),
            ),
          );
          SnackBar(
              content: Text('Deleting fixture.....'),
              duration: Duration(minutes: 2));
        }
        if (state is FixtureDeletedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error Adding the result'),
            ),
          );
        }
        if (state is FixturesDeletingErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Fixture Deleted'),
            ),
          );
        }
      },
      builder: (_, state) {
        print(state.toString());
        if (state is FixturesFetchingState) {
          return SplashScreen(title: 'Fetching Fixtures');
        } else if (state is FixturesFetchedState) {
          final fixtures = state.fixtures;

          return ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: fixtures.length,
              itemBuilder: (_, idx) =>
                  FixtureComponentAdmin(fixture: fixtures[idx]));
        } else if (state is FixturesEmptyState) {
          return SplashScreen(title: 'No fixture Added');
        } else {
          return SplashScreen(title: 'Failed to load fixtures');
        }
      },
    );
  }
}
