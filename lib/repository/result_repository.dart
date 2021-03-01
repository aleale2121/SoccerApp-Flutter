import 'package:meta/meta.dart';
import '../data_provider/data.dart';
import '../models/model.dart';

class ResultRepository {
  final ResultDataProvider resultDataProvider;

  ResultRepository({@required this.resultDataProvider});

  Future<List<Result>> getAndSetResults() async {
    return await resultDataProvider.getAndSetResults();
  }

  Future<Result> getResult(String resultId) async {
    return await resultDataProvider.getResult(resultId);
  }

  Future<Result> postResult(Result result) async {
    return await resultDataProvider.postResult(result);
  }

  Future<Result> putResult(Result result) async {
    return await resultDataProvider.putResult(result);
  }

  Future<void> deleteResult(String id) async {
    return await resultDataProvider.deleteResult(id);
  }
}
