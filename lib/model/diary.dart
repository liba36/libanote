class diary {

  String _title = "";
  String _context = "";
  String _image = "";
  DateTime _createtime;
  DateTime _edittime;


  String get title => _title;
         set title(String title) => _title = title;
  String get context => _context;
         set context(String context) => _context = context;
  String get image => _image;
         set image(String image) => _image = image;
  DateTime get createtime => _createtime;
           set createtime(DateTime createtime) => _createtime =createtime;
  DateTime get edittime => _edittime;
           set edittime(DateTime edittime) => _edittime = edittime;



  diary(this._title,this._context,this._createtime,this._edittime);

  

  Map<String,dynamic> diaryTomap()
  {
    Map map = <String,dynamic>{
      "title": _title,
      "context": _context,
      "createtime":_createtime.toString(),
      "edittime":_edittime.toString()
    };
    return map;
  }

}