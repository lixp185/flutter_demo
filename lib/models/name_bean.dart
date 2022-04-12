/// initial : "A"
/// nameList : [{"name":"老李"}]

class NameBean {
  String? initial;
  List<Name>? nameList;

  NameBean({
    this.initial,
    this.nameList,
  });
}

/// name : "老李"

class Name {
  String? name;

  Name({
    this.name,
  });
}
