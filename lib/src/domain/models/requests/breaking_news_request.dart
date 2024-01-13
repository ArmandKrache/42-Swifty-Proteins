import 'package:swifty_companion/src/utils/constants/nums.dart';
import 'package:swifty_companion/src/utils/constants/strings.dart';


class BreakingNewsRequest {
  final String country;
  final String category;
  final int page;
  final int pageSize;

  BreakingNewsRequest({
  this.country = 'us',
  this.category = 'general',
  this.page = 1,
  this.pageSize = defaultPageSize,
});

}