class account{
  int _id=-1;
  String _title = "";
  String _name = "";
  String _password = "";
  int _bookid = 0;
  DateTime _createtime = null;
  DateTime _edittime = null;

  int get id => _id;
  set id(int id)=>_id = id;

  String get title => _title;
  set title(String title)=>_title = title;

  String get name => _name;
  set name(String name)=>_name = name;

  String get password => _password;
  set password(String password)=>_password = password;

  int get bookid => _bookid;
  set bookid(int bookid)=>_bookid = bookid;

  DateTime get createtime => _createtime;
  set createtime(DateTime createtime) => _createtime = createtime;

  DateTime get edittime => _edittime;
  set edittime(DateTime edittime) => _edittime = edittime;

  account(this._title,this._name,this._password,this._bookid,this._createtime,this._edittime);

  Map<String, dynamic> AccountToMap() {
    Map map = <String, dynamic>{
      "title": _title,
      "name": _name,
      "password":_password,
      "bookid":_bookid,
      "createtime": _createtime.toString(),
      "edittime": _edittime.toString()
    };
    return map;
  }
}