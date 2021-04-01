class UtilsModel {
    List<String> planes;
    List<String> plataforma;
    List<String> departamentos;
    List<String> limaprovincias;
    List<String> cuscoprovincias;
    List<String> limadistritos;
    List<String> cuscodistritos;

  UtilsModel.fromMapPlan(Map<dynamic, dynamic> data)
      : planes = List.from(data['planes']);

  UtilsModel.fromMapPlat(Map<dynamic, dynamic> data)
      : plataforma = List.from(data['plataforma']);

  UtilsModel.fromMapDep(Map<dynamic, dynamic> data)
      : departamentos = List.from(data['departamentos']);
  
  UtilsModel.fromMapDeplima(Map<dynamic, dynamic> data)
      : limaprovincias = List.from(data['departamento-Lima']);

  UtilsModel.fromMapDepcusco(Map<dynamic, dynamic> data)
      : cuscoprovincias = List.from(data['departamento-Cusco']);

  UtilsModel.fromMapProvlima(Map<dynamic, dynamic> data)
      : limadistritos = List.from(data['provincia-Lima']);

  UtilsModel.fromMapProvcusco(Map<dynamic, dynamic> data)
      : cuscodistritos = List.from(data['provincia-Cusco']);
}

