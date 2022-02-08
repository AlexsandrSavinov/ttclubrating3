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
	
	Формула         = Параметры.Формула;
	ИсходнаяФормула = Параметры.Формула;
	
	Параметры.Свойство("ИспользуетсяДеревоОперандов", ИспользуетсяДеревоОперандов);
	
	Элементы.ГруппаОперандыСтраницы.ТекущаяСтраница = Элементы.СтраницаЧисловыхОперандов;
	Операнды.Загрузить(ПолучитьИзВременногоХранилища(Параметры.Операнды));
	Для Каждого ТекСтрока Из Операнды Цикл
		Если ТекСтрока.ПометкаУдаления Тогда
			ТекСтрока.ИндексКартинки = 3;
		Иначе
			ТекСтрока.ИндексКартинки = 2;
		КонецЕсли;
	КонецЦикла;
	
	ДеревоОператоров = ПолучитьСтандартноеДеревоОператоров();
	ЗначениеВРеквизитФормы(ДеревоОператоров, "Операторы");
	
	Если Параметры.Свойство("ОперандыЗаголовок") Тогда
		Элементы.ГруппаОперанды.Заголовок = Параметры.ОперандыЗаголовок;
		Элементы.ГруппаОперанды.Подсказка = Параметры.ОперандыЗаголовок;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Если Не Модифицированность Или Не ЗначениеЗаполнено(ИсходнаяФормула) Или ИсходнаяФормула = Формула Тогда
		Возврат;
	КонецЕсли;
	
	Отказ = Истина;
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	
	ПоказатьВопрос(Новый ОписаниеОповещения("ПередЗакрытиемЗавершение", ЭтотОбъект), НСтр("ru = 'Данные были изменены. Сохранить изменения?'"), РежимДиалогаВопрос.ДаНетОтмена);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытиемЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Ответ = РезультатВопроса;
	Если Ответ = КодВозвратаДиалога.Да Тогда
		Если ПроверитьФормулу(Формула, Операнды()) Тогда
			Модифицированность = Ложь;
			Закрыть(Формула);
		КонецЕсли;
	ИначеЕсли Ответ = КодВозвратаДиалога.Нет Тогда
		Модифицированность = Ложь;
		Закрыть(Неопределено);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КомпоновщикНастроекНастройкиВыборДоступныеПоляВыбораВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ТекстСтроки = Строка(КомпоновщикНастроек.Настройки.ДоступныеПоляПорядка.ПолучитьОбъектПоИдентификатору(ВыбраннаяСтрока).Поле);
	Операнд = ОбработатьТекстОперанда(ТекстСтроки);
	ВставитьТекстВФормулу(Операнд);
	
КонецПроцедуры

&НаКлиенте
Процедура КомпоновщикНастроекНачалоПеретаскивания(Элемент, ПараметрыПеретаскивания, Выполнение)
	
	ТекстЭлемента = Строка(КомпоновщикНастроек.Настройки.ДоступныеПоляПорядка.ПолучитьОбъектПоИдентификатору(Элементы.КомпоновщикНастроек.ТекущаяСтрока).Поле);
	ПараметрыПеретаскивания.Значение = ОбработатьТекстОперанда(ТекстЭлемента);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыОперанды

&НаКлиенте
Процедура ОперандыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле.Имя = "ОперандыЗначение" Тогда
		Возврат;
	КонецЕсли;
	
	Если Элемент.ТекущиеДанные.ПометкаУдаления Тогда
		
		ПоказатьВопрос(
			Новый ОписаниеОповещения("ОперандыВыборЗавершение", ЭтотОбъект), 
			НСтр("ru = 'Выбранный элемент помечен на удаление. 
				|Продолжить?'"), 
			РежимДиалогаВопрос.ДаНет);
		СтандартнаяОбработка = Ложь;
		Возврат;
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
	ВставитьОперандВФормулу();
	
КонецПроцедуры

&НаКлиенте
Процедура ОперандыВыборЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		ВставитьОперандВФормулу();
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОперандыНачалоПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка)
	
	ПараметрыПеретаскивания.Значение = ПолучитьТекстОперандаДляВставки(Элемент.ТекущиеДанные.Идентификатор);
	
