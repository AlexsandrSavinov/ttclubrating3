///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Возвращает описание колонок табличной части или таблицы значений.
//
// Параметры:
//  Таблица - ТаблицаЗначений - ОписаниеТабличнойЧасти с колонками.
//          - Строка - для получения списка колонок табличной части
//              необходимо указать его полное имя строкой, как в метаданных, например "Документы.СчетНаОплату.ТабличныеЧасти.Товары".
//  Колонки - Строка - список извлекаемых колонок, разделенный запятыми. Например: "Номер, Товар, Количество".
// 
// Возвращаемое значение:
//   Массив из см. ЗагрузкаДанныхИзФайлаКлиентСервер.ОписаниеКолонкиМакета.
//
Функция СформироватьОписаниеКолонок(Таблица, Колонки = Неопределено) Экспорт
	
	ИзвлекатьНеВсеКолонки = Ложь;
	Если Колонки <> Неопределено Тогда
		СписокКолонокДляИзвлечения = СтрРазделить(Колонки, ",", Ложь);
		ИзвлекатьНеВсеКолонки = Истина;
	КонецЕсли;
	
	СписокКолонок = Новый Массив;
	Если ТипЗнч(Таблица) = Тип("ДанныеФормыКоллекция") Тогда
		КопияТаблицы = Таблица;
		ВнутренняяТаблица = КопияТаблицы.Выгрузить();
		ВнутренняяТаблица.Колонки.Удалить("ИсходныйНомерСтроки");
		ВнутренняяТаблица.Колонки.Удалить("НомерСтроки");
	Иначе
		ВнутренняяТаблица= Таблица;
	КонецЕсли;
	
	Позиция = 1;
	Если ТипЗнч(ВнутренняяТаблица) = Тип("ТаблицаЗначений") Тогда
		Для каждого Колонка Из ВнутренняяТаблица.Колонки Цикл
			Если ИзвлекатьНеВсеКолонки И СписокКолонокДляИзвлечения.Найти(Колонка.Имя) = Неопределено Тогда
				Продолжить;
			КонецЕсли;
			Подсказка = "";
			Для каждого ТипКолонки Из Колонка.ТипЗначения.Типы() Цикл
				ОбъектМетаданных = Метаданные.НайтиПоТипу(ТипКолонки);
				
				Если ОбъектМетаданных <> Неопределено Тогда
					Подсказка = Подсказка + ОбъектМетаданных.Комментарий + Символы.ПС;
					
					Если ОбщегоНазначения.ЭтоПеречисление(ОбъектМетаданных) Тогда
						ПодсказкаНабор = Новый Массив;
						ПодсказкаНабор.Добавить(НСтр("ru='Доступные варианты:'"));
						Для каждого ВариантПеречисления Из ОбъектМетаданных.ЗначенияПеречисления Цикл
							ПодсказкаНабор.Добавить(ВариантПеречисления.Представление());
						КонецЦикла;
						Подсказка = СтрСоединить(ПодсказкаНабор, Символы.ПС);
					КонецЕсли;
					
				КонецЕсли;
			КонецЦикла;
			
			НоваяКолонка = ЗагрузкаДанныхИзФайлаКлиентСервер.ОписаниеКолонкиМакета(Колонка.Имя, Колонка.ТипЗначения, Колонка.Заголовок, Колонка.Ширина, Подсказка);
			
			НоваяКолонка.Позиция = Позиция;
			СписокКолонок.Добавить(НоваяКолонка);
			Позиция = Позиция + 1;
		КонецЦикла;
	ИначеЕсли ТипЗнч(ВнутренняяТаблица) = Тип("Строка") Тогда
		Объект = Метаданные.НайтиПоПолномуИмени(ВнутренняяТаблица); // ОбъектМетаданныхСправочник, ОбъектМетаданныхДокумент 
		Для каждого Колонка Из Объект.Реквизиты Цикл
			Если ИзвлекатьНеВсеКолонки И СписокКолонокДляИзвлечения.Найти(Колонка.Имя) = Неопределено Тогда
				Продолжить;
			КонецЕсли;
			НоваяКолонка = ЗагрузкаДанныхИзФайлаКлиентСервер.ОписаниеКолонкиМакета(Колонка.Имя, Колонка.Тип, Колонка.Представление());
			НоваяКолонка.Подсказка = Колонка.Подсказка;
			НоваяКолонка.Ширина = 30;
			НоваяКолонка.Позиция = Позиция;
			СписокКолонок.Добавить(НоваяКолонка);
			Позиция = Позиция + 1;
		КонецЦикла;
	КонецЕсли;
	Возврат СписокКолонок;
