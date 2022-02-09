
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ДатаНачалаМесяцаЗапроса = ТекущаяДатаСеанса();
	ЗаполнитьСписокДляОформленияСоревнований(ДатаНачалаМесяцаЗапроса, КонецМесяца(ДатаНачалаМесяцаЗапроса));
	Элементы.Группа5.Видимость = Ложь;
	ТекДень = День(ДатаНачалаМесяцаЗапроса);
	ИнфЛегенда1 = ТекДень;
	ИнфЛегенда2 = ТекДень;
	ИнфЛегенда3 = ТекДень;
	СписокДляОформления.Добавить(Новый Структура("Ключ",123),"123");
		
КонецПроцедуры
 
&НаСервере
Процедура ЗаполнитьСписокДляОформленияСоревнований(Начало,Конец)
	
	ТаблицаСоревнований.Очистить();
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	ИсторияСоревнований.Регистратор КАК Количество,
	|	НАЧАЛОПЕРИОДА(ИсторияСоревнований.ДатаСоревнования, ДЕНЬ) КАК Дата,
	|	ИсторияСоревнований.Регистратор.НазваниеСоревнования КАК НазваниеСоревнования,
	|	ИсторияСоревнований.Регистратор.Проведен КАК Проведен
	|ИЗ
	|	РегистрСведений.ИсторияСоревнований КАК ИсторияСоревнований
	|ГДЕ
	|	ИсторияСоревнований.Регистратор.ПометкаУдаления = ЛОЖЬ
	|	И ИсторияСоревнований.Период МЕЖДУ &Нач И &Кон
	|
	|УПОРЯДОЧИТЬ ПО
	|	Дата
	|ИТОГИ
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ Количество)
	|ПО
	|	Дата";
	Запрос.УстановитьПараметр("Нач",НачалоДня(Начало));
	Запрос.УстановитьПараметр("Кон",КонецДня(Конец));
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	Пока Выборка.Следующий() Цикл
		ТекКолДоков = Выборка.Количество;
		ТекстПодсказки = Формат(Выборка.Дата,"ДЛФ=DD");
		ВтораяВыборка = Выборка.Выбрать();
		//Данные = Новый Структура;
		Если ТекКолДоков = 1 Тогда
			ВтораяВыборка.Следующий();
			ДокументСоревнования = ВтораяВыборка.Количество;	
			ТекстПодсказки = ТекстПодсказки+Символы.ПС+ВтораяВыборка.НазваниеСоревнования;
			//Данные.Вставить("Подсказка",ТекстПодсказки);
			//Если ВтораяВыборка.Проведен Тогда //значит рассчитан
			//	Данные.Вставить("Проведен",Истина);
			//	//ТекДата.ЦветФона	= WebЦвета.СветлоЗеленый;
			//	//ТекДата.Шрифт			 = Новый Шрифт(,,Истина);
			//Иначе
			//	//ТекДата.ЦветФона	= WebЦвета.СеребристоСерый;
			//	Данные.Вставить("Проведен",Ложь);
			//КонецЕсли;
			//СписокДляОформления.Добавить(Данные,Строка(Выборка.Дата));
			НовСтрока = ТаблицаСоревнований.Добавить();
			НовСтрока.Дата						= Выборка.Дата; 
			НовСтрока.Представление = ТекстПодсказки;
			НовСтрока.Проведен			= ВтораяВыборка.Проведен;
			мСписок = Новый СписокЗначений;
			мСписок.Добавить(ДокументСоревнования);
			НовСтрока.Документ			= мСписок;
			
		ИначеЕсли ТекКолДоков > 1 Тогда
			мСписок = Новый СписокЗначений;
			Пока ВтораяВыборка.Следующий() Цикл
				ТекстПодсказки = ТекстПодсказки+Символы.ПС+?(ВтораяВыборка.НазваниеСоревнования = "","",ВтораяВыборка.НазваниеСоревнования);
				мСписок.Добавить(ВтораяВыборка.Количество);
			КонецЦикла; 
			//ТекДата.ЦветФона	= WebЦвета.НебесноГолубой;
			//Данные.Вставить("Подсказка",ТекстПодсказки);
			//Данные.Вставить("Проведен",Неопределено);
			
			НовСтрока = ТаблицаСоревнований.Добавить();
			НовСтрока.Дата						= Выборка.Дата; 
			НовСтрока.Представление = ТекстПодсказки;
			НовСтрока.Проведен			= Ложь;
			НовСтрока.Документ			= мСписок;
		КонецЕсли; 
	КонецЦикла; 
		
КонецПроцедуры

