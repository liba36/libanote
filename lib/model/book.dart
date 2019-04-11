class book {
  String _name = "";
  int _type = 0;
  String _context = "";
  int _image = -1;
  DateTime _createtime = null;
  DateTime _edittime = null;

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

  book(this._name, this._context, this._createtime, this._edittime);

  Map<String, dynamic> diaryTomap() {
    Map map = <String, dynamic>{
      "name": _name,
      "context": _context,
      "createtime": _createtime.toString(),
      "edittime": _edittime.toString()
    };
    return map;
  }
}
