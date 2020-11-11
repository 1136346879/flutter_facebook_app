
class User {
   String name;
   String imageUrl;

   User({
     this.name,
     this.imageUrl,
  });

  User.fromJson(Map<dynamic, dynamic> json){
    if (json == null){
      return;
    }
    name = json['name'];
    imageUrl = json['imageUrl'];
  }
}