&НаКлиенте
Процедура ДатаНачалаМесяцаЗапросаВыбор(Элемент, ВыбраннаяДата)
	
	СписокДействий = Новый СписокЗначений;
	ИскомаяДата = ТаблицаСоревнований.НайтиСтроки(Новый Структура("Дата", ВыбраннаяДата));
	Если ИскомаяДата.Количество() = 1 Тогда
		ПредставлениеДляСписка = ?(ИскомаяДата[0].Представление = "", Строка(ИскомаяДата[0].Документ),
			ИскомаяДата[0].Представление);
		СписокДействий.Добавить(ИскомаяДата[0].Документ, ПредставлениеДляСписка, , БиблиотекаКартинок.ДокументОбъект);
		СписокДействий.Добавить("Добавить", "Добавить соревнование", , БиблиотекаКартинок.СоздатьЭлементСписка);
	ИначеЕсли ИскомаяДата.Количество() > 1 Тогда
		Для Каждого ТекСоревнование Из ИскомаяДата Цикл
			ПредставлениеДляСписка = ?(ТекСоревнование.Представление = "", Строка(ТекСоревнование.Документ),
				ТекСоревнование.Представление);
			СписокДействий.Добавить(ТекСоревнование.Документ, ПредставлениеДляСписка, ,
				БиблиотекаКартинок.ДокументОбъект);
		КонецЦикла;
		СписокДействий.Добавить("Добавить", "Добавить соревнование", , БиблиотекаКартинок.СоздатьЭлементСписка);
	КонецЕсли;
	Если СписокДействий.Количество() = 0 Тогда
		ПараметрыДанных = Новый Структура("ДатаКалендаря", ВыбраннаяДата);
		ОткрытьФорму("Документ.ПроведениеСоревнования.ФормаОбъекта", ПараметрыДанных);
	Иначе
		СписокДействий.ПоказатьВыборЭлемента(Новый ОписаниеОповещения("ДатаНачалаМесяцаЗапросаВыборЗавершение",
			ЭтотОбъект, Новый Структура("ВыбраннаяДата", ВыбраннаяДата)), "Выберите действие...");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДатаНачалаМесяцаЗапросаВыборЗавершение(ВыбранныйЭлемент, ДополнительныеПараметры) Экспорт
	
	ВыбраннаяДата = ДополнительныеПараметры.ВыбраннаяДата;
	ВыбратьЭлемент = ВыбранныйЭлемент;
	Если ВыбратьЭлемент <> Неопределено Тогда
		Если ТипЗнч(ВыбратьЭлемент.Значение) = Тип("Строка") Тогда
			ПараметрыДанных = Новый Структура("ДатаКалендаря",ВыбраннаяДата);
			ОткрытьФорму("Документ.ПроведениеСоревнования.ФормаОбъекта",ПараметрыДанных);
		Иначе
			ПоказатьЗначение(,ВыбратьЭлемент.Значение[0].Значение);
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ДатаНачалаМесяцаЗапросаПриВыводеПериода(Элемент, ОформлениеПериода)
	
	ЗаполнитьСписокДляОформленияСоревнований(ОформлениеПериода.НачалоПериода,ОформлениеПериода.КонецПериода);
	
	Для Каждого ТекДата Из ОформлениеПериода.Даты Цикл
		ИскомаяДата = ТаблицаСоревнований.НайтиСтроки(Новый Структура("Дата",ТекДата.Дата));
		Если ИскомаяДата.Количество() = 0 Тогда
			Продолжить;
		КонецЕсли; 
		
		ТекстПодсказки = Формат(ТекДата.Дата,"ДЛФ=DD");
		Если ИскомаяДата.Количество() > 0 Тогда
			СтрокаИскомая = ИскомаяДата[0];
			Если СтрокаИскомая.Документ.Количество() = 1 Тогда //значит рассчитан
				СтрокаСоревнования = СтрокаИскомая;
				ТекстПодсказки = ТекстПодсказки+Символы.ПС+СтрокаСоревнования.Представление;
				Если СтрокаСоревнования.Проведен Тогда //значит рассчитан
					ТекДата.ЦветФона	= WebЦвета.СветлоЗеленый;
					ТекДата.Шрифт			 = Новый Шрифт(,,Истина);
				Иначе
					ТекДата.ЦветФона	= WebЦвета.СеребристоСерый;
				КонецЕсли;
			ИначеЕсли СтрокаИскомая.Документ.Количество() > 1 Тогда  //много соревнований за один день
				Для Каждого ТекИскомаяДата Из ИскомаяДата Цикл
					ТекстПодсказки = ТекстПодсказки+Символы.ПС+?(ТекИскомаяДата.Представление = "","",ТекИскомаяДата.Представление);
				КонецЦикла;
				ТекДата.ЦветФона	= WebЦвета.НебесноГолубой;
			КонецЕсли; 
		КонецЕсли; 
		ТекДата.Подсказка = ТекстПодсказки;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура Декорация4Нажатие(Элемент)
	Если Элементы.Группа5.Видимость Тогда
		Элементы.Группа5.Видимость = Ложь;
	Иначе
		Элементы.Группа5.Видимость = Истина;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьПКМ(Команда)
	
	ПараметрыДанных = Новый Структура("ДатаКалендаря",ДатаНачалаМесяцаЗапроса);
	ОткрытьФорму("Документ.ПроведениеСоревнования.ФормаОбъекта",ПараметрыДанных);
	
КонецПроцедуры

&НаКлиенте
Процедура Декорация5Нажатие(Элемент)
	НачатьЗапускПриложения(, "www.ttmarket.su");
КонецПроцедуры

&НаКлиенте
Процедура ТекстДляАкцийМагазинаПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Если ДанныеСобытия.Anchor <> Неопределено Тогда
		Если ДанныеСобытия.Anchor.tagName = "A" Тогда
			НачатьЗапускПриложения(, ДанныеСобытия.Href);	
		КонецЕсли; 
	КонецЕсли; 
	
КонецПроцедуры
