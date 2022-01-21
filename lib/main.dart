import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'bloc_observer.dart';
import 'blocs/auth/auth.dart';
import 'blocs/club/club.dart';
import 'blocs/fixture/fixture.dart';
import 'blocs/result/result.dart';
import 'blocs/user/user.dart';
import 'repository/repository.dart';
import 'route/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();
  final UserRepository userRepository = UserRepository(
    auth: _firebaseAuth,
    firebaseFirestore: _firebaseFirestore,
    secureStorage: _flutterSecureStorage,
  );
  ClubRepository clubRepository = ClubRepository(
    firebaseFirestore: _firebaseFirestore,
  );
  FixtureRepository fixtureRepository = FixtureRepository(
    firebaseFirestore: _firebaseFirestore,
  );
  ResultRepository resultRepository = ResultRepository(
    firebaseFirestore: _firebaseFirestore,
  );
  print("----------------");
  print(DateTime.now());
  BlocOverrides.runZoned(
    () => runApp(SoccerApp(
      userRepository: userRepository,
      clubRepository: clubRepository,
      fixtureRepository: fixtureRepository,
      resultRepository: resultRepository,
    )),
    blocObserver: SimpleBlocObserver(),
  );
}

class SoccerApp extends StatelessWidget {
  final UserRepository userRepository;
  final ClubRepository clubRepository;
  final FixtureRepository fixtureRepository;
  final ResultRepository resultRepository;
  const SoccerApp({
    Key? key,
    required this.userRepository,
    required this.clubRepository,
    required this.fixtureRepository,
    required this.resultRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (_) => this.userRepository,
        ),
        RepositoryProvider<ClubRepository>(
          create: (_) => this.clubRepository,
        ),
        RepositoryProvider<FixtureRepository>(
          create: (_) => this.fixtureRepository,
        ),
        RepositoryProvider<ResultRepository>(
          create: (_) => this.resultRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (_) => AuthBloc(
              userRepository: this.userRepository,
            )..add(AutoLoginEvent()),
          ),
          BlocProvider<ClubsBloc>(
            create: (_) => ClubsBloc(clubsRepository: this.clubRepository)
              ..add(
                LoadClubs(),
              ),
          ),
          BlocProvider<FixturesBloc>(
            create: (_) =>
                FixturesBloc(fixturesRepository: this.fixtureRepository)
                  ..add(
                    LoadFixtures(),
                  ),
          ),
          BlocProvider<ResultsBloc>(
            create: (_) => ResultsBloc(resultRepository: this.resultRepository)
              ..add(LoadResults()),
          ),
          BlocProvider<UserBloc>(
            create: (_) => UserBloc(userRepository: this.userRepository)
              ..add(
                LoadUsers(),
              ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Soccer App',
          initialRoute: '/',
          onGenerateRoute: AppRoutes.generateRoute,
        ),
      ),
    );
  }
}
