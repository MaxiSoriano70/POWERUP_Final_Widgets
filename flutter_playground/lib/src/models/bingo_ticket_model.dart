class BingoTicketModel{
  int id;
  int number;
  int priceUnit;
  String name;
  String? imageUrl;
  DateTime date;
  bool? isFavorite;

  BingoTicketModel({
    required this.id,
    required this.number,
    required this.priceUnit,
    required this.name,
    required this.date,
    this.imageUrl,
    this.isFavorite = false
  });

  int gedId() => id;
  setId (int id){
    id = id;
  }

  String getName() => name;
  setName (String name){
    name = name;
  }

  DateTime getDate() => date;
  setDate (DateTime date){
    date = date;
  }

  String getImageUrl() => imageUrl!;
  setImageUrl (String imageUrl){
    imageUrl = imageUrl;
  }

  int getPrice() => priceUnit;
  setPrice (int price){
    priceUnit = price;
  }

  bool getIsFavorite() => isFavorite!;
  setIsFavorite (bool favorite){
    isFavorite = favorite;
  }
}