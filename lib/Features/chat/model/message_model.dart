class MessageModel {
   String? senderID;
   String ?receiverID;
   String ?text;
   String ?dateTime;
  MessageModel({
     this.senderID,
     this.receiverID,
     this.text,
     this.dateTime,
  });

  MessageModel.fromJson(Map<String,dynamic>json)
  {
    senderID=json['senderID'];
    receiverID=json['receiverID'];
    text=json['text'];
    dateTime=json['dateTime'];


  }
// convert to a map
  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'receiverID': receiverID,
      'dateTime': dateTime,
      'text': text,
    };
  }
}