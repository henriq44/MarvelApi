import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_test/model/character_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  bool isError = false; 

  List<CharacterModel> listCharacters = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: isLoading ? const CircularProgressIndicator() :  isError ? _stateError() :  _stateLoadCharacters(context),
          
        ),
        floatingActionButton: FloatingActionButton (
          onPressed: () async {
            listCharacters = await getCharacters();
          },
          child: const Icon(Icons.add)
        ),
        );
  }

Widget _stateError (){
  return Column(
            children: [
              const Text('Ocorreu um erro'), 
              ElevatedButton(onPressed:() async {
                await getCharacters();}, child: const Text('Tentar novamente'))
            ],
          );
}

Widget _stateLoadCharacters (context) {
  return ListView.builder(
    itemCount: listCharacters.length,
    itemBuilder: (context, index){
      return Card(
        child: Column(
          children: [
             Text(listCharacters [index].name,  style: const TextStyle(fontSize: 24)),
             Text(listCharacters[index].description, style: const TextStyle(fontSize: 12)),
            Image.network('${listCharacters[index].thumbnailModel.path}.${listCharacters[index].thumbnailModel.extension}', fit: BoxFit.fill),
          ],
        ), 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
      );
    }
  );
}




  Future<List<CharacterModel>> getCharacters() async {
    var url = Uri.parse(
        'https://gateway.marvel.com/v1/public/characters?apikey=bbc8698be2f66bacea8539c4228f27e7&hash=9033d3960f625a607ed18eeb6d276617&ts=1&limit=50');
    setState(() {
      isLoading = true;
    });

    var response = await http.get(url);
    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 200) {
      setState(() {
      isError = false;
    });
      final result = json.decode(response.body);
      return List.from(result['data']['results'])
          .map((data) => CharacterModel.fromJson(data))
          .toList();
    } else {
      setState(() {
      isError = true;
    });
      throw Exception();
    }
  }

}

/*
Padding(
  padding: EdgeInsets.symmetric(vertical:24),
  child: Outlinebutton(
    onPressed: () => context.read<AuthService>().logout(),
    style: Outlinebutton.styleFrom(
      primary:Colors.red,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding:EdgeInsets.all(16.0),
          chidl: Text(
            'Sair do App',
            Style: TextStyle(fontSize: 18),
          )
        )
      ]
    )
  )
) 
*/
