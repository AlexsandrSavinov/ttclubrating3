
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЗаполнитьЗначенияСвойств(ТабДок,Параметры.ТабДок,"АвтоМасштаб,ПолеСверху,ПолеСнизу,ПолеСлева,ПолеСправа,РазмерКолонтитулаСверху");
	ТабДок.ВерхнийКолонтитул.Выводить 						= Параметры.ТабДок.ВерхнийКолонтитул.Выводить;
	ТабДок.ВерхнийКолонтитул.НачальнаяСтраница 	= Параметры.ТабДок.ВерхнийКолонтитул.НачальнаяСтраница;
	ТабДок.ВерхнийКолонтитул.ТекстСправа 					= Параметры.ТабДок.ВерхнийКолонтитул.ТекстСправа;
	ТабДок.Вывести(Параметры.ТабДок);
	
	Если Параметры.Свойство("Заголовок") Тогда
		ЭтотОбъект.Заголовок = Параметры.Заголовок;
	КонецЕсли;
	
	Параметры.Свойство("Ссылка",СсылкаНаДокумент);
	
КонецПроцедуры

&НаКлиенте
Процедура ТабДокВыбор(Элемент, Область, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
КонецПроцедуры

&НаКлиенте
Процедура ТабДокОбработкаРасшифровки(Элемент, Расшифровка, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
КонецПроцедуры