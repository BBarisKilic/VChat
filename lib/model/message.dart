class Message {
  int duration;
  String sendBy;
  int time;

  Message({required this.duration, required this.sendBy, required this.time});

  Map<String, dynamic> toMap() {
    return {"duration": duration, "sendBy": sendBy, "time": time};
  }
}
