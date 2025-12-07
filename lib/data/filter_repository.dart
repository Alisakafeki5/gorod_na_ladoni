import '../models/filter.dart';

class FilterRepository {
  Future<List<Filter>> getFilters() async {
    await Future.delayed(const Duration(milliseconds: 300)); // имитация API

    return const [
      Filter(title: 'Цена, Р', options: ['Бесплатно']),
      Filter(
        title: 'Даты',
        options: [
          'Сегодня',
          'Завтра',
          'На этой неделе',
          'На выходных',
          'На следующей неделе',
          'Выбрать дату',
        ],
      ),
      Filter(
        title: 'Время суток',
        options: [
          'Утро (6:00–12:00)',
          'День (12:00–17:00)',
          'Вечер (17:00–22:00)',
          'Ночь',
        ],
      ),
      Filter(
        title: 'Местоположение',
        options: ['Рядом со мной'],
        isSingleButton: true,
      ),
      Filter(
        title: 'Возрастная категория',
        options: ['Для детей', 'Для всех', 'Для взрослых'],
      ),
      Filter(
        title: 'Формат',
        options: [
          'Большой фестиваль',
          'Ламповая встреча',
          'Концерт',
          'Выставка',
          'В помещении',
          'На улице',
          'Мастер-класс',
        ],
      ),
      Filter(
        title: 'Площадка',
        options: [
          'Клуб',
          'Концертные залы',
          'Музеи',
          'Театры',
          'Культурные центры',
        ],
      ),
      Filter(
        title: 'Размер события',
        options: ['До 20 человек', '20–100', '100–500'],
      ),
    ];
  }
}
