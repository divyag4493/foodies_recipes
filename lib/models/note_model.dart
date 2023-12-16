
class NoteModel{
  String? body;
  String? id;
  String? title;
  String? profilepic;

  NoteModel({
    this.id,this.body,this.title, this.profilepic
  });

  factory NoteModel.fromJson(Map<String,dynamic>json){
    return NoteModel(
      body: json['body'],
      title: json['title'],
      profilepic: json['profilepic'],
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'body': body,
      'title': title,
      'profilepic': profilepic
    };
  }
}