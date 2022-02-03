///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Определить объекты метаданных, в модулях менеджеров которых предусмотрена возможность параметризации 
// алгоритма поиска дублей с помощью экспортных процедур ПараметрыПоискаДублей, ПриПоискеДублей 
// и ВозможностьЗаменыЭлементов.
//
// Параметры:
//   Объекты - Соответствие из КлючИЗначение - объекты, в модулях менеджеров которых размещены экспортные процедуры:
//       * Ключ     - Строка - полное имя объекта метаданных, подключенного к подсистеме "Поиск и удаление дублей".
//                              Например, "Справочник.Контрагенты".
//       * Значение - Строка - имена экспортных процедур-обработчиков, определенных в модуле менеджера:
//                              "ПараметрыПоискаДублей",
//                              "ПриПоискеДублей",
//                              "ВозможностьЗаменыЭлементов".
//                              Каждое имя должно начинаться с новой строки.
//                              Если указана пустая строка, то в модуле менеджера определены все процедуры.
//
// Пример:
//  1. В справочнике определены все процедуры-обработчики:
//  Объекты.Вставить(Метаданные.Справочники.Контрагенты.ПолноеИмя(), "");
//
//  2. Определены только процедуры ПараметрыПоискаДублей и ПриПоискеДублей:
//  Объекты.Вставить(Метаданные.Справочники.ЗадачиПроекта.ПолноеИмя(), "ПараметрыПоискаДублей
//                   |ПриПоискеДублей");
//
Процедура ПриОпределенииОбъектовСПоискомДублей(Объекты) Экспорт
	
	
	
КонецПроцедуры

// Определить объекты, в формах списков которых
// будут выведены команды объединения дублей и замены ссылок
// см. ПоискИУдалениеДублейКлиент.ОбъединитьВыделенные и ПоискИУдалениеДублейКлиент.ЗаменитьВыделенные
// 
// Параметры:
//     Объекты - Массив из ОбъектМетаданных
//
// Пример:
//	Объекты.Добавить(Метаданные.Справочники._ДемоНоменклатура);
//	Объекты.Добавить(Метаданные.Справочники._ДемоКонтрагенты);
//
Процедура ПриОпределенииОбъектовСКомандамиОбъединенияДублейЗаменыСсылок(Объекты) Экспорт

	

КонецПроцедуры

// Позволяет реализовать дополнительные проверки для пар ссылок на возможность замены одной на другую.
// Например, можно запретить заменять друг на друга номенклатуру разных видов.
// Базовые проверки на запрет замены групп и ссылок разных типов производятся предварительно перед вызовом 
// этого обработчика.
//
// Параметры:
//     ИмяОбъектаМетаданных - Строка - полное имя ссылочного объекта метаданных, замена элементов которого производится.
//                                     Например, "Справочник.Контрагенты".
//     ПарыЗамен - Соответствие из КлючИЗначение:
//       * Ключ - ЛюбаяСсылка - что будет заменено
//       * Значение - ЛюбаяСсылка - на что будет заменено
//     ПараметрыЗамены - Структура - действие с заменяемыми элементами:
//        * СпособУдаления - Строка - может принимать значения:
//                         "Непосредственно" - Если после замены ссылка нигде не используется,
//                                             то она будет удалена непосредственно;
//                         "Пометка"         - Если после замены ссылка не используется, то
//                                             она будет помечена на удаление.
//                         При других значениях заменяемая ссылка не будет изменена.
//     НедопустимыеЗамены - Соответствие из КлючИЗначение:
//       * Ключ - ЛюбаяСсылка - заменяемая ссылка
//       * Значение - Строка - описание, почему замена недопустима. Если все замены допустимы, то возвращается пустое соответствие
//
Процедура ПриОпределенииВозможностиЗаменыЭлементов(Знач ИмяОбъектаМетаданных, Знач ПарыЗамен, Знач ПараметрыЗамены, НедопустимыеЗамены) Экспорт
	
КонецПроцедуры

