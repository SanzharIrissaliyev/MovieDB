import 'package:flutter/material.dart';
import 'package:themovedb/domain/data_providers/session_data_providers.dart';
import 'package:themovedb/libruary/widgets/inherited/provider.dart';
import 'package:themovedb/ui/widgets/main_screen/main_screen_model.dart';
import 'package:themovedb/ui/widgets/movie_list/movie_list_model.dart';

import '../../../resources/resources.dart';

import '../movie_list/movie_list_widget.dart';
import '../news_list/main_news_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;
  final movielistModel = MovieListModel();
  void onSelectedTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    movielistModel.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<MainScreenModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Image(
          image: AssetImage(AppImages.qwedf),
          height: 40,
          width: 60,
        ),
        actions: [
          IconButton(
            onPressed: () => SessionDataProvider().setSessionId(null),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: IndexedStack(
        //pozisia skrollera
        index: _selectedTab,
        children: [
          const MainNewsWidget(),
          NotifierProvider(
            model: movielistModel,
            child: const MovieListWidget(),
          ),
          const Text(
            "Сериалы",
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Новости',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_filter),
            label: 'Фильмы',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv_rounded),
            label: 'Сериалы',
          ),
        ],
        onTap: onSelectedTab,
      ),
    );
  }
}
