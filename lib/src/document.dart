class Document {
  final String id;
  Map<String, dynamic> data;

  Document(this.id, this.data);

  Map<String, dynamic> toJson() => {"id": id, "data": data};

  static Document fromJson(Map<String, dynamic> json) {
    return Document(json["id"], json["data"]);
  }

  @override
  String toString() => "Document(id: $id, data: $data)";
}
