// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hello/core/Model/book_model%20copy.dart';
import 'package:hello/core/Model/post_model.dart';

class ResultModel {}

class ErrorModel extends ResultModel {}

class ExceptionModel extends ResultModel {}

class successModel extends ResultModel {}

class ListOf<T> extends ResultModel {
  List<PostModel> result;
  ListOf({
    required this.result,
  });
}

class ListOfbook<T> extends ResultModel {
  List<Bookmodel> result;
  ListOfbook({
    required this.result,
  });
}

class ListofEverything<T extends ResultModel> extends ResultModel {
  List<T> listresult;
  ListofEverything({
    required this.listresult,
  });
}
