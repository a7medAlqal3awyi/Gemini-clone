class ResponseModel {
  final String message;
  final String time;
  final String sender;

  ResponseModel(
      {required this.message, required this.time, required this.sender});
}

List<ResponseModel> messages = [];
