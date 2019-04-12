class book {
  int _id = 0;
  String _name = "";
  int _type = 0;
  String _context = "";
  int _image = -1;
  DateTime _createtime = null;
  DateTime _edittime = null;

  int get id => _id;

  set id(int id) => _id = id;

  String get name => _name;

  set name(String name) => _name = name;

  int get type => _type;

  set type(int type) => _type = type;

  String get context => _context;

  set context(String context) => _context = context;

  int get image => _image;

  set image(int image) => _image = image;

  DateTime get createtime => _createtime;

  set createtime(DateTime createtime) => _createtime = createtime;

  DateTime get edittime => _edittime;

  set edittime(DateTime edittime) => _edittime = edittime;

  book(this._name, this._type, this._context, this._image, this._createtime,
      this._edittime,);

  Map<String, dynamic> bookTomap() {
    Map map = <String, dynamic>{
      "title": _name,
      "image": _image,
      "type": _type,
      "description": _context,
      "createtime": _createtime.toString(),
      "edittime": _edittime.toString()
    };
    return map;
  }
}
