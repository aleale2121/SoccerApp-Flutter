import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/app_drawer_admin.dart';
import '../blocs/club/club.dart';
import 'splash_screen.dart';

class Clubs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clubs'),
      ),
      drawer: AppDrawer(),
      body: BlocBuilder<ClubsBloc, ClubStates>(
        builder: (_, state) {
          if (state is ClubsFetchingState) {
            return SplashScreen(title: 'Fetching Clubs');
          } else if (state is ClubFetchedState) {
            final clubs = state.clubs;

            return ListView.builder(
              itemCount: clubs.length,
              itemBuilder: (_, idx) => ListTile(
                title: Text('${clubs[idx].name}'),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                ),
                onTap: () => {},
              ),
            );
          }

          return SplashScreen(title: 'Failed to load clubs');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: Icon(Icons.add),
      ),
    );
  }
}