КонецФункции

// Настройки загрузки новых и существующих элементов.
// 
// Возвращаемое значение:
//  Структура: 
//    * СоздаватьНовые - Булево
//    * ОбновлятьСуществующие - Булево
//
Функция НастройкиЗагрузкиДанных() Экспорт
	
	ПараметрыЗагрузки = Новый Структура();
	ПараметрыЗагрузки.Вставить("СоздаватьНовые", Ложь);
	ПараметрыЗагрузки.Вставить("ОбновлятьСуществующие", Ложь);
	Возврат ПараметрыЗагрузки;
	
КонецФункции

// Добавляет в таблицу загружаемых данных служебные колонки.
// Список колонок таблицы динамический и формируется на основе макета загружаемых данных.
// В возвращаемом значении описаны только служебные колонки, которые присутствуют всегда.
// 
// Параметры:
//  ЗагружаемыеДанные - ТаблицаЗначений
//  ОписаниеТипаОбъектаСопоставления - ОписаниеТипов -  описание типа объекта сопоставления.
//  ЗаголовокКолонкиОбъектаСопоставления - Строка - заголовок колонки объекта сопоставления.
// 
// Возвращаемое значение:
//  ТаблицаЗначений:
//       * СопоставленныйОбъект         - СправочникСсылка - ссылка на сопоставленный объект.
//       * РезультатСопоставленияСтроки - Строка       - статус загрузки, возможны варианты: Создан, Обновлен, Пропущен.
//       * ОписаниеОшибки               - Строка       - расшифровка ошибки загрузки данных.
//       * Идентификатор                - Число        - уникальный номер строки
//       * СписокНеоднозначностей       - СписокЗначений -список неоднозначностей возникших при загрузке данных.
//
Функция ОписаниеЗагружаемыхДанныхДляСправочников(ЗагружаемыеДанные, ОписаниеТипаОбъектаСопоставления, ЗаголовокКолонкиОбъектаСопоставления) Экспорт
		
	ЗагружаемыеДанные.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("Число"), НСтр("ru = 'п/п'"));
	ЗагружаемыеДанные.Колонки.Добавить("ОбъектСопоставления", ОписаниеТипаОбъектаСопоставления, ЗаголовокКолонкиОбъектаСопоставления);
	ЗагружаемыеДанные.Колонки.Добавить("РезультатСопоставленияСтроки", Новый ОписаниеТипов("Строка"), НСтр("ru = 'Результат'"));
	ЗагружаемыеДанные.Колонки.Добавить("ОписаниеОшибки", Новый ОписаниеТипов("Строка"), НСтр("ru = 'Причина'"));
	ЗагружаемыеДанные.Колонки.Добавить("СписокНеоднозначностей", Новый ОписаниеТипов("СписокЗначений"), "СписокНеоднозначностей");
	
	Возврат ЗагружаемыеДанные;
	
КонецФункции

// Создать таблицу со списком неоднозначностей для которых в ИБ имеется несколько подходящих вариантов данных.
// 
// Возвращаемое значение:
//  ТаблицаЗначений:
//     * Колонка       - Строка - имя колонки, в которой была обнаружена неоднозначность;
//     * Идентификатор - Число  - идентификатор строки, в которой была обнаружена неоднозначность.
//
Функция НовыйСписокНеоднозначностей() Экспорт
	
	СписокНеоднозначностей = Новый ТаблицаЗначений;
	СписокНеоднозначностей.Колонки.Добавить("Идентификатор");
	СписокНеоднозначностей.Колонки.Добавить("Колонка");
	
	Возврат СписокНеоднозначностей;
КонецФункции

