class VideoPojo{

    final String id;
    final String key;
    final String name;
    final String site;
    final String type;


    VideoPojo(this.key,this.name,this.site,this.id,this.type);

    VideoPojo.fromJson(Map<String,dynamic> json)
  : id = json["id"],
    key = json["key"],
    name = json["name"],
    site = json ["site"],
    type =json ["type"];


}