// Вызывается для определения прикладных параметров поиска дублей.
// Например, для справочника номенклатуры можно запретить замену друг на друга номенклатуры разных видов.
//
// Параметры:
//     ИмяОбъектаМетаданных - Строка - полное имя ссылочного объекта метаданных, замена элементов которого производится.
//                                     Например, "Справочник.Контрагенты".
//     ПараметрыПоиска - Структура - параметры поиска дублей (выходной параметр):
//       * ПравилаПоиска - ТаблицаЗначений - правила сравнения для объектов:
//         ** Реквизит - Строка - имя реквизита для сравнения.
//         ** Правило  - Строка - правило сравнения: "Равно" - на точное равенство, "Подобно" - подобные строки,
//                                "" - не сравнивать.
//       * СравнениеСтрокНаПодобие - Структура - правила нечеткого поиска строк (сравнение строк на подобие):
//          ** ПроцентСовпаденияСтрок   - Число - минимальный процент совпадения для строк (от 0 до 100).
//                Процент совпадения рассчитывается на основе расстояния Левенштейна-Дамерау с учетом распространенных 
//                видов ошибок: разный регистр символов, случайная вставка, удаление одного символа, 
//                замена одного символа на другой. Также порядок слов в строках не имеет значения, 
//                т.е. например строки "первое второе слово"  и "слово второе первое" имеют 100% совпадение.
//                По умолчанию, 90.
//          ** ПроцентСовпаденияНебольшихСтрок - Число - минимальный процент совпадения для небольших строк (от 0 до 100).
//                По умолчанию, 80.
//          ** ДлинаНебольшихСтрок - Число - если длина строки меньше или равна заданной, то строка считается небольшой.
//                По умолчанию, 30.
//          ** СловаИсключения - Массив из Строка - список слов, которые следует пропускать при сравнении на подобие.
//                               Например, для организаций и контрагентов это могут быть: ИП, ГУП, ООО, ОАО и т.д.
//       * КомпоновщикОтбора - КомпоновщикНастроекКомпоновкиДанных - инициализированный компоновщик для 
//                             предварительного отбора. Может быть изменен, например, для усиления отборов.
//       * ОграниченияСравнения - Массив из Структура - описания прикладных правил-ограничений:
//         ** Представление      - Строка - текстовое описание правила-ограничения.
//         ** ДополнительныеПоля - Строка - список реквизитов через запятую, значения которых
//                                          необходимы для анализа в ПриПоискеДублей.
//       * КоличествоЭлементовДляСравнения - Число - количество кандидатов в дубли, передаваемых одним вызовом
//                                                   в параметр ТаблицаКандидатов обработчика ПриПоискеДублей.
//                                                   По умолчанию, 1500.
//     ДополнительныеПараметры - Произвольный - значение, переданное при вызове ОбщегоНазначения.НайтиДублиЭлементов.
//                               При вызове из обработки ПоискИУдалениеДублей равно Неопределено.
//     СтандартнаяОбработка - Булево - указать Ложь, если заполнен выходной параметр ПараметрыПоиска и необходим вызов
//                            обработчика ПриПоискеДублей. По умолчанию Истина.
//
Процедура ПриОпределенииПараметровПоискаДублей(Знач ИмяОбъектаМетаданных, ПараметрыПоиска, Знач ДополнительныеПараметры,
	СтандартнаяОбработка) Экспорт
	
	
	
КонецПроцедуры

// Вызывается при поиске дублей по правилам, заданным в ПриОпределенииПараметровПоискаДублей.
//
// Параметры:
//     ИмяОбъектаМетаданных - Строка - полное имя ссылочного объекта метаданных, замена элементов которого производится.
//                                     Например, "Справочник.Контрагенты".
//     ТаблицаКандидатов - ТаблицаЗначений - сведения о найденных кандидатах в дубли согласно заданным правилам поиска:
//         * Ссылка1  - ЛюбаяСсылка - ссылка на первый элемент.
//         * Ссылка2  - ЛюбаяСсылка - ссылка на второй элемент.
//         * ЭтоДубли - Булево      - признак того, что кандидаты являются дублями. По умолчанию Ложь. 
//                                    Может быть установлено в Истина, чтобы отметить дубли.
//         * Поля1    - Структура   - содержит поля Код, Наименование и дополнительные поля первого элемента,
//                                    указанные в параметре ПараметрыПоиска.ОграниченияСравнения.ДополнительныеПоля
//                                    обработчика ПриОпределенииПараметровПоискаДублей.
//         * Поля2    - Структура   - содержит аналогичные поля второго элемента.
//     ДополнительныеПараметры - Произвольный - значение, переданное при вызове ОбщегоНазначения.НайтиДублиЭлементов.
//                               При вызове из обработки ПоискИУдалениеДублей равно Неопределено.
//
Процедура ПриПоискеДублей(Знач ИмяОбъектаМетаданных, ТаблицаКандидатов, ДополнительныеПараметры) Экспорт
	
КонецПроцедуры

#КонецОбласти
