import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../pokemon_data.dart';

class DetailPokemonPage extends StatefulWidget {
  final PokemonData pokemon;
  const DetailPokemonPage({super.key, required this.pokemon});

  @override
  State<DetailPokemonPage> createState() => _DetailPokemonPageState();
}

class _DetailPokemonPageState extends State<DetailPokemonPage> {
  var _isFavorited = false;
  @override
  Widget build(BuildContext context) {
    var prevEvolution = widget.pokemon.prevEvolution.isNotEmpty
        ? widget.pokemon.nextEvolution.join(", ")
        : "None";

    var nextEvolution = widget.pokemon.nextEvolution.isNotEmpty
        ? widget.pokemon.nextEvolution.join(", ")
        : "None";

    var iconFavorited = _isFavorited
        ? const Icon(Icons.favorite)
        : const Icon(Icons.favorite_border);

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Pokemon ${widget.pokemon.name}"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isFavorited = !_isFavorited;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _isFavorited
                        ? "Added ${widget.pokemon.name} to favorite"
                        : "Removed ${widget.pokemon.name} from favorite",
                  ),
                  duration: const Duration(milliseconds: 500),
                ),
              );
            },
            icon: iconFavorited,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Image.network(widget.pokemon.image, width: 200, height: 200),
              const SizedBox(height: 10),
              Text(widget.pokemon.name,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              const Text("Type", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("[${widget.pokemon.type.join(", ")}]"),
              const SizedBox(height: 15),
              const Text("Weakness",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text("[${widget.pokemon.weakness.join(", ")}]"),
              const SizedBox(height: 15),
              const Text("Previus Evolution",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text("[$prevEvolution]"),
              const SizedBox(height: 15),
              const Text("Next Evolution",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text("[$nextEvolution]"),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          try {
            _launchUrl(widget.pokemon.wikiUrl);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Failed to open url"),
              ),
            );
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.travel_explore),
      ),
    );
  }
}

Future<void> _launchUrl(String urlString) async {
  var url = Uri.parse(urlString);
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}
