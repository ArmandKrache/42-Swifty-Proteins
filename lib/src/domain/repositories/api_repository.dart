import 'package:swifty_proteins/src/utils/resources/data_state.dart';

abstract class ApiRepository {

  Future<DataState<dynamic>> getLigand(String id);

}