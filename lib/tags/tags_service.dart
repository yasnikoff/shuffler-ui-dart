import "package:angular2/core.dart";
import "package:shuffler_web_ui/core.dart";


/*
* TagService is designed to be attachable to different types of owners.
* Hence the abstract class Owner and more complicated initialization.
*
* */

@Injectable()
class TagService extends Data implements Server {

  TagService(Owner owner) :super(owner) {
    this.owner = owner;
    owner.tags = this;
  }

  Owner owner;
  List<Tag> tags;

  @override
  List<Tag> get data => tags;

  @override
  set data(dynamic value){
    setNames(value as List<String>);
  }

  setNames(List<String> data) {
    if (tags == null) {
      tags = new List<Tag>();
    } else {
      tags.clear();
    }
    if (data == null) return;

    data.forEach((String name) {
      tags.add(new Tag(name, list:this));
    });
  }

  int get length {
    return tags?.length ?? 0;
  }

  @override
  String get pathSegment => "tags";

  remove(List<Tag> tags){
    save(data:tags, path:"remove");
  }

  add(List<Tag> tags){
    save(data:tags, path:"add");
  }
}

class Tag {
  String name;
  TagService list;

  Tag(this.name, {TagService list}){
   this.list=list;
  }

  String toJson() => name;
}

abstract class Owner implements Server {
  TagService tags;
}
