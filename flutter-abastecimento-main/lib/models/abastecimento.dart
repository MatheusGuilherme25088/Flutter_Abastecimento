class Abastecimento {
  String data;
  String combustivel;
  double litros;
  double valorPago;
  double quilometragem;

  Abastecimento({
    required this.data,
    required this.combustivel,
    required this.litros,
    required this.valorPago,
    required this.quilometragem,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'combustivel': combustivel,
      'litros': litros,
      'valorPago': valorPago,
      'quilometragem': quilometragem,
    };
  }

  factory Abastecimento.fromMap(Map<String, dynamic> map) {
    return Abastecimento(
      data: map['data']?.toString() ?? '',
      combustivel: map['combustivel']?.toString() ?? '',
      litros: (map['litros'] as num?)?.toDouble() ?? 0,
      valorPago: (map['valorPago'] as num?)?.toDouble() ?? 0,
      quilometragem: (map['quilometragem'] as num?)?.toDouble() ?? 0,
    );
  }
}