// Возвращает таблицу, извлеченную из временного хранилища для сопоставления загружаемых данных с данными в программе.
// Список колонок извлекаемой таблицы динамический и формируется на основе макета загружаемых данных.
// В возвращаемом значении описана только служебная колонка, которая присутствуют всегда.
// 
// Параметры:
//  АдресРезультата - Строка - адрес во временном хранилища 
// 
// Возвращаемое значение:
//  ТаблицаЗначений:
//     * СопоставленныйОбъект - СправочникСсылка - ссылка на сопоставленный объект. Заполняется внутри процедуры.
//
Функция ТаблицаСопоставления(АдресРезультата) Экспорт
	
	ТаблицаСопоставления = ПолучитьИзВременногоХранилища(АдресРезультата);
	Возврат ТаблицаСопоставления;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции


Процедура ДобавитьСтатистическуюИнформацию(ИмяОперации, Значение = 1, Комментарий = "") Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ЦентрМониторинга") Тогда
		МодульЦентрМониторинга = ОбщегоНазначения.ОбщийМодуль("ЦентрМониторинга");
		ИмяОперации = "ЗагрузкаДанныхИзФайла." + ИмяОперации;
		МодульЦентрМониторинга.ЗаписатьОперациюБизнесСтатистики(ИмяОперации, Значение, Комментарий);
	КонецЕсли;
	
КонецПроцедуры

// Сообщает все требуемые сведения о процедуре загрузки данных из файла.
//
// Возвращаемое значение:
//  Структура:
//    * Заголовок - Строка - представление в списке вариантов загрузки и в заголовке окна.
//    * ТипДанныхКолонки - Соответствие из КлючИЗначение:
//        ** Ключ - Строка - имя колонки таблицы.
//        ** Значение - ОписаниеТипов - описание типа данных колонки.
//    * ИмяМакетаСШаблоном - Строка - название макета со структурой данных(необязательный
//                                    параметр, значение по умолчанию - "ЗагрузкаДанныхИзФайла").
//    * ОбязательныеКолонкиМакета - Массив из Строка - содержит список обязательных полей для заполнения.
//    * ЗаголовокКолонкиСопоставления - Строка - представление колонки сопоставления в шапке таблицы
//                                                    сопоставления данных(необязательный параметр, значение по
//                                                    умолчанию формируются - "Справочник: <синоним справочника>").
//    * ПолноеИмяОбъекта - Строка - полное имя объекта, как в метаданных. Например Справочник.Партнеры.
//    * ПредставлениеОбъекта - Строка - представление объекта в таблице сопоставления данных. Например, "Клиент".
//    * ТипЗагрузки - Строка - варианты загрузки данных (служебный).
//
Функция ПараметрыЗагрузкиИзФайла(ИмяОбъектаСопоставления) Экспорт
	
	МетаданныеОбъекта = Метаданные.НайтиПоПолномуИмени(ИмяОбъектаСопоставления);
	
	ОбязательныеКолонкиМакета = Новый Массив;
	Для каждого Реквизит Из МетаданныеОбъекта.Реквизиты Цикл
		Если Реквизит.ПроверкаЗаполнения=ПроверкаЗаполнения.ВыдаватьОшибку Тогда
			ОбязательныеКолонкиМакета.Добавить(Реквизит.Имя);
		КонецЕсли;
	КонецЦикла;
		
	ПараметрыПоУмолчанию = Новый Структура;
	ПараметрыПоУмолчанию.Вставить("Заголовок", МетаданныеОбъекта.Представление());
	ПараметрыПоУмолчанию.Вставить("ОбязательныеКолонки", ОбязательныеКолонкиМакета);
	ПараметрыПоУмолчанию.Вставить("ТипДанныхКолонки", Новый Соответствие);
	ПараметрыПоУмолчанию.Вставить("ТипЗагрузки", "");
	ПараметрыПоУмолчанию.Вставить("ПолноеИмяОбъекта", ИмяОбъектаСопоставления);
	ПараметрыПоУмолчанию.Вставить("ПредставлениеОбъекта", МетаданныеОбъекта.Представление());
	
	Возврат ПараметрыПоУмолчанию;
	
КонецФункции

#КонецОбласти
