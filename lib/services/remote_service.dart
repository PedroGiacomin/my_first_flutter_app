import 'package:my_first_flutter_app/models/post.dart';
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
}
