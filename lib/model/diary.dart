class diary {
  String _title = "";
  String _context = "";
  int _bookid = 0;
  String _image = "";
  DateTime _createtime = null;
  DateTime _edittime = null;

  String get title => _title;

  set title(String title) => _title = title;

  String get context => _context;

  set context(String context) => _context = context;

  int get bookid => _bookid;

  set bookid(int bookid) => _bookid = bookid;

  String get image => _image;

  set image(String image) => _image = image;

  DateTime get createtime => _createtime;

  set createtime(DateTime createtime) => _createtime = createtime;

  DateTime get edittime => _edittime;

  set edittime(DateTime edittime) => _edittime = edittime;

  diary(this._title, this._context,this._bookid, this._createtime, this._edittime);

  Map<String, dynamic> diaryTomap() {
    Map map = <String, dynamic>{
      "title": _title,
      "context": _context,
      "bookid":_bookid,
      "createtime": _createtime.toString(),
      "edittime": _edittime.toString()
    };
    return map;
  }
}
