
&НаКлиенте
Процедура ПутьКФайлуНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	Диалог.Заголовок = "Выберите файл с данными";
	Диалог.МножественныйВыбор =Ложь;
	//Диалог.Фильтр    = "Файлы Excel (*.xls)|*.xls (*.xlsx)|*.xlsx";
	Диалог.Фильтр    = "Все файлы (*.*)|*.*";// (*.xlsx)|*.xlsx";
	Диалог.Показать(Новый ОписаниеОповещения("ПутьКФайлуНачалоВыбораЗавершение", ЭтотОбъект, Новый Структура("Диалог", Диалог)));
	
КонецПроцедуры

&НаКлиенте
Процедура ПутьКФайлуНачалоВыбораЗавершение(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	
	Диалог = ДополнительныеПараметры.Диалог;
	
	
	Если (ВыбранныеФайлы <> Неопределено) Тогда
		Файл = Новый Файл(Диалог.ПолноеИмяФайла);
		Если  Файл.Расширение = ".xls" Или Файл.Расширение = ".xlsx" Тогда
			Объект.ПутьКФайлу = Диалог.ПолноеИмяФайла;
		КонецЕсли; 
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	РеквизитыСправочника = Метаданные.Справочники.Участники.Реквизиты;
	Объект.НомерЛиста = 1;
	Сч = 1;
	НовСтрока = ТаблицаСоответствий.Добавить();
	НовСтрока.РеквизитСправочника = "ФИО";
	НовСтрока.СинонимРеквизита = "Ф.И.О.";
	НовСтрока.КолонкаЭксель		  = Сч;
	Сч = Сч +1;
	НовСтрока = ТаблицаСоответствий.Добавить();
	НовСтрока.РеквизитСправочника = "Рейтинг";
	НовСтрока.СинонимРеквизита = "Рейтинг";
	НовСтрока.КолонкаЭксель		  = Сч;
	Сч = Сч +1;
	Для Каждого ТекРек Из РеквизитыСправочника Цикл
		Если Найти(ТекРек.Имя,"Файл") > 0 Тогда
			Продолжить;
		КонецЕсли; 
		НовСтрока = ТаблицаСоответствий.Добавить();
		НовСтрока.РеквизитСправочника = ТекРек.Имя;
		НовСтрока.СинонимРеквизита = ТекРек.Синоним;
		НовСтрока.КолонкаЭксель		  = Сч;
		Сч = Сч + 1;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура Загрузить(Команда)
	
	Если ЗначениеЗаполнено(Объект.ПутьКФайлу) и (Объект.ПерваяСтрока <> 0 И Объект.ПоследняяСтрока <> 0) И 
		(Объект.ПерваяСтрока < Объект.ПоследняяСтрока) Тогда
		НачатьПодключениеРасширенияРаботыСФайлами(Новый ОписаниеОповещения("ЗагрузитьЗавершение", ЭтотОбъект));
	Иначе
		Если Не ЗначениеЗаполнено(Объект.ПутьКФайлу) Тогда
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Поле = "Объект.ПутьКФайлу";
			Сообщение.УстановитьДанные(Объект);
			Сообщение.Текст = "Выберите файл для загрузки !";
			Сообщение.Сообщить();
		КонецЕсли;
		Если Объект.ПерваяСтрока = 0 Тогда
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Поле = "Объект.ПерваяСтрока";
			Сообщение.УстановитьДанные(Объект);
			Сообщение.Текст = "Установите номер первой строки загрузки";
			Сообщение.Сообщить();
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьЗавершение(Подключено, ДополнительныеПараметры) Экспорт
	
	ЗагрузитьФайлЭксель();
	ПоказатьОповещениеПользователя("Загрузка",,"Обработано строк: "+(ДанныеЗагрузки.Количество()),БиблиотекаКартинок.Информация);

КонецПроцедуры

&НаСервере
Процедура ЗагрузитьФайлЭксель()
	
	ТабДок = Новый ТабличныйДокумент;
	ТабДок.Прочитать(Объект.ПутьКФайлу);
	
	НачСтрока = Объект.ПерваяСтрока;
	КолСтрокВЛисте = Объект.ПоследняяСтрока;
	ДанныеЗагрузки.Очистить();
	
	СчСостояния = 0;
	МужскойПол = ПредопределенноеЗначение("Перечисление.ПолУчастника.Мужской");
	ЖенскийПол = ПредопределенноеЗначение("Перечисление.ПолУчастника.Женский");
	
	Пока НачСтрока <= КолСтрокВЛисте Цикл
		НовСтрока = ДанныеЗагрузки.Добавить();
		СчСостояния = СчСостояния + 1;
		Для Каждого ТекСтрока Из ТаблицаСоответствий Цикл
			Если ТекСтрока.КолонкаЭксель <> 0 Тогда
				ЗначениеЗагрузки = ТабДок.ПолучитьОбласть("R"+Формат(НачСтрока,"ЧГ=0")+"C"+Формат(ТекСтрока.КолонкаЭксель,"ЧГ=0")).ТекущаяОбласть.Текст;
				НовСтрока[ТекСтрока.РеквизитСправочника] = СокрЛП(ЗначениеЗагрузки);
			КонецЕсли;
		КонецЦикла;
		//приведем дату к дате
		НовСтрока.ДатаРождения = ОбщийКлиентСервер.ПриведениеИзСтрокиВДату(НовСтрока.ДатаРождения);
		//попробуем обработать пол
		Если Найти(НРег(НовСтрока.Пол),"муж") > 0 Тогда
			НовСтрока.Пол = МужскойПол;
		ИначеЕсли Найти(НРег(НовСтрока.Пол),"жен") > 0 Тогда
			НовСтрока.Пол = ЖенскийПол;
		КонецЕсли; 
		НачСтрока = НачСтрока + 1;
	КонецЦикла;
	
	СчСтрок = 1;
	НеЗагруженные = ДанныеЗагрузки.Количество();
	
	Для Каждого ТекСтр Из ДанныеЗагрузки Цикл ТекСтр.НомерСтроки = СчСтрок;СчСтрок = СчСтрок+1;	КонецЦикла;
	
	ПопробоватьУстановитьПол();
	
КонецПроцедуры

&НаСервере
Процедура ПопробоватьУстановитьПол()
	
	Для каждого ТекЗнач Из ДанныеЗагрузки Цикл
		Если ТипЗнч(ТекЗнач.Пол) = Тип("Строка") и ЗначениеЗаполнено(ТекЗнач.Пол) Тогда //пробуем определить по фамилии
			ОригиналИмени = ТекЗнач.ФИО;
			Фамилия = ОбщийКлиентСервер.ВыделитьСлово(ОригиналИмени);
			ПоследняяБуква = НРег(Прав(Фамилия,1));
			Если ПоследняяБуква = "а" Или ПоследняяБуква = "я" Тогда
				ТекЗнач.Пол = Перечисления.ПолУчастника.Женский;
			Иначе
				ТекЗнач.Пол = Перечисления.ПолУчастника.Мужской;
			КонецЕсли;
		КонецЕсли; 	
	КонецЦикла; 
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьВсехУчастников(Команда)
	ЗагрузитьВсехУчастниковНаСервере();
	Если ВвестиНачальныйРейтинг Тогда
		ПоказатьОповещениеПользователя("Успешно", ПолучитьНавигационнуюСсылку(СсылкаНаНачальныйРейтинг),
			"Загрузка участников завершена, ввод начального рейтинга произведен!", БиблиотекаКартинок.Информация);
	Иначе
		ПоказатьОповещениеПользователя("Успешно", ПолучитьНавигационнуюСсылку(Объект), "Загрузка участников завершена!",
			БиблиотекаКартинок.Информация);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьВсехУчастниковНаСервере()
	
	тзДанныеЗагрузки = РеквизитФормыВЗначение("ДанныеЗагрузки",Тип("ТаблицаЗначений"));
	
	Если ВвестиНачальныйРейтинг Тогда
		Док = Документы.ВводНачальногоРейтинга.СоздатьДокумент();
		Док.Дата = ТекущаяДата();
		Файл = Новый Файл(Объект.ПутьКФайлу);
		Док.Комментарий = "Создан автоматически из файла :"+Файл.Имя;	
	КонецЕсли;
	
	Для Каждого ТекЗначение Из тзДанныеЗагрузки Цикл
		 //КЛУБ - создается отдельно
		 Если ЗначениеЗаполнено(ТекЗначение.Клуб) Тогда
			 НовЗначКлуб = СерверныеСервер.СоздатьКлуб(ТекЗначение.Клуб); 
		 КонецЕсли;
		 Если ЗначениеЗаполнено(ТекЗначение.Город) Тогда
			 НовЗначГорода = СерверныеСервер.СоздатьГород(ТекЗначение.Город); 
		 КонецЕсли;
		 Если ЗначениеЗаполнено(ТекЗначение.Тренер) Тогда
		 	 НовТренер = СерверныеСервер.СоздатьТренера(ТекЗначение.Тренер);
		 КонецЕсли; 
		 //Участник
		//ФИО,ДатаРождения,Пол,ФактическийАдрес,Клуб,МобТелефон,Эмэйл
		Участник = СерверныеСервер.СоздатьУчастника(ТекЗначение,НовЗначКлуб,НовЗначГорода,НовТренер,ГруппаСправочника);
		Если ВвестиНачальныйРейтинг Тогда
			НовСтрока = Док.Данные.Добавить();
			НовСтрока.Игрок = Участник;
			НовСтрока.Рейтинг = ТекЗначение.Рейтинг;
			НовСтрока.ВидРейтинга = ВидРейтинга;
		КонецЕсли;
	КонецЦикла;
	Если ВвестиНачальныйРейтинг Тогда
		Если Док.Данные.Количество() > 0 Тогда
			Попытка
				Док.Записать(РежимЗаписиДокумента.Проведение);
			Исключение
				Док.Записать(РежимЗаписиДокумента.Запись);
			КонецПопытки;
			СсылкаНаНачальныйРейтинг = Док.Ссылка;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьНеопределенных(Команда)
	
	ОчиститьСообщения();	
	МассивОшибок = ПроверкаНаОдинаковыхУчастников();
	Если МассивОшибок.Количество() > 0 Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.ИдентификаторНазначения = ЭтотОбъект.УникальныйИдентификатор;
		Сообщение.Текст = "Есть повторяющиеся участники!";
		Сообщение.Сообщить(); 
		Для каждого ТекОшибка Из МассивОшибок Цикл
			СтрокаДанных = ДанныеЗагрузки.НайтиПоИдентификатору(ТекОшибка);	
			Если СтрокаДанных <> Неопределено Тогда
				Сообщение = Новый СообщениеПользователю;
				Сообщение.Поле = "ДанныеЗагрузки["+ДанныеЗагрузки.Индекс(СтрокаДанных)+"].ФИО";
				Сообщение.Текст = ""+СтрокаДанных.ФИО+" в строке №"+СтрокаДанных.НомерСтроки;
				Сообщение.Сообщить();
			КонецЕсли; 
		КонецЦикла;
		Сообщение = Новый СообщениеПользователю;
		Сообщение.ИдентификаторНазначения = ЭтотОбъект.УникальныйИдентификатор;
		Сообщение.Текст = "Для исправления ошибки необходимо сделать:
		|1. Внести/изменить дату рождения.
		|2. Внести полное Ф.И.О.";
		Сообщение.Сообщить(); 
	Иначе
		Попытка
			ЗагрузитьВсехУчастниковНаСервере();
			Если ВвестиНачальныйРейтинг Тогда
				ПоказатьОповещениеПользователя("Успешно",ПолучитьНавигационнуюСсылку(СсылкаНаНачальныйРейтинг),"Загрузка участников завершена, ввод начального рейтинга произведен!",БиблиотекаКартинок.Информация);
			Иначе
				ПоказатьОповещениеПользователя("Успешно",ПолучитьНавигационнуюСсылку(Объект),"Загрузка участников завершена!",БиблиотекаКартинок.Информация);
			КонецЕсли;
		Исключение
			ПоказатьОповещениеПользователя("ОШИБКА",,"Произошла ошибка, документ создан и записан!"+ОписаниеОшибки());
		КонецПопытки;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПроверкаНаОдинаковыхУчастников()
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.Текст = "ВЫБРАТЬ * ПОМЕСТИТЬ втТЗ ИЗ &Внеш КАК Внеш";
	Запрос.УстановитьПараметр("Внеш",ДанныеЗагрузки.Выгрузить());
	Запрос.Выполнить();
	Запрос.Текст = "ВЫБРАТЬ
	|	втТЗ.ФИО,
	|	втТЗ.ДатаРождения,
	|	СУММА(1) КАК Количество
	|ПОМЕСТИТЬ втВсеДанные
	|ИЗ
	|	втТЗ КАК втТЗ
	|
	|СГРУППИРОВАТЬ ПО
	|	втТЗ.ФИО,
	|	втТЗ.ДатаРождения
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	втВсеДанные.ФИО КАК ФИО,
	|	втВсеДанные.ДатаРождения
	|ИЗ
	|	втВсеДанные КАК втВсеДанные
	|ГДЕ
	|	втВсеДанные.Количество > 1
	|
	|УПОРЯДОЧИТЬ ПО
	|	ФИО";
	Результат = Запрос.Выполнить().Выгрузить();
	МассивСтрокВДанных = Новый Массив;
	//ищем строки в данных и добавляем в массив, для вывода ошибок
	Для каждого ТекСтр Из Результат Цикл
		Отбор = Новый Структура;
		Отбор.Вставить("ФИО",ТекСтр.ФИО);
		Отбор.Вставить("ДатаРождения",ТекСтр.ДатаРождения);
		ИскомыеСтроки = ДанныеЗагрузки.НайтиСтроки(Отбор);
		Для каждого ИскСтрока Из ИскомыеСтроки Цикл
			МассивСтрокВДанных.Добавить(ИскСтрока.ПолучитьИдентификатор());
		КонецЦикла; 
	КонецЦикла;
	
	Возврат МассивСтрокВДанных;
	
КонецФункции
 
&НаКлиенте
Процедура ПутьКФайлуОткрытие(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	НачатьЗапускПриложения(Новый ОписаниеОповещения("ПослеЗапускаПриложения",ЭтотОбъект), Объект.ПутьКФайлу);
КонецПроцедуры

&НаКлиенте
//@skip-warning
Процедура ПослеЗапускаПриложения(КодВозврата,ДополнительныеПараметры) Экспорт
	
КонецПроцедуры
 


