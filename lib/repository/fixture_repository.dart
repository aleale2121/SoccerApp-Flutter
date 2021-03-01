import 'package:meta/meta.dart';
import '../data_provider/data.dart';
import '../models/model.dart';

class FixtureRepository {
  final FixtureDataProvider fixtureDataProvider;

  FixtureRepository({@required this.fixtureDataProvider});

  Future<List<Fixture>> getAndSetFixtures() async {
    return await fixtureDataProvider.getAndSetFixtures();
  }

  Future<Fixture> getFixture(String fixtureId) async {
    return await fixtureDataProvider.getFixture(fixtureId);
  }

  Future<Fixture> postFixture(Fixture fixture) async {
    return await fixtureDataProvider.postFixture(fixture);
  }

  Future<Fixture> putFixture(Fixture fixture) async {
    return await fixtureDataProvider.putFixture(fixture);
  }

  Future<void> deleteFixture(String id) async {
    return await fixtureDataProvider.deleteFixture(id);
  }
}
