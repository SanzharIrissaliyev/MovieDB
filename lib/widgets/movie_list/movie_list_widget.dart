import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:themovedb/resources/resources.dart';

class Movie {
  final int id;
  final String imageName;
  final String title;
  final String time;
  final String description;

  Movie({
    required this.id,
    required this.imageName,
    required this.title,
    required this.time,
    required this.description,
  });
}

class MovieListWidget extends StatefulWidget {
  MovieListWidget({Key? key}) : super(key: key);

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  // Massiv filma
  final _movies = [
    Movie(
      id: 1,
      imageName: AppImages.film1,
      title: 'Затерянный город',
      time: 'March 24, 2022',
      description:
          'Блистательная затворница Лоретта Сейдж пишет популярные любовно-приключенческие романы. События в них непременно разворачиваются в экзотических местах, а главный герой — красавчик и мечта героинь Дэш, которого в жизни воплощает модель с обложки Алан. Во время турне-презентации нового бестселлера Лоретту похищает эксцентричный миллиардер, уверенный, что она сможет привести его к сокровищам древнего затерянного города из ее последней книги. Алан решает доказать, что может быть героем в реальной жизни, а не только на страницах книг, и отправляется Лоретте на выручку. Так странная парочка ввязывается в эпичное приключение в самом сердце джунглей и должна действовать сообща, если хочет пережить дикие испытания и найти сокровище, пока оно не затерялось навсегда.',
    ),
    Movie(
      id: 2,
      imageName: AppImages.film2,
      title: 'Фантастические твари: Тайны Дамблдора',
      time: 'April  6, 2022',
      description:
          'Профессор Альбус Дамблдор узнает, что могущественный темный волшебник Геллерт Грин-де-Вальд планирует захватить власть над миром. Понимая, что не сможет остановить его в одиночку, Дамблдор просит магозоолога Ньюта Саламандера возглавить команду из выдающихся волшебников и одного отважного магла-пекаря. Им предстоят невероятно опасные приключения, встреча со старыми и укрощение новых магических существ и борьба со сторонниками Грин-де-Вальда, которых становится все больше. Но какая роль в этой миссии уготована самому Дамблдору?',
    ),
    Movie(
      id: 3,
      imageName: AppImages.film3,
      title: 'Соник 2 в кино',
      time: 'March 30, 2022',
      description:
          'Поселившись в Грин Хилз, Соник стремится доказать, что у него есть все задатки настоящего героя. И геройское испытание не заставляет себя долго ждать: злодейский доктор Роботник вновь строит козни. На этот раз — с загадочным напарником Наклзом. Вместе они разыскивают бесценный изумруд, в котором заключены силы, способные уничтожать целые цивилизации. Соник объединяется с лисенком Тейлзом, чтобы отправиться в кругосветное путешествие и найти изумруд до того, как он попадет в плохие руки.',
    ),
    Movie(
      id: 4,
      imageName: AppImages.film4,
      title: 'Доктор Стрэндж: В мультивселенной безумия',
      time: 'May  4, 2022',
      description:
          'Продолжение истории величайшего мага Земли доктора Стивена Стрэнджа. С помощью старых и новых мистических союзников Стрэндж отправляется в мультивселенную, чтобы сразиться с новым таинственным противником.',
    ),
    Movie(
      id: 5,
      imageName: AppImages.film5,
      title: 'Анчартед: На картах не значится',
      time: 'February 10, 2022',
      description:
          'Нейтан Дрейк и Виктор «Салли» Салливан, два искателя приключений, отправляются на поиски величайшего сокровища мира. Кроме того, они надеются найти улики, которые приведут их к давно потерянному брату Нейтана.',
    ),
    Movie(
      id: 6,
      imageName: AppImages.film6,
      title: 'Варяг',
      time: 'April  7, 2022',
      description:
          'Фильм основан на саге об Амлете из древнескандинавской хроники, записанной Саксоном Грамматиком. Сюжет рассказывает о том, как викинг Фьёльнир убивает своего брата, конунга Хорвендила, и берёт в жёны его супругу Гудрун. Амлет, сын Хорвендила, скрывается и клянётся отомстить убийце отца. Когда Амлет становится старше, он объединяется со славянской ведьмой Ольгой, похищенной викингами, и стремится вернуться домой, чтобы убить Фьёльнира.',
    ),
    Movie(
      id: 7,
      imageName: AppImages.film7,
      title: 'Бэтмен',
      time: 'March  1, 2022',
      description:
          'После двух лет поисков правосудия на улицах Готэма для своих сограждан Бэтмен становится олицетворением беспощадного возмездия. Когда в городе происходит серия жестоких нападений на представителей элиты, загадочные улики приводят Брюса Уэйна в самые темные закоулки преступного мира, где он встречает Женщину-Кошку, Пингвина, Кармайна Фальконе и Загадочника. Теперь под прицелом оказывается сам Бэтмен, которому предстоит отличить друга от врага и восстановить справедливость во имя Готэма.',
    ),
    Movie(
      id: 8,
      imageName: AppImages.film8,
      title: 'Человек-паук: Нет пути домой',
      time: 'December 15, 2021',
      description:
          'Жизнь и репутация Питера Паркера оказываются под угрозой, поскольку Мистерио раскрыл всему миру тайну личности Человека-паука. Пытаясь исправить ситуацию, Питер обращается за помощью к Стивену Стрэнджу, но вскоре всё становится намного опаснее.',
    ),
    Movie(
      id: 9,
      imageName: AppImages.film9,
      title: 'Плохие парни',
      time: 'March 17, 2022',
      description:
          'Мир еще не видел столь искусных авантюристов: ловкий карманник Мистер Волк, опытный взломщик сейфов Мистер Змей, хладнокровный мастер маскировки Мистер Акула, вспыльчивый и мускулистый Мистер Пиранья, а также остроумная хакер высшего класса Мисс Тарантула. Однако даже самые умные преступники иногда допускают ошибки. Чтобы спастись от неминуемый тюрьмы, главарь банды Мистер Волк вынужден идти на крайние меры: «Плохие парни» должны измениться в лучшую сторону. Или сделать вид? Но когда новый злодей угрожает городу, сможет ли Мистер Волк убедить остальных действительно стать… хорошими ребятами?',
    ),
    Movie(
      id: 10,
      imageName: AppImages.film10,
      title: 'Наёмник',
      time: 'March 10, 2022',
      description:
          'Служба в армии с детства была мечтой Джеймса Рида, а зеленый берет — предметом гордости. Но после полученных ранений он остается не у дел: в мирном обществе ему нет места, а состояние здоровья приходится поддерживать медикаментами, не всегда самыми «чистыми». И когда подворачивается возможность снова взяться за старое ремесло, бывший солдат не медлит. Но теперь выбор, на кого направить оружие, лежит полностью на нем.',
    ),
    Movie(
        id: 11,
        imageName: AppImages.film11,
        title: 'Флешбэк',
        time: 'April 29, 2022',
        description:
            'Он был первоклассным киллером всю жизнь.  Но стоило ему, следуя своему моральному кодексу, отказаться от заказа, на него объявили охоту.  Он готов применить все свои навыки, чтобы заставить виновных заплатить, но постепенно угасающая память путает ему все карты...'),
  ];

  var _filteredMovies = <Movie>[];

  // Funcsiya poiska
  final _searchController = TextEditingController();

  void _searchMovies() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _filteredMovies = _movies.where((Movie movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filteredMovies = _movies;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _filteredMovies = _movies;
    _searchController.addListener(_searchMovies);
  }

  void _onMovieTap(int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      '/main_screen/movie_details',
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: EdgeInsets.only(top: 60),
          //Avtozakrit klaviaturu
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: _filteredMovies.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            final movie = _filteredMovies[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black.withOpacity(0.2)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Row(
                      children: [
                        Image(image: AssetImage(movie.imageName)),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Text(
                                movie.title,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              Text(
                                movie.time,
                                style: TextStyle(color: Colors.grey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 20),
                              Text(
                                movie.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),

                  //Effekt najatiya
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => _onMovieTap(index),
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        //Poisk

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Поиск',
              filled: true,
              fillColor: Colors.white.withAlpha(235),
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            ),
          ),
        ),
      ],
    );
  }
}
