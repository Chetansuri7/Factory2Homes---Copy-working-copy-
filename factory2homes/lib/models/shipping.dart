class Shipping {
  int id;
  String name;
  String address;

  toJson(){
    return {
      'id' : id.toString(),
      'name' : name,
      'address' : address
    };
  }
}