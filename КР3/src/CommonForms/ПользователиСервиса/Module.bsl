///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	УстановитьУсловноеОформление();
	
	// Форма недоступна пока подготовка не закончена.
	Доступность = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если ПарольПользователяСервиса = Неопределено Тогда
		Отказ = Истина;
		СтандартныеПодсистемыКлиент.УстановитьХранениеФормы(ЭтотОбъект, Истина);
		ПодключитьОбработчикОжидания("ЗапроситьПарольДляАутентификацииВСервисе", 0.1, Истина);
	Иначе
		ПодготовитьФорму();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура УстановитьВсе(Команда)
	
	Для каждого СтрокаТаблицы Из ПользователиСервиса Цикл
		Если СтрокаТаблицы.Доступ Тогда
			Продолжить;
		КонецЕсли;
		СтрокаТаблицы.Добавить = Истина;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура СнятьВсе(Команда)
	
	Для каждого СтрокаТаблицы Из ПользователиСервиса Цикл
		СтрокаТаблицы.Добавить = Ложь;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьВыбранныхПользователей(Команда)
	
	ДобавитьВыбранныхПользователейНаСервере();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьУсловноеОформление()

	УсловноеОформление.Элементы.Очистить();

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ПользователиСервисаДобавить.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ПользователиСервиса.Доступ");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;

	Элемент.Оформление.УстановитьЗначениеПараметра("Доступность", Ложь);

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ПользователиСервисаДобавить.Имя);

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ПользователиСервисаИмя.Имя);

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ПользователиСервисаПолноеИмя.Имя);

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ПользователиСервисаДоступ.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ПользователиСервиса.Доступ");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветФона", ЦветаСтиля.ТекстЗапрещеннойЯчейкиЦвет);

КонецПроцедуры

&НаКлиенте
Процедура ЗапроситьПарольДляАутентификацииВСервисе()
	
	СтандартныеПодсистемыКлиент.УстановитьХранениеФормы(ЭтотОбъект, Ложь);
	
	ПользователиСлужебныйКлиент.ЗапроситьПарольДляАутентификацииВСервисе(
		Новый ОписаниеОповещения("ПриОткрытииПродолжение", ЭтотОбъект));
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытииПродолжение(НовыйПарольПользователяСервиса, Контекст) Экспорт
	
	Если НовыйПарольПользователяСервиса <> Неопределено Тогда
		ПарольПользователяСервиса = НовыйПарольПользователяСервиса;
		Открыть();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПодготовитьФорму()
	
	ПользователиСлужебныйВМоделиСервиса.ПолучитьДействияСПользователемСервиса(
		Справочники.Пользователи.ПустаяСсылка());
		
	ТаблицаПользователей = ПользователиСлужебныйВМоделиСервиса.ПолучитьПользователейСервиса(
		ПарольПользователяСервиса);
		
	Для каждого ИнформацияОПользователе Из ТаблицаПользователей Цикл
		СтрокаПользователя = ПользователиСервиса.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаПользователя, ИнформацияОПользователе);
	КонецЦикла;
	
	Доступность = Истина;
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьВыбранныхПользователейНаСервере()
	
	УстановитьПривилегированныйРежим(Истина);
	
	Счетчик = 0;
	КоличествоСтрок = ПользователиСервиса.Количество();
	Для Счетчик = 1 По КоличествоСтрок Цикл
		СтрокаТаблицы = ПользователиСервиса[КоличествоСтрок - Счетчик];
		Если НЕ СтрокаТаблицы.Добавить Тогда
			Продолжить;
		КонецЕсли;
		
		ПользователиСлужебныйВМоделиСервиса.ПредоставитьДоступПользователюСервиса(
			СтрокаТаблицы.Идентификатор, ПарольПользователяСервиса);
		
		ПользователиСервиса.Удалить(СтрокаТаблицы);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
