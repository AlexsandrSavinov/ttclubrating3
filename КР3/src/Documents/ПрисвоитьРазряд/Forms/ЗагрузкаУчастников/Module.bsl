
&НаКлиенте
Процедура ПутьКФайлуНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	Диалог.Заголовок = "Выберите файл с данными";
	Диалог.ИндексФильтра = 0;
	Диалог.МножественныйВыбор =Ложь;
	Диалог.Фильтр    = "Excel 2007...  (*.xlsx)|*.xlsx|Excel 2003 (*.xls)|*.xls|Табличный документ (.*mxl)|*.mxl";
	Диалог.Показать(Новый ОписаниеОповещения("ПутьКФайлуНачалоВыбораЗавершение", ЭтотОбъект, Новый Структура("Диалог", Диалог)));
КонецПроцедуры

&НаКлиенте
Процедура ПутьКФайлуНачалоВыбораЗавершение(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	
	Диалог = ДополнительныеПараметры.Диалог;
	
	Если (ВыбранныеФайлы <> Неопределено) Тогда
		ПутьКФайлу = Диалог.ПолноеИмяФайла;
		ЗагрузитьФайлВТабличныйДокумент();
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ЗагрузитьФайлВТабличныйДокумент()
	
	ТабДокЗагрузки = Новый ТабличныйДокумент;
	ТабДокЗагрузки.Прочитать(ПутьКФайлу,СпособЧтенияЗначенийТабличногоДокумента.Текст);
	
	Таблица.Очистить();
	
	МетДанныеРазрядов = Метаданные.Перечисления.РазрядыИЗвания.ЗначенияПеречисления;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	Участники.Наименование,
	|	Участники.ДатаРождения,
	|	Участники.Ссылка
	|ИЗ
	|	Справочник.Участники КАК Участники
	|ГДЕ
	|	Участники.ПометкаУдаления = ЛОЖЬ";
	РезультатЗапроса = Запрос.Выполнить().Выгрузить();
	
	ЗагрузкаИдет = Истина;
	Сч = 0;
	Пока ЗагрузкаИдет Цикл
		Сч = Сч + 1;
		парФИО 					= СокрЛП(ТабДокЗагрузки.ПолучитьОбласть("R"+Сч+"C1").ТекущаяОбласть.Текст);
		Если Не ЗначениеЗаполнено(парФИО) Тогда
			ЗагрузкаИдет = Ложь;
			Продолжить;
		КонецЕсли;
		
		парДатаРождения 	= СокрЛП(ТабДокЗагрузки.ПолучитьОбласть("R"+Сч+"C2").ТекущаяОбласть.Текст);
		парРазряд 	= СокрЛП(ТабДокЗагрузки.ПолучитьОбласть("R"+Сч+"C3").ТекущаяОбласть.Текст);
		
		НовСтрока = Таблица.Добавить();
		
		ИтоговыйПарДаты = ОбщийКлиентСервер.ПриведениеИзСтрокиВДату(парДатаРождения);
		НовСтрока.ДатаРождения 	= ИтоговыйПарДаты;
		
		ТекИмя = СокрЛП(парФИО);
		ПоискОтбор = Новый Структура();
		ПоискОтбор.Вставить("Наименование", ТекИмя);
		ПоискОтбор.Вставить("ДатаРождения", НовСтрока.ДатаРождения);
		
		Результат = РезультатЗапроса.НайтиСтроки(ПоискОтбор);
		
		Если Результат.Количество() > 0 Тогда
			НовСтрока.Участник				= Результат[0].Ссылка;
		Иначе
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = "Не найден участник "+ТекИмя+ " Дата рождения: "+Формат(НовСтрока.ДатаРождения,"ДФ=dd.MM.yyyy");
			Сообщение.Сообщить(); 
		КонецЕсли;
		Для каждого ИскомыйРазряд Из МетДанныеРазрядов Цикл
			Если ВРег(Строка(ИскомыйРазряд)) = ВРег(парРазряд) Тогда
				НовСтрока.Разряд 				= Перечисления.РазрядыИЗвания[ИскомыйРазряд.Имя];
				Прервать;
			КонецЕсли; 
		КонецЦикла; 
		
	КонецЦикла; 
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	РазрядыИЗвания.Ссылка
	|ИЗ
	|	Перечисление.РазрядыИЗвания КАК РазрядыИЗвания
	|
	|УПОРЯДОЧИТЬ ПО
	|	РазрядыИЗвания.Порядок";
	Результат = Запрос.Выполнить().Выгрузить();
		
	Для каждого Стр Из Результат Цикл
		СписокРазрядов.Добавить(Стр.Ссылка);
	КонецЦикла; 
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаЗагрузитьТаблицу(Команда)
	
	Если ЗначениеЗаполнено(ПутьКФайлу) Тогда
		ЗагрузитьФайлВТабличныйДокумент();
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаЗагрузить(Команда)
	ЭтотОбъект.Закрыть(Таблица);
КонецПроцедуры
