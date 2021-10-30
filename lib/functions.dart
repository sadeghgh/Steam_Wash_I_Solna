class ProductNameCar {
  String _name_car;
  dynamic _image;

  ProductNameCar(this._name_car, this._image);

  String get image => _image;

  dynamic get name_car => _name_car;
}

class ProductServices {
  String _name;
  String _description;
  String _price;

  ProductServices(this._name, this._description, this._price);

  String get price => _price;

  String get description => _description;

  String get name => _name;
}

class ProductCode {
  String _user;
  String _code;
  String _counter;
  String _orders;

  ProductCode(this._user, this._code, this._counter, this._orders);

  String get orders => _orders;

  String get counter => _counter;

  String get code => _code;

  String get user => _user;
}

class ProductCod {
  int _id;
  String _user;
  String _code;
  String _counter;
  String _orders;

  ProductCod(this._id, this._user, this._code, this._counter, this._orders);

  String get orders => _orders;

  String get counter => _counter;

  String get code => _code;

  String get user => _user;
  int get id => _id;
}