КонецПроцедуры

&НаКлиенте
Процедура ОперандыОкончаниеПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка)
	
	Если Элемент.ТекущиеДанные.ПометкаУдаления Тогда
		ПоказатьВопрос(Новый ОписаниеОповещения("ОперандыОкончаниеПеретаскиванияЗавершение", ЭтотОбъект),
			НСтр("ru = 'Выбранный элемент помечен на удаление.
			|Продолжить?'"), РежимДиалогаВопрос.ДаНет);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОперандыОкончаниеПеретаскиванияЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Ответ = РезультатВопроса;
	
	Если Ответ = КодВозвратаДиалога.Нет Тогда
		
		НачалоСтроки  = 0;
		НачалоКолонки = 0;
		КонецСтроки   = 0;
		КонецКолонки  = 0;
		
		Элементы.Формула.ПолучитьГраницыВыделения(НачалоСтроки, НачалоКолонки, КонецСтроки, КонецКолонки);
		Элементы.Формула.ВыделенныйТекст = "";
		Элементы.Формула.УстановитьГраницыВыделения(НачалоСтроки, НачалоКолонки, НачалоСтроки, НачалоКолонки);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоОперандовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ТекущиеДанные = Элементы.ДеревоОперандов.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СтрокаРодитель = ТекущиеДанные.ПолучитьРодителя();
	Если СтрокаРодитель = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ВставитьТекстВФормулу(ПолучитьТекстОперандаДляВставки(
		СтрокаРодитель.Идентификатор + "." + ТекущиеДанные.Идентификатор));
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДеревоОперандов

&НаКлиенте
Процедура ДеревоОперандовНачалоПеретаскивания(Элемент, ПараметрыПеретаскивания, Выполнение)
	
	Если ПараметрыПеретаскивания.Значение = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СтрокаДерева = ДеревоОперандов.НайтиПоИдентификатору(ПараметрыПеретаскивания.Значение);
	СтрокаРодитель = СтрокаДерева.ПолучитьРодителя();
	Если СтрокаРодитель = Неопределено Тогда
		Выполнение = Ложь;
		Возврат;
	Иначе
		ПараметрыПеретаскивания.Значение = 
		   ПолучитьТекстОперандаДляВставки(СтрокаРодитель.Идентификатор +"." + СтрокаДерева.Идентификатор);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыОператоры

&НаКлиенте
Процедура ОператорыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ВставитьОператорВФормулу();
	
КонецПроцедуры

&НаКлиенте
Процедура ОператорыНачалоПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(Элемент.ТекущиеДанные.Оператор) Тогда
		ПараметрыПеретаскивания.Значение = Элемент.ТекущиеДанные.Оператор;
	Иначе
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОператорыОкончаниеПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка)
	
	Если Элемент.ТекущиеДанные.Оператор = "Формат(,)" Тогда
		ФорматСтроки = Новый КонструкторФорматнойСтроки;
		ФорматСтроки.Показать(Новый ОписаниеОповещения("ОператорыОкончаниеПеретаскиванияЗавершение", ЭтотОбъект, Новый Структура("ФорматСтроки", ФорматСтроки)));
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОператорыОкончаниеПеретаскиванияЗавершение(Текст, ДополнительныеПараметры) Экспорт
	
	ФорматСтроки = ДополнительныеПараметры.ФорматСтроки;
	
	
	Если ЗначениеЗаполнено(ФорматСтроки.Текст) Тогда
		ТекстДляВставки = "Формат( , """ + ФорматСтроки.Текст + """)";
		Элементы.Формула.ВыделенныйТекст = ТекстДляВставки;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	ОчиститьСообщения();
	
	Если ПроверитьФормулу(Формула, Операнды()) Тогда
		Закрыть(Формула);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Проверить(Команда)
	
	ОчиститьСообщения();
	ПроверитьФормулуИнтерактивно(Формула, Операнды());
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ВставитьТекстВФормулу(ТекстДляВставки, Сдвиг = 0)
	
	СтрокаНач = 0;
	СтрокаКон = 0;
	КолонкаНач = 0;
	КолонкаКон = 0;
	
	Элементы.Формула.ПолучитьГраницыВыделения(СтрокаНач, КолонкаНач, СтрокаКон, КолонкаКон);
	
	Если (КолонкаКон = КолонкаНач) И (КолонкаКон + СтрДлина(ТекстДляВставки)) > Элементы.Формула.Ширина / 8 Тогда
		Элементы.Формула.ВыделенныйТекст = "";
	КонецЕсли;
		
	Элементы.Формула.ВыделенныйТекст = ТекстДляВставки;
	
	Если Не Сдвиг = 0 Тогда
		Элементы.Формула.ПолучитьГраницыВыделения(СтрокаНач, КолонкаНач, СтрокаКон, КолонкаКон);
		Элементы.Формула.УстановитьГраницыВыделения(СтрокаНач, КолонкаНач - Сдвиг, СтрокаКон, КолонкаКон - Сдвиг);
	КонецЕсли;
		
	ТекущийЭлемент = Элементы.Формула;
	
КонецПроцедуры

&НаКлиенте
Процедура ВставитьОперандВФормулу()
	
	ВставитьТекстВФормулу(ПолучитьТекстОперандаДляВставки(Элементы.Операнды.ТекущиеДанные.Идентификатор));
	
КонецПроцедуры

&НаКлиенте
Функция Операнды()
	
	Результат = Новый Массив();
	Для Каждого Операнд Из Операнды Цикл
		Результат.Добавить(Операнд.Идентификатор);
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура ВставитьОператорВФормулу()
	
	Если Элементы.Операторы.ТекущиеДанные.Наименование = "Формат" Тогда
		ФорматСтроки = Новый КонструкторФорматнойСтроки;
		ФорматСтроки.Показать(Новый ОписаниеОповещения("ВставитьОператорВФормулуЗавершение", ЭтотОбъект, Новый Структура("ФорматСтроки", ФорматСтроки)));
		Возврат;
	Иначе	
		ВставитьТекстВФормулу(Элементы.Операторы.ТекущиеДанные.Оператор, Элементы.Операторы.ТекущиеДанные.Сдвиг);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВставитьОператорВФормулуЗавершение(Текст, ДополнительныеПараметры) Экспорт
	
	ФорматСтроки = ДополнительныеПараметры.ФорматСтроки;
	
	Если ЗначениеЗаполнено(ФорматСтроки.Текст) Тогда
		ТекстДляВставки = "Формат( , """ + ФорматСтроки.Текст + """)";
		ВставитьТекстВФормулу(ТекстДляВставки, Элементы.Операторы.ТекущиеДанные.Сдвиг);
	Иначе	
		ВставитьТекстВФормулу(Элементы.Операторы.ТекущиеДанные.Оператор, Элементы.Операторы.ТекущиеДанные.Сдвиг);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция ОбработатьТекстОперанда(ТекстОперанда)
	
	ТекстСтроки = ТекстОперанда;
	ТекстСтроки = СтрЗаменить(ТекстСтроки, "[", "");
	ТекстСтроки = СтрЗаменить(ТекстСтроки, "]", "");
	Операнд = "[" + СтрЗаменить(ТекстСтроки, 
		?(НаборСвойств.НаборСвойствНоменклатуры, "Номенклатура.", 
			?(НЕ НаборСвойств.Свойство("НаборСвойствХарактеристик") ИЛИ НаборСвойств.НаборСвойствХарактеристик, "ХарактеристикаНоменклатуры.", "СерияНоменклатуры.")), "") + "]";
	
	Возврат Операнд
	
КонецФункции

&НаСервере
Функция ПолучитьПустоеДеревоОператоров()
	
	Дерево = Новый ДеревоЗначений();
	Дерево.Колонки.Добавить("Наименование");
	Дерево.Колонки.Добавить("Оператор");
	Дерево.Колонки.Добавить("Сдвиг", Новый ОписаниеТипов("Число"));
	
	Возврат Дерево;
	
КонецФункции

&НаСервере
Функция ДобавитьГруппуОператоров(Дерево, Наименование)
	
	НоваяГруппа = Дерево.Строки.Добавить();
	НоваяГруппа.Наименование = Наименование;
	
	Возврат НоваяГруппа;
	
КонецФункции

&НаСервере
Функция ДобавитьОператор(Дерево, Родитель, Наименование, Оператор = Неопределено, Сдвиг = 0)
	
	НоваяСтрока = ?(Родитель <> Неопределено, Родитель.Строки.Добавить(), Дерево.Строки.Добавить());
	НоваяСтрока.Наименование = Наименование;
	НоваяСтрока.Оператор = ?(ЗначениеЗаполнено(Оператор), Оператор, Наименование);
	НоваяСтрока.Сдвиг = Сдвиг;
	
	Возврат НоваяСтрока;
	
КонецФункции

&НаСервере
Функция ПолучитьСтандартноеДеревоОператоров()
	
	Дерево = ПолучитьПустоеДеревоОператоров();
	
	ГруппаОператоров = ДобавитьГруппуОператоров(Дерево, НСтр("ru = 'Разделители'"));
	
	ДобавитьОператор(Дерево, ГруппаОператоров, "/", " + ""/"" + ");
	ДобавитьОператор(Дерево, ГруппаОператоров, "\", " + ""\"" + ");
	ДобавитьОператор(Дерево, ГруппаОператоров, "|", " + ""|"" + ");
	ДобавитьОператор(Дерево, ГруппаОператоров, "_", " + ""_"" + ");
	ДобавитьОператор(Дерево, ГруппаОператоров, ",", " + "", "" + ");
	ДобавитьОператор(Дерево, ГруппаОператоров, ".", " + "". "" + ");
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'Пробел'"), " + "" "" + ");
	ДобавитьОператор(Дерево, ГруппаОператоров, "(", " + "" ("" + ");
	ДобавитьОператор(Дерево, ГруппаОператоров, ")", " + "") "" + ");
	ДобавитьОператор(Дерево, ГруппаОператоров, """", " + """""""" + ");
	
	ГруппаОператоров = ДобавитьГруппуОператоров(Дерево, НСтр("ru = 'Операторы'"));
	
	ДобавитьОператор(Дерево, ГруппаОператоров, "+", " + ");
	ДобавитьОператор(Дерево, ГруппаОператоров, "-", " - ");
	ДобавитьОператор(Дерево, ГруппаОператоров, "*", " * ");
	ДобавитьОператор(Дерево, ГруппаОператоров, "/", " / ");
	
	ГруппаОператоров = ДобавитьГруппуОператоров(Дерево, НСтр("ru = 'Логические операторы и константы'"));
	ДобавитьОператор(Дерево, ГруппаОператоров, "<", " < ");
	ДобавитьОператор(Дерево, ГруппаОператоров, ">", " > ");
	ДобавитьОператор(Дерево, ГруппаОператоров, "<=", " <= ");
	ДобавитьОператор(Дерево, ГруппаОператоров, ">=", " >= ");
	ДобавитьОператор(Дерево, ГруппаОператоров, "=", " = ");
	ДобавитьОператор(Дерево, ГруппаОператоров, "<>", " <> ");
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'И'"),      " " + НСтр("ru = 'И'")      + " ");
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'Или'"),    " " + НСтр("ru = 'Или'")    + " ");
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'Не'"),     " " + НСтр("ru = 'Не'")     + " ");
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'ИСТИНА'"), " " + НСтр("ru = 'ИСТИНА'") + " ");
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'ЛОЖЬ'"),   " " + НСтр("ru = 'ЛОЖЬ'")   + " ");
	
	ГруппаОператоров = ДобавитьГруппуОператоров(Дерево, НСтр("ru = 'Числовые функции'"));
	
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'Максимум'"),    НСтр("ru = 'Макс(,)'"), 2);
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'Минимум'"),     НСтр("ru = 'Мин(,)'"),  2);
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'Округление'"),  НСтр("ru = 'Окр(,)'"),  2);
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'Целая часть'"), НСтр("ru = 'Цел()'"),   1);
	
	ГруппаОператоров = ДобавитьГруппуОператоров(Дерево, НСтр("ru = 'Строковые функции'"));
	
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'Строка'"), НСтр("ru = 'Строка()'"));
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'ВРег'"), НСтр("ru = 'ВРег()'"));
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'Лев'"), НСтр("ru = 'Лев()'"));
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'НРег'"), НСтр("ru = 'НРег()'"));
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'Прав'"), НСтр("ru = 'Прав()'"));
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'СокрЛ'"), НСтр("ru = 'СокрЛ()'"));
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'СокрЛП'"), НСтр("ru = 'СокрЛП()'"));
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'СокрП'"), НСтр("ru = 'СокрП()'"));
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'ТРег'"), НСтр("ru = 'ТРег()'"));
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'СтрЗаменить'"), НСтр("ru = 'СтрЗаменить(,,)'"));
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'СтрДлина'"), НСтр("ru = 'СтрДлина()'"));
	
	ГруппаОператоров = ДобавитьГруппуОператоров(Дерево, НСтр("ru = 'Прочие функции'"));
	
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'Условие'"), "?(,,)", 3);
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'Предопределенное значение'"), НСтр("ru = 'ПредопределенноеЗначение()'"));
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'Значение заполнено'"), НСтр("ru = 'ЗначениеЗаполнено()'"));
	ДобавитьОператор(Дерево, ГруппаОператоров, НСтр("ru = 'Формат'"), НСтр("ru = 'Формат(,)'"));
	
	Возврат Дерево;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ПолучитьТекстОперандаДляВставки(Операнд)
	
	Возврат "[" + Операнд + "]";
	
КонецФункции

&НаКлиенте
Функция ПроверитьФормулу(Формула, Операнды)
	
	Если Не ЗначениеЗаполнено(Формула) Тогда
		Возврат Истина;
	КонецЕсли;
	
	ЗначениеЗамены = """1""";
	
	ТекстРасчета = Формула;
	Для Каждого Операнд Из Операнды Цикл
		ТекстРасчета = СтрЗаменить(ТекстРасчета, ПолучитьТекстОперандаДляВставки(Операнд), ЗначениеЗамены);
	КонецЦикла;
	
	Если СтрНачинаетсяС(СокрЛ(ТекстРасчета), "=") Тогда
		ТекстРасчета = Сред(СокрЛ(ТекстРасчета), 2);
	КонецЕсли;
	
	Попытка
		//@skip-warning
		РезультатРасчета = Вычислить(ТекстРасчета);
	Исключение
		ТекстОшибки = НСтр("ru = 'В формуле обнаружены ошибки. Проверьте формулу.
			|Формулы должны составляться по правилам написания выражений на встроенном языке 1С:Предприятия.'");
		СообщитьПользователю(ТекстОшибки, , "Формула");
		Возврат Ложь;
	КонецПопытки;
	
	Возврат Истина;
	
КонецФункции 

&НаКлиенте
Процедура ПроверитьФормулуИнтерактивно(Формула, Операнды)
	
	Если ЗначениеЗаполнено(Формула) Тогда
		Если ПроверитьФормулу(Формула, Операнды) Тогда
			ПоказатьОповещениеПользователя(
				НСтр("ru = 'В формуле ошибок не обнаружено'"),
				,
				,
				КартинкаИнформация32());
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция КартинкаИнформация32()
	Если ВерсияБСПСоответствуетТребованиям() Тогда
		Возврат БиблиотекаКартинок["Информация32"];
	Иначе
		Возврат Новый Картинка;
	КонецЕсли;
КонецФункции

&НаСервере
Функция ВерсияБСПСоответствуетТребованиям()
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	Возврат ОбработкаОбъект.ВерсияБСПСоответствуетТребованиям();
КонецФункции

&НаКлиенте
Процедура СообщитьПользователю(Знач ТекстСообщенияПользователю, Знач Поле = "", Знач ПутьКДанным = "")
	Сообщение = Новый СообщениеПользователю;
	Сообщение.Текст = ТекстСообщенияПользователю;
	Сообщение.Поле = Поле;
	
	Если НЕ ПустаяСтрока(ПутьКДанным) Тогда
		Сообщение.ПутьКДанным = ПутьКДанным;
	КонецЕсли;
		
	Сообщение.Сообщить();
КонецПроцедуры

#КонецОбласти
