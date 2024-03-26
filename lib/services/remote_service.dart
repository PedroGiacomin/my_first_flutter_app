import 'dart:io';

import 'package:my_first_flutter_app/models/post.dart';
import 'package:my_first_flutter_app/models/testes.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Post>?> getPosts() async {
    var client = http.Client();

    // passa a rota
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    // Faz o get aqui, se precisar passar headers (auth), passa como argumento
    // do get
    var response = await client.get(uri);
    var responseStatus = response.statusCode;

    // Ja retorna fazendo o parse pra JSON
    if (responseStatus == 200) {
      var json = response.body;
      (print('$responseStatus'));
      return postFromJson(json);
    } else {
      (print('$responseStatus'));
      return null;
    }
  }

  Future<List<Teste>?> getTestes() async {
    var client = http.Client();

    // passa a rota
    var uri = Uri.parse('http://localhost:3333/teste');

    // define os headers

    // Faz o get aqui, se precisar passar headers (auth), passa como argumento
    // do get
    var response = await client.get(uri, headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c3VhcmlvIjp7InVzdWFyaW8iOjIwMjQ5OTc0MiwiZGVwYXJ0YW1lbnRvIjoiTm9tZSBkZXBhcnRhbWVudG8iLCJtYXRyaWN1bGFfdWZtZyI6MjAyMDIwMjAsIm5pdmVsIjoiRG91dG9yYWRvIiwiZXF1aXBlIjoiRXF1aXBlIFRlc3RlIiwibWF0cmljdWxhIjoyMDI0OTk3NDIsInRpcG8iOiIzYTliMWM3IiwiZW1haWwiOiJwcm9mZXNzb3IxQGdtYWlsLmNvbSIsInNlbmhhIjoiNmU0NTYyZjdkZDFlYmY4MTA5Mjk4Nzc1ZDI0MDdhNmI0MDdmZTcxMTRjNTdiMTMwMDRhMzJlOWJkYjRiNzU4YyIsImF0aXZvIjp0cnVlLCJiaW9tZXRyaWEiOm51bGwsIm5vbWVDb21wbGV0byI6IlByb2Zlc3NvciBUZXN0ZSIsImRhdGFOYXNjaW1lbnRvIjoiMTk4OS0xMi0xM1QwMjowMDowMC4wMDBaIiwicmciOjQ1Njc4OSwiZGF0YUVtaXNzYW9SZyI6IjIwMDAtMDEtMDFUMDI6MDA6MDAuMDAwWiIsIm9yZ2FvRXhwZWRpZG9yUmciOiJTU1AiLCJjcGYiOiIxMjg1NTg4MTIxNiIsInNleG8iOiJNYXNjdWxpbm8iLCJlc3RhZG9DaXZpbCI6IkNhc2FkbyIsImxvZ2Fkb3VybyI6IlJ1YSBFeGVtcGxvIiwibnVtZXJvRW5kZXJlY28iOjEyMywiY29tcGxlbWVudG8iOiJBcGFydGFtZW50byAxIiwiYmFpcnJvIjoiQmFpcnJvIFRlc3RlIiwiY2VwIjoxMjM0NTY3OCwiY2lkYWRlIjoiQ2lkYWRlIEV4ZW1wbG8iLCJlc3RhZG8iOiJFc3RhZG8gRXhlbXBsbyIsInRlbGVmb25lUmVzaWRlbmNpYWwiOiIoMDApIDEyMzQtNTY3OCIsImNlbHVsYXIiOiIoMDApIDk4NzY1LTQzMjEiLCJ0ZW1BbGVyZ2lhIjpmYWxzZSwidGlwb0FsZXJnaWEiOiJBbGVyZ2lhIGEgYWxnbyIsInVzYU1lZGljYW1lbnRvIjpmYWxzZSwidGlwb01lZGljYW1lbnRvIjoiTWVkaWNhbWVudG8gWFlaIiwidGlwb1Nhbmd1aW5lbyI6IkErIiwiY29udGF0b0VtZyI6IigwMCkgMTIzNC01Njc4Iiwibm9tZUNvbnRhdG9FbWciOiJDb250YXRvIGRlIGVtZXJnw4PCqm5jaWEiLCJ0ZW1Db252ZW5pbyI6ZmFsc2UsInRpcG9Db252ZW5pbyI6Ik5vbWUgZG8gY29udsODwqpuaW8iLCJudW1lcm9Db252ZW5pbyI6MTIzNDU2Nzg5LCJmaW1BdGVuZGltZW50b0NURSI6bnVsbCwicG9zc3VpRGVmaWNpZW5jaWEiOmZhbHNlLCJ0aXBvRGVmaWNpZW5jaWEiOiJEZWZpY2nDg8KqbmNpYSBmw4PCrXNpY2EiLCJtZWlvVHJhbnNwb3J0ZSI6IkNhcnJvIiwicGxhY2FPdUxpbmhhIjoiQUJDLTEyMzQiLCJkYXRhQ2FkYXN0cm8iOiIyMDAxLTAxLTAxVDAyOjAwOjAwLjAwMFoifSwiaWF0IjoxNzExNDY4OTAwLCJleHAiOjE3MTQwNjA5MDB9.b-nZkxv2rO-LE_MV4o2GTxJiAeqU87V5JVuQTxbH4w4'
    });
    var responseStatus = response.statusCode;

    // Ja retorna fazendo o parse pra JSON
    if (responseStatus == 200) {
      var json = response.body;
      (print('$responseStatus'));
      return testeFromJson(json);
    } else {
      (print('$responseStatus'));
      return null;
    }
  }
}
