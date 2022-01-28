///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОписаниеПеременных

&НаКлиенте
Перем ОбновитьИнтерфейс;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ПрофилиБезопасности") Тогда
		МодульРаботаВБезопасномРежимеСлужебный = ОбщегоНазначения.ОбщийМодуль("РаботаВБезопасномРежимеСлужебный");
		
		Элементы.ГруппаНастройкаИспользованияПрофилейБезопасности.Видимость =
			  Пользователи.ЭтоПолноправныйПользователь(, Истина)
			И МодульРаботаВБезопасномРежимеСлужебный.ДоступнаНастройкаПрофилейБезопасности();
	Иначе
		Элементы.ГруппаНастройкаИспользованияПрофилейБезопасности.Видимость = Ложь;
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ПолучениеФайловИзИнтернета") Тогда
		Элементы.ГруппаОткрытьПараметрыПроксиСервера.Видимость =
			  Пользователи.ЭтоПолноправныйПользователь(, Истина)
			И Не ОбщегоНазначения.ИнформационнаяБазаФайловая();
	Иначе
		Элементы.ГруппаОткрытьПараметрыПроксиСервера.Видимость = Ложь;
	КонецЕсли;
	
	Если Не ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ЭлектроннаяПодпись") Тогда
		Элементы.ГруппаЭлектроннаяПодписьИШифрование.Видимость = Ложь;
	КонецЕсли;
	
	Если Не ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Свойства") Тогда
		Элементы.ГруппаДополнительныеРеквизитыИСведения.Видимость = Ложь;
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ЭлектроннаяПодписьСервисаDSS") Тогда
		ЭтоАдминистратор = Пользователи.ЭтоПолноправныйПользователь(, Истина);
		Элементы.ИспользоватьСервисОблачнойПодписи.Видимость = ЭтоАдминистратор И ОбщегоНазначения.РазделениеВключено();
	Иначе	
		Элементы.ГруппаОблачнаяПодпись.Видимость = Ложь;
	КонецЕсли;
	
	Если Не ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ВерсионированиеОбъектов") Тогда
		Элементы.ГруппаВерсионирование.Видимость = Ложь;
	КонецЕсли;
	
	Элементы.ГруппаПубликацияИнформационнойБазы.Видимость = Не (ОбщегоНазначения.РазделениеВключено() 
		Или ОбщегоНазначения.ЭтоАвтономноеРабочееМесто());
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ВерсионированиеОбъектов") Тогда
		МодульВерсионированиеОбъектов = ОбщегоНазначения.ОбщийМодуль("ВерсионированиеОбъектов");
		ХранитьИсториюИзменений = МодульВерсионированиеОбъектов.ЗначениеФлажкаХранитьИсторию();
	Иначе 
		Элементы.ГруппаВерсионирование.Видимость = Ложь;
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ПолнотекстовыйПоиск") 
		И Пользователи.ЭтоПолноправныйПользователь(, Истина) Тогда
		
		МодульПолнотекстовыйПоискСервер = ОбщегоНазначения.ОбщийМодуль("ПолнотекстовыйПоискСервер");
		ИспользоватьПолнотекстовыйПоиск = МодульПолнотекстовыйПоискСервер.ЗначениеФлажкаИспользоватьПоиск();
	Иначе
		Элементы.ГруппаУправлениеПолнотекстовымПоиском.Видимость = Ложь;
	КонецЕсли;
	
	Если (ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УдалениеПомеченныхОбъектов") )
		И Пользователи.ЭтоПолноправныйПользователь(,Истина) Тогда
		
		МодульУдалениеПомеченныхОбъектов = ОбщегоНазначения.ОбщийМодуль("УдалениеПомеченныхОбъектов");
		РежимРегламентногоЗадания = МодульУдалениеПомеченныхОбъектов.РежимУдалятьПоРасписанию();
		УдалениеПомеченныхИспользование = РежимРегламентногоЗадания.Использование;
		Элементы.НастроитьРасписание.Доступность = УдалениеПомеченныхИспользование;
	Иначе
		Элементы.ГруппаУдалениеПомеченных.Видимость = Ложь;
	КонецЕсли;
	
	Элементы.РегиональныеНастройки.Видимость = ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Мультиязычность");
	
	УстановитьДоступность();
	
	НастройкиПрограммыПереопределяемый.ОбщиеНастройкиПриСозданииНаСервере(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	ОбновитьИнтерфейсПрограммы();
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ВерсионированиеОбъектов") Тогда
		МодульВерсионированиеОбъектовКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ВерсионированиеОбъектовКлиент");
		МодульВерсионированиеОбъектовКлиент.ОбработкаОповещенияИзмененияФлажкаХранитьИсторию(
			ИмяСобытия, 
			ХранитьИсториюИзменений);
	КонецЕсли;
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПолнотекстовыйПоиск") Тогда
		МодульПолнотекстовыйПоискКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ПолнотекстовыйПоискКлиент");
		МодульПолнотекстовыйПоискКлиент.ОбработкаОповещенияИзмененияФлажкаИспользоватьПоиск(
			ИмяСобытия, 
			ИспользоватьПолнотекстовыйПоиск);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ЗаголовокПрограммыПриИзменении(Элемент)
	Подключаемый_ПриИзмененииРеквизита(Элемент);
	СтандартныеПодсистемыКлиент.УстановитьРасширенныйЗаголовокПриложения();
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьДополнительныеРеквизитыИСведенияПриИзменении(Элемент)
	Подключаемый_ПриИзмененииРеквизита(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура АдресПубликацииИнформационнойБазыПриИзменении(Элемент)
	
	Подключаемый_ПриИзмененииРеквизита(Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура АдресПубликацииИнформационнойБазыВИнтернетеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ПодключитьОбработчикОжидания("АдресПубликацииИнформационнойБазыВИнтернетеНачалоВыбораПродолжение", 0.1, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура АдресПубликацииИнформационнойБазыВЛокальнойСетиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ПодключитьОбработчикОжидания("АдресПубликацииИнформационнойБазыВЛокальнойСетиНачалоВыбораПродолжение", 0.1, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ХранитьИсториюИзмененийПриИзменении(Элемент)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ВерсионированиеОбъектов") Тогда
		МодульВерсионированиеОбъектовКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ВерсионированиеОбъектовКлиент");
		МодульВерсионированиеОбъектовКлиент.ПриИзмененииФлажкаХранитьИсторию(ХранитьИсториюИзменений);
	КонецЕсли;
	
	УстановитьДоступность("ХранитьИсториюИзменений");
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьПолнотекстовыйПоискПриИзменении(Элемент)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПолнотекстовыйПоиск") Тогда
		МодульПолнотекстовыйПоискКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ПолнотекстовыйПоискКлиент");
		МодульПолнотекстовыйПоискКлиент.ПриИзмененииФлажкаИспользоватьПоиск(ИспользоватьПолнотекстовыйПоиск);
	КонецЕсли;
	
	УстановитьДоступность("ИспользоватьПолнотекстовыйПоиск");
	
КонецПроцедуры

&НаКлиенте
Процедура УдалениеПомеченныхИспользованиеПриИзменении(Элемент)
	ОповещениеОбИзменении = Новый ОписаниеОповещения("УдалениеПомеченныхИспользованиеПриИзмененииЗавершение", ЭтотОбъект);
	
	Если (ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.УдалениеПомеченныхОбъектов")) Тогда
		МодульУдалениеПомеченныхОбъектовКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УдалениеПомеченныхОбъектовКлиент");
		МодульУдалениеПомеченныхОбъектовКлиент.ПриИзмененииФлажкаУдалятьПоРасписанию(УдалениеПомеченныхИспользование, ОповещениеОбИзменении);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура УдалениеПомеченныхИспользованиеПриИзмененииЗавершение(Изменение, ДополнительныеПараметры) Экспорт
	Если (Изменение = Неопределено) Тогда
		Возврат;
	КонецЕсли;
	
	УдалениеПомеченныхИспользование = Изменение.Использование;
	Элементы.НастроитьРасписание.Доступность = УдалениеПомеченныхИспользование;
КонецПроцедуры
#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ИспользованиеПрофилейБезопасности(Команда)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПрофилиБезопасности") Тогда
		МодульРаботаВБезопасномРежимеКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("РаботаВБезопасномРежимеКлиент");
		МодульРаботаВБезопасномРежимеКлиент.ОткрытьДиалогНастройкиИспользованияПрофилейБезопасности();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДополнительныеРеквизиты(Команда)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.Свойства") Тогда
		МодульУправлениеСвойствамиКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеСвойствамиКлиент");
		МодульУправлениеСвойствамиКлиент.ОткрытьСписокСвойств(Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДополнительныеСведения(Команда)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.Свойства") Тогда
		МодульУправлениеСвойствамиКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеСвойствамиКлиент");
		МодульУправлениеСвойствамиКлиент.ОткрытьСписокСвойств();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НастроитьХранениеИсторииИзменений(Команда)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ВерсионированиеОбъектов") Тогда
		МодульВерсионированиеОбъектовКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ВерсионированиеОбъектовКлиент");
		МодульВерсионированиеОбъектовКлиент.ПоказатьНастройку();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НастроитьПолнотекстовыйПоиск(Команда)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПолнотекстовыйПоиск") Тогда
		МодульПолнотекстовыйПоискКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ПолнотекстовыйПоискКлиент");
		МодульПолнотекстовыйПоискКлиент.ПоказатьНастройку();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура РегиональныеНастройки(Команда)
	
	ПараметрыФормы = Новый Структура("Источник", "ПанельАдминистрированияБСП");
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.Мультиязычность") Тогда
		МодульМультиязычностьКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("МультиязычностьКлиент");
		МодульМультиязычностьКлиент.ОткрытьФормуРегиональныхНастроек(, ПараметрыФормы);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПосмотретьПомеченныеНаУдаление(Команда)
	Если (ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.УдалениеПомеченныхОбъектов")) Тогда
		МодульУдалениеПомеченныхОбъектовКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УдалениеПомеченныхОбъектовКлиент");
		МодульУдалениеПомеченныхОбъектовКлиент.ПерейтиКПомеченнымНаУдаление(ЭтотОбъект);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура НастроитьРасписание(Команда)
	Если (ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.УдалениеПомеченныхОбъектов")) Тогда
		МодульУдалениеПомеченныхОбъектовКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УдалениеПомеченныхОбъектовКлиент");
		МодульУдалениеПомеченныхОбъектовКлиент.НачатьИзменениеРасписанияРегламентногоЗадания();
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура АдресПубликацииИнформационнойБазыВИнтернетеНачалоВыбораПродолжение()
	
	АдресПубликацииИнформационнойНачалоВыбораЗавершение("АдресПубликацииИнформационнойБазыВИнтернете");
	
КонецПроцедуры

&НаКлиенте
Процедура АдресПубликацииИнформационнойБазыВЛокальнойСетиНачалоВыбораПродолжение()
	
	АдресПубликацииИнформационнойНачалоВыбораЗавершение("АдресПубликацииИнформационнойБазыВЛокальнойСети");
	
КонецПроцедуры

&НаКлиенте
Процедура АдресПубликацииИнформационнойНачалоВыбораЗавершение(ИмяРеквизита)
	
	Если ОбщегоНазначенияКлиент.КлиентПодключенЧерезВебСервер() Тогда
		АдресПубликацииИнформационнойБазыНачалоВыбораНаСервере(ИмяРеквизита, СтрокаСоединенияИнформационнойБазы());
		Подключаемый_ПриИзмененииРеквизита(Элементы[ИмяРеквизита]);
	Иначе
		ПоказатьПредупреждение(, НСтр("ru = 'Не удалось автоматически заполнить поле, т.к. клиентское приложение не подключено через веб-сервер.'"));
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура АдресПубликацииИнформационнойБазыНачалоВыбораНаСервере(ИмяРеквизита, СтрокаСоединения)
	
	ПараметрыСоединения = СтроковыеФункцииКлиентСервер.ПараметрыИзСтроки(СтрокаСоединения);
	Если ПараметрыСоединения.Свойство("WS") Тогда
		НаборКонстант[ИмяРеквизита] = ПараметрыСоединения.WS;
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Клиент

&НаКлиенте
Процедура Подключаемый_ПриИзмененииРеквизита(Элемент, ОбновлятьИнтерфейс = Истина)
	
	ИмяКонстанты = ПриИзмененииРеквизитаСервер(Элемент.Имя);
	ОбновитьПовторноИспользуемыеЗначения();
	
	Если ОбновлятьИнтерфейс Тогда
		ОбновитьИнтерфейс = Истина;
		ПодключитьОбработчикОжидания("ОбновитьИнтерфейсПрограммы", 2, Истина);
	КонецЕсли;
	
	Если ИмяКонстанты <> "" Тогда
		Оповестить("Запись_НаборКонстант", Новый Структура, ИмяКонстанты);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИнтерфейсПрограммы()
	
	Если ОбновитьИнтерфейс = Истина Тогда
		ОбновитьИнтерфейс = Ложь;
		ОбщегоНазначенияКлиент.ОбновитьИнтерфейсПрограммы();
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Вызов сервера

&НаСервере
Функция ПриИзмененииРеквизитаСервер(ИмяЭлемента)
	
	РеквизитПутьКДанным = Элементы[ИмяЭлемента].ПутьКДанным;
	ИмяКонстанты = СохранитьЗначениеРеквизита(РеквизитПутьКДанным);
	УстановитьДоступность(РеквизитПутьКДанным);
	ОбновитьПовторноИспользуемыеЗначения();
	Возврат ИмяКонстанты;
	
КонецФункции




////////////////////////////////////////////////////////////////////////////////
// Сервер

&НаСервере
Функция СохранитьЗначениеРеквизита(РеквизитПутьКДанным)
	
	// Сохранение значений реквизитов, не связанных с константами напрямую (в отношении один-к-одному).
	
	ЧастиИмени = СтрРазделить(РеквизитПутьКДанным, ".");
	Если ЧастиИмени.Количество() <> 2 Тогда
		Возврат "";
	КонецЕсли;
	
	ИмяКонстанты = ЧастиИмени[1];
	КонстантаМенеджер = Константы[ИмяКонстанты];
	КонстантаЗначение = НаборКонстант[ИмяКонстанты];
	
	Если КонстантаМенеджер.Получить() <> КонстантаЗначение Тогда
		КонстантаМенеджер.Установить(КонстантаЗначение);
	КонецЕсли;
	
	Если ИмяКонстанты = "ИспользоватьДополнительныеРеквизитыИСведения" И КонстантаЗначение = Ложь Тогда
		ЭтотОбъект.Прочитать();
	КонецЕсли;
	
	Возврат ИмяКонстанты;
	
КонецФункции

&НаСервере
Процедура УстановитьДоступность(РеквизитПутьКДанным = "")
	
	Если (РеквизитПутьКДанным = "НаборКонстант.ИспользоватьДополнительныеРеквизитыИСведения" Или РеквизитПутьКДанным = "")
		И ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Свойства") Тогда
		
		Элементы.ГруппаДополнительныеРеквизитыИлиСведения.Доступность =
			НаборКонстант.ИспользоватьДополнительныеРеквизитыИСведения;
	КонецЕсли;
	
	Если (РеквизитПутьКДанным = "ХранитьИсториюИзменений" Или РеквизитПутьКДанным = "")
		И ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ВерсионированиеОбъектов") Тогда
		
		Элементы.НастроитьХранениеИсторииИзменений.Доступность = ХранитьИсториюИзменений;
	КонецЕсли;
	
	Если (РеквизитПутьКДанным = "ИспользоватьПолнотекстовыйПоиск" Или РеквизитПутьКДанным = "")
		И ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ПолнотекстовыйПоиск") Тогда
		
		Элементы.НастроитьПолнотекстовыйПоиск.Доступность = ИспользоватьПолнотекстовыйПоиск;
	КонецЕсли;
	
	Если (РеквизитПутьКДанным = "НаборКонстант.ИспользоватьЭлектронныеПодписи"
		Или РеквизитПутьКДанным = "НаборКонстант.ИспользоватьШифрование" Или РеквизитПутьКДанным = "")
		И ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ЭлектроннаяПодпись") Тогда
		
		Элементы.НастройкиЭлектроннойПодписиИШифрования.Доступность =
			НаборКонстант.ИспользоватьЭлектронныеПодписи Или НаборКонстант.ИспользоватьШифрование;
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ПрофилиБезопасности") Тогда
		МодульРаботаВБезопасномРежиме = ОбщегоНазначения.ОбщийМодуль("РаботаВБезопасномРежиме");
		ИспользуютсяПрофилиБезопасности = МодульРаботаВБезопасномРежиме.ИспользуютсяПрофилиБезопасности();
	Иначе
		ИспользуютсяПрофилиБезопасности = Ложь;
	КонецЕсли;
	
	Если РеквизитПутьКДанным = "" Тогда
		ДоступностьНастройкиПроксиНаСервере = Не ИспользуютсяПрофилиБезопасности;
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы, "ГруппаОткрытьПараметрыПроксиСервера",
			"Доступность", ДоступностьНастройкиПроксиНаСервере);
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы, "ГруппаНастройкаПроксиСервераНаСервереНедоступнаПриИспользованииПрофилейБезопасности",
			"Видимость", Не ДоступностьНастройкиПроксиНаСервере);
	КонецЕсли;
	
	Если (РеквизитПутьКДанным = "НаборКонстант.ИспользоватьЭлектронныеПодписи"
		ИЛИ РеквизитПутьКДанным = "НаборКонстант.ИспользоватьШифрование"
		ИЛИ РеквизитПутьКДанным = "НаборКонстант.ИспользоватьСервисDSS"
		ИЛИ РеквизитПутьКДанным = "")
		И ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ЭлектроннаяПодписьСервисаDSS") Тогда
		
		ДоступностьОблачнойПодписи = (НаборКонстант.ИспользоватьЭлектронныеПодписи ИЛИ НаборКонстант.ИспользоватьШифрование)
			И (НаборКонстант.ИспользоватьСервисDSS);
			
		Элементы.ОбработкаУправлениеПодключениемDSSСерверыОблачнойПодписи.Доступность = ДоступностьОблачнойПодписи;
		Элементы.ОбработкаУправлениеПодключениемDSSУчетныеЗаписиОблачнойПодписи.Доступность = ДоступностьОблачнойПодписи;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
