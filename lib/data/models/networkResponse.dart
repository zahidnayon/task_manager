class networkResponse{
  final int statusCode;
  final bool isSuccess;
  final Map<String,dynamic>? body;

  networkResponse(this.isSuccess,this.statusCode, this.body);
}