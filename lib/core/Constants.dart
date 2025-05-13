class Constants {
  // Base API URL
  static const String baseUrl = 'https://uatapi.kisankonnect.in/';
  // API endpoints
  static const String loginEndpoint ='${baseUrl}frapi/api/auth/FE_FrLogin';
  static const String registerEndpoint ='${baseUrl}frapi/api/auth/register';
  static const String IN_FRNewRiderLeadEndpoint ='${baseUrl}frapi/api/Rider/IN_FRNewRiderLead';
  static const String IN_FRAvailableStatusEndpoint ='${baseUrl}frapi/api/auth/IN_FRAvailableStatus';

  static  double latValue =0.0;
  static  double longValue =0.0;

}
