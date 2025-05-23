import 'package:flutter/material.dart';
import 'package:petcare/constants/route_constants.dart';
import 'package:petcare/models/feed_model.dart';
import 'package:petcare/pages/loading_page.dart';
import 'package:petcare/providers/petcare_database_provider.dart';
import 'package:petcare/repositories/feed_repository.dart';
import 'package:petcare/themes/pet_care_theme.dart';
import 'package:petcare/widgets/add_button.dart';
import 'package:petcare/widgets/feed_card.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late FeedRepository _feedRepository;
  late List<FeedModel> _list;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() async {
    setState(() {
      _loading = true;
    });

    var provider = Provider.of<PetcareDatabaseProvider>(context, listen: false);
    var database = provider.getDatabase();

    var feedRepository = FeedRepository(database);
    var feed = await feedRepository.list();

    setState(() {
      _feedRepository = feedRepository;
      _list = feed;
      _loading = false;
    });
  }

  _delete(int id) async {
    setState(() {
      _loading = true;
    });

    await _feedRepository.delete(id);

    var feed = await _feedRepository.list();

    setState(() {
      _list = feed;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return LoadingPage();
    }

    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _floatingActionButton(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Text(
        'Histórico de Alimentação',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
      ),
      shadowColor: Colors.transparent,
    );
  }

  Widget _body(BuildContext context) {
    if (_list.isEmpty) {
      return _empty();
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      primary: false,
      shrinkWrap: true,
      itemCount: _list.length,
      itemBuilder: (context, index) {
        var feed = _list[index];
        return FeedCard(
          id: feed.id,
          petId: feed.petId,
          name: feed.name,
          weight: feed.weight,
          onDelete: (context) {
            _delete(feed.id);
          },
        );
      },
    );
  }

  Widget _empty() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),
          Image.asset(
            'assets/empty_feed.png',
            height: 368,
            width: 368,
          ),
          Text(
            'Nenhuma alimentação encontrada',
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _floatingActionButton(BuildContext context) {
    return AddButton(
      label: 'Adicionar Alimentação',
      color: PetCareTheme.orange_300,
      icon: Icons.cookie,
      onPressed: () {
        Navigator.pushNamed(context, RouteConstants.addFeed).then(
          (value) async {
            setState(() {
              _loading = true;
            });

            var feed = await _feedRepository.list();

            setState(() {
              _list = feed;
              _loading = false;
            });
          },
        );
      },
    );
  }
}
