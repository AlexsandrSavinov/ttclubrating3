///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Создает напоминание с произвольным временем или расписанием выполнения.
//
// Параметры:
//  Текст - Строка - текст напоминания;
//  ВремяСобытия - Дата - дата и время события, о котором надо напомнить.
//               - РасписаниеРегламентногоЗадания - расписание периодического события.
//               - Строка - имя реквизита Предмета, в котором содержится время наступления события.
//  ИнтервалДоСобытия - Число - время в секундах, за которое необходимо напомнить относительно времени события;
//  Предмет - ЛюбаяСсылка - предмет напоминания;
//  Идентификатор - Строка - уточняет предмет напоминания, например, "ДеньРождения".
//
Процедура УстановитьНапоминание(Текст, ВремяСобытия, ИнтервалДоСобытия = 0, Предмет = Неопределено, Идентификатор = Неопределено) Экспорт
	НапоминанияПользователяСлужебный.ПодключитьПроизвольноеНапоминание(
		Текст, ВремяСобытия, ИнтервалДоСобытия, Предмет, Идентификатор);
КонецПроцедуры

// Возвращает список напоминаний текущего пользователя.
//
// Параметры:
//  Предмет - ЛюбаяСсылка
//          - Массив - предмет или предметы напоминания.
//  Идентификатор - Строка - уточняет предмет напоминания, например, "ДеньРождения".
//
// Возвращаемое значение:
//    Массив - коллекция напоминаний в виде структур с полями, соответствующими полям регистра сведений НапоминанияПользователя.
//
Функция НайтиНапоминания(Знач Предмет = Неопределено, Идентификатор = Неопределено) Экспорт
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	*
	|ИЗ
	|	РегистрСведений.НапоминанияПользователя КАК НапоминанияПользователя
	|ГДЕ
	|	НапоминанияПользователя.Пользователь = &Пользователь
	|	И &ОтборПоПредмету
	|	И &ОтборПоИдентификатору";
	
	ОтборПоПредмету = "ИСТИНА";
	Если ЗначениеЗаполнено(Предмет) Тогда
		ОтборПоПредмету = "НапоминанияПользователя.Источник В(&Предмет)";
	КонецЕсли;
	
	ОтборПоИдентификатору = "ИСТИНА";
	Если ЗначениеЗаполнено(Идентификатор) Тогда
		ОтборПоИдентификатору = "НапоминанияПользователя.Идентификатор = &Идентификатор";
	КонецЕсли;
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ОтборПоПредмету", ОтборПоПредмету);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ОтборПоИдентификатору", ОтборПоИдентификатору);
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("Пользователь", Пользователи.ТекущийПользователь());
	Запрос.УстановитьПараметр("Предмет", Предмет);
	Запрос.УстановитьПараметр("Идентификатор", Идентификатор);
	
	ТаблицаНапоминаний = Запрос.Выполнить().Выгрузить();
	
	Возврат ОбщегоНазначения.ТаблицаЗначенийВМассив(ТаблицаНапоминаний);
	
КонецФункции

// Удаляет напоминание пользователя.
//
// Параметры:
//  Напоминание - Структура - элемент коллекции, возвращаемый функцией НайтиНапоминания().
//
Процедура УдалитьНапоминание(Напоминание) Экспорт
	НапоминанияПользователяСлужебный.ОтключитьНапоминание(Напоминание, Ложь);
КонецПроцедуры

// Проверяет изменения реквизитов предметов, на которые есть пользовательская подписка,
// изменяет срок напоминания в случае необходимости.
//
// Параметры:
//  Предметы - Массив - предметы, по которым необходимо обновить сроки напоминаний.
// 
Процедура ОбновитьНапоминанияПоПредметам(Предметы) Экспорт
	
	НапоминанияПользователяСлужебный.ОбновитьНапоминанияПоПредметам(Предметы);
	
КонецПроцедуры

#КонецОбласти
