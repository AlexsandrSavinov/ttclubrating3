///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.ГрупповоеИзменениеОбъектов

// Возвращает реквизиты объекта, которые не рекомендуется редактировать
// с помощью обработки группового изменения реквизитов.
//
// Возвращаемое значение:
//  Массив из Строка
//
Функция РеквизитыНеРедактируемыеВГрупповойОбработке() Экспорт
	
	НеРедактируемыеРеквизиты = Новый Массив;
	НеРедактируемыеРеквизиты.Добавить("ОбъектАвторизации");
	НеРедактируемыеРеквизиты.Добавить("УстановитьРолиНепосредственно");
	НеРедактируемыеРеквизиты.Добавить("ИдентификаторПользователяИБ");
	НеРедактируемыеРеквизиты.Добавить("ИдентификаторПользователяСервиса");
	НеРедактируемыеРеквизиты.Добавить("СвойстваПользователяИБ");
	
	Возврат НеРедактируемыеРеквизиты;
	
КонецФункции

// Конец СтандартныеПодсистемы.ГрупповоеИзменениеОбъектов

#КонецОбласти

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	
	Если НЕ Параметры.Отбор.Свойство("Недействителен") Тогда
		Параметры.Отбор.Вставить("Недействителен", Ложь);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПолученияФормы(ВидФормы, Параметры, ВыбраннаяФорма, ДополнительнаяИнформация, СтандартнаяОбработка)
	
	Если ВидФормы = "ФормаОбъекта" И Параметры.Свойство("ОбъектАвторизации") Тогда
		
		СтандартнаяОбработка = Ложь;
		ВыбраннаяФорма = "ФормаЭлемента";
		
		НайденныйВнешнийПользователь = Неопределено;
		ЕстьПравоДобавленияВнешнегоПользователя = Ложь;
		
		ОбъектАвторизацииИспользуется = ПользователиСлужебный.ОбъектАвторизацииИспользуется(
			Параметры.ОбъектАвторизации,
			Неопределено,
			НайденныйВнешнийПользователь,
			ЕстьПравоДобавленияВнешнегоПользователя);
		
		Если ОбъектАвторизацииИспользуется Тогда
			Параметры.Вставить("Ключ", НайденныйВнешнийПользователь);
			
		ИначеЕсли ЕстьПравоДобавленияВнешнегоПользователя Тогда
			
			Параметры.Вставить(
				"ОбъектАвторизацииНовогоВнешнегоПользователя", Параметры.ОбъектАвторизации);
		Иначе
			ОписаниеОшибкиКакПредупреждения =
				НСтр("ru = 'Разрешение на вход в программу не предоставлялось.'");
				
			ВызватьИсключение ОписаниеОшибкиКакПредупреждения;
		КонецЕсли;
		
		Параметры.Удалить("ОбъектАвторизации");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	Если ОбщегоНазначения.РазделениеВключено() Тогда
		Возврат;
	КонецЕсли;
	
	СписокВнешнихПользователей = ПользователиСлужебный.ВнешниеПользователиДляВключенияВосстановленияПароля();
	
	Если СписокВнешнихПользователей.Количество() > 0 Тогда
		ОбновлениеИнформационнойБазы.ОтметитьКОбработке(Параметры, СписокВнешнихПользователей);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	Если Не ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.КонтактнаяИнформация") Тогда
		Параметры.ОбработкаЗавершена = Истина;
		Возврат;
	КонецЕсли;
	
	ВнешнийПользовательСсылка = ОбновлениеИнформационнойБазы.ВыбратьСсылкиДляОбработки(Параметры.Очередь, "Справочник.ВнешниеПользователи");
	
	ПроблемныхОбъектов = 0;
	ОбъектовОбработано = 0;
	СписокОшибок = Новый Массив;
	
	Пока ВнешнийПользовательСсылка.Следующий() Цикл
		
		ОбъектАвторизации = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ВнешнийПользовательСсылка.Ссылка, "ОбъектАвторизации");
		Результат = ПользователиСлужебный.ОбновитьПочтуДляВосстановленияПароля(ВнешнийПользовательСсылка.Ссылка, ОбъектАвторизации);
		
		Если Результат.Статус = "Ошибка" Тогда
			ПроблемныхОбъектов = ПроблемныхОбъектов + 1;
			СписокОшибок.Добавить(Результат.ТекстОшибки);
		Иначе
			ОбъектовОбработано = ОбъектовОбработано + 1;
			ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(ВнешнийПользовательСсылка.Ссылка);
		КонецЕсли;
		
	КонецЦикла;
	
	Параметры.ОбработкаЗавершена = ОбновлениеИнформационнойБазы.ОбработкаДанныхЗавершена(Параметры.Очередь, "Справочник.ВнешниеПользователи");
	
	Если ОбъектовОбработано = 0 И ПроблемныхОбъектов <> 0 Тогда
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Процедуре ОбработатьДанныеДляПереходаНаНовуюВерсию не удалось обработать некоторых внешних пользователей (пропущены): %1
			|%2'"), ПроблемныхОбъектов, СтрСоединить(СписокОшибок, Символы.ПС));
		ВызватьИсключение ТекстСообщения;
	Иначе
		ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(), УровеньЖурналаРегистрации.Информация,
			Метаданные.Справочники.ВнешниеПользователи,,
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию обработала очередную порцию внешних пользователей: %1'"),
			ОбъектовОбработано));
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти


#КонецЕсли
