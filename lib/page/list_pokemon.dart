import 'package:flutter/material.dart';
import 'package:kuis_praktikum_mobile/page/detail_pokemon.dart';
import 'package:kuis_praktikum_mobile/pokemon_data.dart';

class ListPokemonPage extends StatefulWidget {
  const ListPokemonPage({super.key});

  @override
  State<ListPokemonPage> createState() => _ListPokemonPageState();
}

class _ListPokemonPageState extends State<ListPokemonPage> {
  var listPokemonData = listPokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokedex',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search Pokemon',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  listPokemonData = listPokemon
                      .where((pokemon) => pokemon.name
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: listPokemonData.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DetailPokemonPage(
                          pokemon: listPokemonData[index],
                        );
                      }));
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Image.network(listPokemonData[index].image,
                              width: 100, height: 100),
                          Text(listPokemonData[index].name),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
