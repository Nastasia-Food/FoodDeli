// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class NotificationBody {
  String? topic;
  String? tittle;
  String? body;
  String? sound;
  String? image;
  String? topicName;
  String? orderId;

  NotificationBody(
      {this.topic, this.tittle, this.body, this.sound, this.image});

  NotificationBody.fromJson(Map<String, dynamic> json) {
    topic = json['topic'];
    tittle = json['title'];
    body = json['body'];
    sound = json['sound'];
    image = json['image'];
    topicName = json['topicName'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topic'] = topic;
    data['title'] = tittle;
    data['body'] = body;
    data['sound'] = sound;
    data['image'] = image;
    data['topicName'] = topicName;
    data['order_id'] = orderId;

    return data;
  }
}
