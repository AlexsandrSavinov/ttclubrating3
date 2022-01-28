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
	
	ОпределитьПоведениеВМобильномКлиенте();
	
	Параметры.Свойство("ЗаголовокГруппы", ЗаголовокГруппы);
	
	Расположение = Неопределено;
	Если Не Параметры.Свойство("Расположение", Расположение) Тогда
		ВызватьИсключение НСтр("ru = 'Не передан служебный параметр ""Расположение"".'");
	КонецЕсли;
	Если Расположение = РасположениеПоляКомпоновкиДанных.Авто Тогда
		РасположениеГруппы = "Авто";
	ИначеЕсли Расположение = РасположениеПоляКомпоновкиДанных.Вертикально Тогда
		РасположениеГруппы = "Вертикально";
	ИначеЕсли Расположение = РасположениеПоляКомпоновкиДанных.Вместе Тогда
		РасположениеГруппы = "Вместе";
	ИначеЕсли Расположение = РасположениеПоляКомпоновкиДанных.Горизонтально Тогда
		РасположениеГруппы = "Горизонтально";
	ИначеЕсли Расположение = РасположениеПоляКомпоновкиДанных.ОтдельнаяКолонка Тогда
		РасположениеГруппы = "ОтдельнаяКолонка";
	Иначе
		ВызватьИсключение СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Некорректное значение параметра ""Расположение"": ""%1"".'"), Строка(Расположение));
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	ВыбратьИЗакрыть();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОпределитьПоведениеВМобильномКлиенте()
	ЭтоМобильныйКлиент = ОбщегоНазначения.ЭтоМобильныйКлиент();
	Если Не ЭтоМобильныйКлиент Тогда 
		Возврат;
	КонецЕсли;
	
	ПоложениеКоманднойПанели = ПоложениеКоманднойПанелиФормы.Авто;
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьИЗакрыть()
	РезультатВыбора = Новый Структура;
	РезультатВыбора.Вставить("ЗаголовокГруппы", ЗаголовокГруппы);
	РезультатВыбора.Вставить("Расположение", РасположениеПоляКомпоновкиДанных[РасположениеГруппы]);
	ОповеститьОВыборе(РезультатВыбора);
	Если Открыта() Тогда
		Закрыть(РезультатВыбора);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти