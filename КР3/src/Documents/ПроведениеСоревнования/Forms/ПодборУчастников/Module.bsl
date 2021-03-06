
&НаКлиенте
Процедура УдалитьИзВыбранных(Команда)
	
	//определим текущую строку или строки
	Если Элементы.ВыбранныеУчастники.ВыделенныеСтроки.Количество() > 1 Тогда //выделено больше одного элемента
		ВыделенныеСтроки = Элементы.ВыбранныеУчастники.ВыделенныеСтроки;
		Для ВыбСтрока = 0 По ВыделенныеСтроки.ВГраница() Цикл
			//проверяем элемент
			//проверим нет ли этого участника уже в списке
			СтрокаСписка = ВыбранныеУчастники.НайтиПоИдентификатору(ВыделенныеСтроки[ВыбСтрока]);
			//а теперь удалим из списка
			ВыбранныеУчастники.Удалить(СтрокаСписка);
		КонецЦикла;
	Иначе
		ТекДанные = Элементы.ВыбранныеУчастники.ТекущиеДанные;
		ВыбранныеУчастники.Удалить(ТекДанные);
	КонецЕсли;
	//ВыбранныеУчастники.Сортировать("Рейтинг Убыв");
	ОбновитьИтоги();
	//УстановитьОтборыВСписке();
	УстановитьПараметрВСписок(СписокУчастниковДляПодбора,ВыбранныеУчастники,ВсеУчастникиКомандныхСоревнований);
	
КонецПроцедуры

&НаКлиенте
Процедура ВВыбранные(Команда)
	
	ТекДанные = Элементы.СписокУчастниковДляПодбора.ТекущиеДанные;
	//проверим нет ли этого участника уже в добавленных
	Искомый = ВыбранныеУчастники.НайтиСтроки(Новый Структура("Участник",ТекДанные.Участник));
	Если Искомый.Количество() = 0 Тогда
		//добавили
		НовСтрока = ВыбранныеУчастники.Добавить();
		НовСтрока.Участник = ТекДанные.Участник;
		НовСтрока.Рейтинг  = ТекДанные.Рейтинг;
		//ПоказатьОповещениеПользователя(,ПолучитьНавигационнуюСсылку(ТекДанные.Участник),""+ТекДанные.Участник+" добавлен в выбранные!",БиблиотекаКартинок.Информация);
		ИнфСтрока = ""+ТекДанные.Участник+" добавлен в выбранные!"; 
	Иначе
		НовСообщение = Новый СообщениеПользователю;
		НовСообщение.Текст = Строка(Искомый[0].Участник)+" уже есть в выбранных участниках";
		НовСообщение.Поле  = "ВыбранныеУчастники["+ВыбранныеУчастники.Индекс(Искомый[0])+"].Участник";
		НовСообщение.ИдентификаторНазначения = ЭтотОбъект.УникальныйИдентификатор;
		НовСообщение.Сообщить();
	КонецЕсли;
	
	//ВыбранныеУчастники.Сортировать("Рейтинг УБЫВ, Участник ВОЗР");
	ОбновитьИтоги();
	//УстановитьОтборыВСписке();
	УстановитьПараметрВСписок(СписокУчастниковДляПодбора,ВыбранныеУчастники,ВсеУчастникиКомандныхСоревнований);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьПараметрВСписок(Список,Выбранные,ВсеУчастникиКомандныхСоревнований)
	
	МассивВыбранных = Новый Массив;
	Для каждого ТекСтр Из Выбранные Цикл
		МассивВыбранных.Добавить(ТекСтр.Участник);
	КонецЦикла; 
	Для каждого ТекСтр Из ВсеУчастникиКомандныхСоревнований Цикл
		МассивВыбранных.Добавить(ТекСтр.Значение);
	КонецЦикла; 
	Список.Параметры.УстановитьЗначениеПараметра(Новый ПараметрКомпоновкиДанных("СписокВыбранных"),МассивВыбранных);
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЗначениеВРеквизитФормы(ДанныеФормыВЗначение(Параметры.Соревнование,Тип("ДокументОбъект.ПроведениеСоревнования")),"ОбъектДокумент");
	ДокНовый = Параметры.Новый;
	ТипСоревнования = Перечисления.ТипСоревнования.Смешанные;
	ВидРейтинга = ОбъектДокумент.ВидРейтинга;
	Если ОбъектДокумент.ОбщийРежимСоревнования = 0 Или ОбъектДокумент.ОбщийРежимСоревнования = 1 Тогда
		ВременнаяТЗ = ОбъектДокумент.СписокУчастников.Выгрузить(,"Участник,ТекущийРейтинг");
		Для Каждого ТекСтрока Из ВременнаяТЗ Цикл
			НовСтрока = СписокУчастников.Добавить();
			НовСтрока.Участник = ТекСтрока.Участник;
			НовСтрока = ВыбранныеУчастники.Добавить();
			НовСтрока.Участник = ТекСтрока.Участник;
			НовСтрока.Рейтинг    = ТекСтрока.ТекущийРейтинг;
		КонецЦикла;	
	ИначеЕсли ОбъектДокумент.ОбщийРежимСоревнования = 2 Тогда //командные
		мТекКоманда = Параметры.ТекКоманда;
		ЭтотОбъект.Заголовок = "Состав """+мТекКоманда+"""";
		ЭтотОбъект.АвтоЗаголовок = Ложь;
		УчастникиКомандыТекКоманды = ОбъектДокумент.ТаблицаКоманд.Выгрузить(Новый Структура("НазваниеКоманды",мТекКоманда));
		Для Каждого ТекСтр Из УчастникиКомандыТекКоманды Цикл
			НовСтрока = ВыбранныеУчастники.Добавить();
			НовСтрока.Участник = ТекСтр.Участник;
			НовСтрока.Рейтинг    = ТекСтр.ТекущийРейтинг;
		КонецЦикла;
		Для каждого ТекСтр Из ОбъектДокумент.ТаблицаКоманд Цикл
			ВсеУчастникиКомандныхСоревнований.Добавить(ТекСтр.Участник);
		КонецЦикла; 
	КонецЕсли; 
	НачДата = Дата('00010101');
	СписокСмешанныхТипов.Добавить(Перечисления.ПолУчастника.Женский);
	СписокСмешанныхТипов.Добавить(Перечисления.ПолУчастника.Мужской);
	СписокСмешанныхТипов.Добавить(Перечисления.ПолУчастника.ПустаяСсылка());
	
	СписокЗнаковОтбора.Добавить(ВидСравненияКомпоновкиДанных.Больше,">");
	СписокЗнаковОтбора.Добавить(ВидСравненияКомпоновкиДанных.БольшеИлиРавно,">=");
	СписокЗнаковОтбора.Добавить(ВидСравненияКомпоновкиДанных.Меньше,"<");
	СписокЗнаковОтбора.Добавить(ВидСравненияКомпоновкиДанных.МеньшеИлиРавно,"<=");
	СписокЗнаковОтбора.Добавить(ВидСравненияКомпоновкиДанных.Равно,"=");
	УстановитьОтборыВСписке();
	УстановитьПараметрВСписок(СписокУчастниковДляПодбора,ВыбранныеУчастники,ВсеУчастникиКомандныхСоревнований);
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьВСоревнования(Команда)
	
	ОповеститьОВыборе(ВыбранныеУчастники);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбранныеУчастникиВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	УдалитьИзВыбранных(Неопределено);
КонецПроцедуры

&НаКлиенте
Процедура УдалитьВсех(Команда)
	
	ВыбранныеУчастники.Очистить();
	ОбновитьИтоги();
	//УстановитьОтборыВСписке();
	УстановитьПараметрВСписок(СписокУчастниковДляПодбора,ВыбранныеУчастники,ВсеУчастникиКомандныхСоревнований);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИтоги()
	
	ИтогоВыбранные = ВыбранныеУчастники.Количество();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	//УстановитьОтборыВСписке();
	УстановитьПараметрВСписок(СписокУчастниковДляПодбора,ВыбранныеУчастники,ВсеУчастникиКомандныхСоревнований);
	ОбновитьИтоги();
КонецПроцедуры

&НаКлиенте
Процедура СтрокаПоиска1АвтоПодбор(Элемент, Текст, ДанныеВыбора, Ожидание, СтандартнаяОбработка)
	//выбранные участники
	Если ВыбранныеУчастники.Количество() > 0 Тогда
		Элементы.ВыбранныеУчастники.ТекущаяСтрока = НайтиПервогоУчастникаПоТексту(Текст,Истина);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Функция НайтиПервогоУчастникаПоТексту(Текст,ПоВыбранным = Ложь)
	
	Если ПоВыбранным Тогда
		ТаблицаДанных = ВыбранныеУчастники;
	Иначе
		ТаблицаДанных = ВыбранныеУчастники;
	КонецЕсли;
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.Текст = "ВЫБРАТЬ * ПОМЕСТИТЬ втТЗ ИЗ &Внеш КАК Внеш";
	Запрос.УстановитьПараметр("Внеш",ТаблицаДанных.Выгрузить());
	Запрос.Выполнить();
	Запрос.Текст = "ВЫБРАТЬ
	|	втТЗ.Участник,
	|	ПОДСТРОКА(втТЗ.Участник.Наименование, 1, &Длина) КАК Наименование
	|ИЗ
	|	втТЗ КАК втТЗ
	|ГДЕ
	|	втТЗ.Участник.Наименование ПОДОБНО ""%"" + &Текст + ""%""";
	Запрос.УстановитьПараметр("Текст",Текст);
	Запрос.УстановитьПараметр("Длина",СтрДлина(Текст));
	Результат = Запрос.Выполнить().Выгрузить();
	//првратим все в верхний регистр
	Для Каждого ТекСтр Из Результат Цикл ТекСтр.Наименование = ВРег(ТекСтр.Наименование); КонецЦикла;
	СтрСУчастником = Результат.Найти(ВРег(Текст),"Наименование");
	
	Если СтрСУчастником <> Неопределено Тогда
		МассивСтрокПоиска = ТаблицаДанных.НайтиСтроки(Новый Структура("Участник",СтрСУчастником.Участник));
		Если МассивСтрокПоиска.Количество() > 0 Тогда
			Возврат МассивСтрокПоиска[0].ПолучитьИдентификатор();
		Иначе
			Возврат 0;
		КонецЕсли;
	Иначе
		Возврат 0;
	КонецЕсли;

КонецФункции

&НаКлиенте
Процедура СписокУчастниковДляПодбораВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ВВыбранные(Неопределено);
КонецПроцедуры

&НаКлиенте
Процедура ГруппаПриИзменении(Элемент)
	УстановитьОтборыВСписке();
	УстановитьПараметрВСписок(СписокУчастниковДляПодбора,ВыбранныеУчастники,ВсеУчастникиКомандныхСоревнований);
КонецПроцедуры

&НаКлиенте
Процедура НачДатаПриИзменении(Элемент)
	УстановитьОтборыВСписке();	
КонецПроцедуры

&НаКлиенте
Процедура ТипСоревнованияПриИзменении(Элемент)
	УстановитьОтборыВСписке();	
КонецПроцедуры

&НаКлиенте
Процедура ВидРейтингаПриИзменении(Элемент)
	УстановитьОтборыВСписке();	
КонецПроцедуры

&НаСервере
Процедура УстановитьОтборыВСписке()
	
	ОтборСписка = СписокУчастниковДляПодбора.Отбор.Элементы;
	ОтборСписка.Очистить();
	//дата рождения
	Если ЗначениеЗаполнено(НачДата) Тогда
		УсловиеОтбора = ОтборСписка.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		УсловиеОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДатаРождения");
		УсловиеОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.БольшеИлиРавно;
		УсловиеОтбора.ПравоеЗначение = НачДата;
	КонецЕсли;
	//тип соревнований
	Если ЗначениеЗаполнено(ТипСоревнования) Тогда
		УсловиеОтбора = ОтборСписка.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		УсловиеОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Участник.Пол");
		Если ТипСоревнования = ПредопределенноеЗначение("Перечисление.ТипСоревнования.Смешанные") Тогда
			УсловиеОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке;
			УсловиеОтбора.ПравоеЗначение = СписокСмешанныхТипов;
		ИначеЕсли ТипСоревнования = ПредопределенноеЗначение("Перечисление.ТипСоревнования.Женские") Тогда
			УсловиеОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
			УсловиеОтбора.ПравоеЗначение = ПредопределенноеЗначение("Перечисление.ПолУчастника.Женский");
		ИначеЕсли ТипСоревнования = ПредопределенноеЗначение("Перечисление.ТипСоревнования.Мужские") Тогда
			УсловиеОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
			УсловиеОтбора.ПравоеЗначение = ПредопределенноеЗначение("Перечисление.ПолУчастника.Мужской");
		КонецЕсли;
	КонецЕсли;
	//группа
	Если ЗначениеЗаполнено(Группа) Тогда
		УсловиеОтбора = ОтборСписка.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		УсловиеОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Участник.Родитель");
		УсловиеОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
		УсловиеОтбора.ПравоеЗначение = Группа;
	КонецЕсли;
	//вид рейтинга
	//Если ЗначениеЗаполнено(ВидРейтинга) Тогда
	СписокУчастниковДляПодбора.Параметры.УстановитьЗначениеПараметра(Новый ПараметрКомпоновкиДанных("ВидРейтинга"),ВидРейтинга);
	//КонецЕсли;
	//список выбранных
	Если ВыбранныеУчастники.Количество() > 0 Тогда
		//перемСписокВыбранных = Новый СписокЗначений;
		//Для Каждого ТекУч Из ВыбранныеУчастники Цикл перемСписокВыбранных.Добавить(ТекУч.Участник); КонецЦикла;
		//УсловиеОтбора = ОтборСписка.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		//УсловиеОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Участник");
		//УсловиеОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.НеВСписке;
		//УсловиеОтбора.ПравоеЗначение = перемСписокВыбранных;
	КонецЕсли;
	//рейтинг отбора
	Если ЗначениеЗаполнено(ЭлементФормыЗнаковРавенства) Тогда
		УсловиеОтбора = ОтборСписка.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		УсловиеОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Рейтинг");
		УсловиеОтбора.ВидСравнения = СписокЗнаковОтбора.Получить(Число(ЭлементФормыЗнаковРавенства)).Значение;
		УсловиеОтбора.ПравоеЗначение = РейтингОтбора;
	КонецЕсли;
	//Элементы.СписокУчастниковДляПодбора.Обновить();

КонецПроцедуры

&НаКлиенте
Процедура ВыбранныеУчастникиПослеУдаления(Элемент)
	УстановитьОтборыВСписке();
	УстановитьПараметрВСписок(СписокУчастниковДляПодбора,ВыбранныеУчастники,ВсеУчастникиКомандныхСоревнований);
	ОбновитьИтоги();
КонецПроцедуры

&НаКлиенте
Процедура СортировкаВозр(Команда)
	УстановкаСортировкиДинамическогоСпискаПоПолю("Возр");
КонецПроцедуры

&НаКлиенте
Процедура СортировкаУбыв(Команда)
	УстановкаСортировкиДинамическогоСпискаПоПолю("Убыв");
КонецПроцедуры

&НаКлиенте
Процедура УстановкаСортировкиДинамическогоСпискаПоПолю(ВидСортировки)
	СортировкиСписка = СписокУчастниковДляПодбора.Порядок.Элементы;
	СортировкиСписка.Очистить();
	ТекКолонка = Элементы.СписокУчастниковДляПодбора.ТекущийЭлемент.Имя;
	ИмяЯчейки = СтрЗаменить(ТекКолонка,"СписокУчастниковДляПодбора","");
	ЭлементСортировки = СортировкиСписка.Добавить(Тип("ЭлементПорядкаКомпоновкиДанных"));	
	ЭлементСортировки.Поле = Новый ПолеКомпоновкиДанных(ИмяЯчейки);
	ЭлементСортировки.ТипУпорядочивания = НаправлениеСортировкиКомпоновкиДанных[ВидСортировки]
КонецПроцедуры

&НаКлиенте
Процедура РежимОтображенияСписков(Команда)
	
	Если Элементы.СписокУчастниковДляПодбора.Отображение = ОтображениеТаблицы.Список Тогда 
		Элементы.СписокУчастниковДляПодбора.Отображение = ОтображениеТаблицы.ИерархическийСписок;
		Элементы.РежимОтображенияСписков.Картинка = БиблиотекаКартинок.РежимПросмотраСпискаИерархическийСписок;
	Иначе
		Элементы.СписокУчастниковДляПодбора.Отображение = ОтображениеТаблицы.Список;
		Элементы.РежимОтображенияСписков.Картинка = БиблиотекаКартинок.РежимПросмотраСпискаСписок;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НачДатаОчистка(Элемент, СтандартнаяОбработка)
	УстановитьОтборыВСписке();
КонецПроцедуры

&НаКлиенте
Процедура ГруппаОчистка(Элемент, СтандартнаяОбработка)
	УстановитьОтборыВСписке();
КонецПроцедуры

&НаКлиенте
Процедура ВидРейтингаОчистка(Элемент, СтандартнаяОбработка)
	УстановитьОтборыВСписке();
КонецПроцедуры

&НаКлиенте
Процедура Декорация5Нажатие(Элемент)
	ОповеститьОВыборе(ВыбранныеУчастники);
КонецПроцедуры

&НаКлиенте
Процедура РейтингОтбораПриИзменении(Элемент)
	УстановитьОтборыВСписке();
КонецПроцедуры

&НаКлиенте
Процедура РейтингОтбораОчистка(Элемент, СтандартнаяОбработка)
	УстановитьОтборыВСписке();
КонецПроцедуры

&НаКлиенте
Процедура ЭлементФормыЗнаковРавенстваПриИзменении(Элемент)
	УстановитьОтборыВСписке();
КонецПроцедуры

&НаКлиенте
Процедура ЭлементФормыЗнаковРавенстваОчистка(Элемент, СтандартнаяОбработка)
	УстановитьОтборыВСписке();
КонецПроцедуры

