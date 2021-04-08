
import 'package:uac_token_mobile/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:uac_token_mobile/manage_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:uac_token_mobile/services/login_service.dart';
import 'package:uac_token_mobile/service_principal.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:uac_token_mobile/screens/login_screen.dart';

class ExecuteRequest {

  Future <bool> checkConnexion(BuildContext context) async{
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Echec de connexion"),
            content: Text("Aucune connexion internet n'a été détectée. Veuillez vérifier votre connectivité"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Fermer'),
              )
            ],
          );
        });
      return false;
    }
  }

  Future<http.Response> getRequest(String url, BuildContext context) async {
    service_principal<LoginService>().verifyAccessToken(context);
    String accessToken = await  managePreferences.getPreferredToken();
    var response = await http.get(url, headers: {HttpHeaders.authorizationHeader: "Bearer "+accessToken});
    print("Execute Request 1");
    //print(response.body);
    if (response.statusCode == 200) {
      return response;
    }
    else {
      final bool statut = await service_principal<LoginService>().verifyAccessToken(context);
      if (statut){
        String newAccessToken = await managePreferences.getPreferredToken();
        var newResponse = await http.get(url, headers: {HttpHeaders.authorizationHeader: "Bearer "+newAccessToken});
        print("Execute Request 2");

        if (newResponse.statusCode == 200) {
          return response;
        }
        else{
          //throw Exception("Please check Internet access");
          await service_principal<LoginService>().verifyAccessToken(context);
        }
      }
      else{
        //throw Exception("Please check Internet access");
        await service_principal<LoginService>().verifyAccessToken(context);
      }
    }
  }

  Future<http.Response> postRequest(String url, String data, BuildContext context) async {
    service_principal<LoginService>().verifyAccessToken(context);
    String accessToken = await managePreferences.getPreferredToken();
    var response = await http.post(url, headers: {"Content-Type": "application/json", HttpHeaders.authorizationHeader: "Bearer "+accessToken}, body:data);
    print("Execute Request 1--");
    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return response;
    }
    else {
      final bool statut = await service_principal<LoginService>().verifyAccessToken(context);
      if (statut){
        String newAccessToken = await managePreferences.getPreferredToken();
        var newResponse = await http.post(url, headers: {"Content-Type": "application/json", HttpHeaders.authorizationHeader: "Bearer "+newAccessToken}, body:data);
        print("Execute Request 2");
        if (response.statusCode == 201 || response.statusCode == 200) {
          return response;
        }
        else if (response.statusCode == 401) {
          //throw Exception("Please check Internet access");
          await service_principal<LoginService>().verifyAccessToken(context);
        }
        else{
          //throw Exception("Please check Internet access");
          await service_principal<LoginService>().verifyAccessToken(context);
        }
      }
      else{
        print("\n \n \n \n ---------------------------------------");
        print(response.statusCode);
        print(response.body);
        print("$response.");

        //throw Exception("Please check Internet access");
        await service_principal<LoginService>().verifyAccessToken(context);
      }
    }
  }

  Future<http.StreamedResponse> postMultipartRequest(http.MultipartRequest my_request, BuildContext context) async {
    String accessToken = await managePreferences.getPreferredToken();
    Map<String, String> headers = { "Authorization": "Bearer "+accessToken};
    my_request.headers.addAll(headers);
    var response_image = await my_request.send();
    //print(my_request);
    //print(my_request.fields);
    //print("$my_request.files");
    print("Execute Request 1");
    if (response_image.statusCode == 201){
      return response_image;
    }

    else {
      await service_principal<LoginService>().verifyAccessToken(context);
      String accessToken = await managePreferences.getPreferredToken();
      Map<String, String> headers = { "Authorization": "Bearer "+accessToken};
      my_request.headers.addAll(headers);
      var response_image = await my_request.send();
      print("Execute Request 2");
      if (response_image.statusCode == 201){
        return response_image;
      }
      else if(response_image.statusCode == 401){
        //throw Exception("Please check Internet access");
        await service_principal<LoginService>().verifyAccessToken(context);
      }
      else{
        print(response_image.statusCode);
        //throw Exception("Please check Internet access");
        /*Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage())); */
        await service_principal<LoginService>().verifyAccessToken(context);
      }
    }

  }


  Future<File> getCachedFile(String url) async{
    //print("\n \n \n \n +++++++++++++++++++ Netoyage ");
    //await DefaultCacheManager().emptyCache();
    FileInfo fileInfo = await DefaultCacheManager().getFileFromCache(url);
    //print("\n \n \n \n ****************************");
    if (fileInfo !=null){
      //print("---------- \n \n Find in Cache");
      File file = await fileInfo.file;
      return file;
    }
    else{
      //print("###############\n \n \n \n \n Will be downloaded");
      File newFile = (await (await DefaultCacheManager().downloadFile(url))).file;
      return newFile;
    }
  }

  Future<http.Response> getCachedResponse(String url) async{
    FileInfo fileInfo = await DefaultCacheManager().getFileFromCache(url);

    if (fileInfo !=null){
      File file = await fileInfo.file;
      return http.Response.bytes(file.readAsBytesSync(), 200);
    }
    else{
      return http.Response.bytes("".codeUnits, 404);
    }
  }

  Future<void> setCachedResponse(String url, http.Response response) async{
    var fileBytes = response.bodyBytes;
    await DefaultCacheManager().removeFile(url);
    await DefaultCacheManager().putFile(url, fileBytes);
  }

}
