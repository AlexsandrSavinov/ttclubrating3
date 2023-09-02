
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
		
	Параметры.Свойство("КолПартий",КолПартий);
	
	НомерТура 		= Параметры.НомерТура;
	НомерГруппы	= Параметры.НомерГруппы;
		
	Если Параметры.НомерВ < Параметры.НомерП Тогда
		НовСтрока = ТаблицаПартий.Добавить();
		НовСтрока.Участник 					= Параметры.Выигравший;
		НовСтрока.НомерУчастника 		= Параметры.НомерВ;
		
		НовСтрока2 = ТаблицаПартий.Добавить();
		НовСтрока2.Участник 					= Параметры.Проигравший;
		НовСтрока2.НомерУчастника 	= Параметры.НомерП;
	Иначе
		НовСтрока2 = ТаблицаПартий.Добавить();
		НовСтрока2.Участник 					= Параметры.Проигравший;
		НовСтрока2.НомерУчастника 	= Параметры.НомерП;
		
		НовСтрока = ТаблицаПартий.Добавить();
		НовСтрока.Участник 					= Параметры.Выигравший;
		НовСтрока.НомерУчастника		= Параметры.НомерВ;
	КонецЕсли;
			
	Если ЭтоАдресВременногоХранилища(Параметры.АдресОбщейТаблицы) Тогда
		
		ТЧДока = ПолучитьИзВременногоХранилища(Параметры.АдресОбщейТаблицы);
		
		Отбор = Новый Структура;
		Отбор.Вставить("НомерТура",НомерТура);
		Отбор.Вставить("НомерГруппы",НомерГруппы);
		Отбор.Вставить("Выигравший",Параметры.Выигравший);
		Отбор.Вставить("Проигравший",Параметры.Проигравший);
		МассивОчков = ТЧДока.НайтиСтроки(Отбор);
		
		Если МассивОчков = 0 Тогда //пробуем наоборот
			Отбор.Вставить("Выигравший",Параметры.Проигравший);
			Отбор.Вставить("Проигравший",Параметры.Выигравший);
			МассивОчков = ТЧДока.НайтиСтроки(Отбор);
		КонецЕсли; 
		
		Если МассивОчков.Количество() > 1 Тогда
			Элементы.ВводПоОчкам.ЗаголовокСвернутогоОтображения = "Ввод по очкам (заполнены очки по сетам)";
			Для н  = 1 По МассивОчков.Количество() Цикл
				//посчитаем очки для выигравшего
				ТекОчки = МассивОчков[н-1].КолШаров;
				Если ТекОчки < 0 Тогда //это проигравшего
					Если ТекОчки <= -11 Тогда
						ЗначВторое = -ТекОчки +2;
					Иначе
						ЗначВторое = 11;
					КонецЕсли;
					НовСтрока2["Игра"+Н] 	= ЗначВторое;
					НовСтрока["Игра"+Н] 	= -ТекОчки;
				ИначеЕсли ТекОчки = 0 Тогда
					НовСтрока2["Игра"+Н]   = ТекОчки;
					НовСтрока["Игра"+Н] 	 = 11;
				ИначеЕсли ТекОчки >= 10 Тогда //это баланс
					НовСтрока2["Игра"+Н]   = ТекОчки;
					НовСтрока["Игра"+Н] 	 = ТекОчки+2;
				ИначеЕсли ТекОчки <= 11 И ТекОчки > 0 Тогда
					НовСтрока2["Игра"+Н] 	= ТекОчки;
					НовСтрока["Игра"+Н] 	= 11;
				ИначеЕсли ТекОчки >= 11 Тогда
					НовСтрока2["Игра"+Н]  = ТекОчки;
					НовСтрока["Игра"+Н] 	= ТекОчки+2;
				КонецЕсли;
			КонецЦикла;
			ПосчитатьИтогиПартийДляТаблицы();
		ИначеЕсли МассивОчков.Количество() = 1 Тогда
			//это или техническое
			СтрокаМассива = МассивОчков[0];
			//или вводили по партиям
			НовСтрока.Итог 		= СтрокаМассива.ОчкиВыигравшего;
			НовСтрока2.Итог 	= СтрокаМассива.ОчкиПроигравшего;
						
			Если СтрокаМассива.ТехническоеП Тогда
				Если СтрокаМассива.Проигравший = НовСтрока.Участник Тогда
					НовСтрока.ТехническоеП   = СтрокаМассива.ТехническоеП;
				ИначеЕсли СтрокаМассива.Проигравший = НовСтрока2.Участник Тогда 	
					НовСтрока2.ТехническоеП 	 = СтрокаМассива.ТехническоеП;
				КонецЕсли; 
			КонецЕсли;
		КонецЕсли;	
	КонецЕсли; 
	
	ИтоговыеДанныеПоТаблицеПартий 		= ОпределитьВыигравшегоИПроигравшегоПоТаблицеПартий();
	ВариантыВыбораКоличестваПартий 	= ИтоговыеДанныеПоТаблицеПартий.КолПартийИзСколькиИграли;
	
	Если ВариантыВыбораКоличестваПартий = 0 Тогда
		ВариантыВыбораКоличестваПартий = 3;
	КонецЕсли; 
	
	ВариантыВыбораКоличестваПартийПриИзмененииНаСервере();
	
	ОпределитьСтрокуПоПартиям();
	
	ПервыйУчастник 	= Общий.СформироватьИмяИгрока(ТаблицаПартий.Получить(0).Участник);
	ВторойУчастник		= Общий.СформироватьИмяИгрока(ТаблицаПартий.Получить(1).Участник);
	
	Заголовок = "Результат встречи: "+ПервыйУчастник + " - "+ВторойУчастник;
	
	Элементы.ТаблицаВыбораПоИтогамКолПартий1.Заголовок = ПервыйУчастник;
	Элементы.ТаблицаВыбораПоИтогамКолПартий2.Заголовок = ВторойУчастник;

КонецПроцедуры

&НаСервере
Процедура ПосчитатьИтогиПартийДляТаблицы()
	
	Если ТаблицаПартий.Количество() < 2 Тогда
		Возврат;
	КонецЕсли; 
	
	ПерваяСтрока 	= ТаблицаПартий.Получить(0);
	ВтораяСтрока  	= ТаблицаПартий.Получить(1);
	ИтогВыигр1 = 0;
	ИтогВыигр2 = 0;
	
	Для Н = 1 По 7 Цикл
		ПервоеЗначение = ПерваяСтрока["Игра"+Н];
		ВтороеЗначение = ВтораяСтрока["Игра"+Н];
		Если ПервоеЗначение = 0 И ВтороеЗначение = 0 Тогда
			Прервать;
		КонецЕсли;
		Если ПервоеЗначение <= 11 И ВтороеЗначение <= 11 Тогда
			Если ПервоеЗначение = 11 Тогда
				ИтогВыигр1 = ИтогВыигр1 +1;
			ИначеЕсли ВтороеЗначение = 11 Тогда
				ИтогВыигр2 = ИтогВыигр2 + 1;
			КонецЕсли;
		ИначеЕсли ПервоеЗначение > ВтороеЗначение Тогда //был баланс
			ИтогВыигр1 = ИтогВыигр1 + 1;
		Иначе
			ИтогВыигр2 = ИтогВыигр2 + 1;
		КонецЕсли;
	КонецЦикла;
	
	втСуммаОчков = 0;
	Для Н = 1 По 7 Цикл
		втСуммаОчков = втСуммаОчков + ТаблицаПартий.Итог("Игра"+Н);
	КонецЦикла; 
	
	Если втСуммаОчков <> 0  Тогда //ввод по очкам был, меняем партии
		ПерваяСтрока.Итог 	= ИтогВыигр1;
		ВтораяСтрока.Итог 	= ИтогВыигр2;
	КонецЕсли; 
	
	ОпределитьСтрокуПоПартиям();
	
КонецПроцедуры

&НаСервере
Процедура ОпределитьСтрокуПоПартиям()
	
	Если ТаблицаПартий.Количество() < 2 Тогда
		Возврат;
	КонецЕсли; 
		
	ОчиститьВыбраннуюСтрокуВТаблице(ТаблицаВыбораПоИтогам);
	
	ИтоговыеДанныеПоТаблицеПартий = ОпределитьВыигравшегоИПроигравшегоПоТаблицеПартий();
		
	ОтборДляТаблицыИтогов = Новый Структура;
	ОтборДляТаблицыИтогов.Вставить("Участник1",ИтоговыеДанныеПоТаблицеПартий.Выигравший);
	ОтборДляТаблицыИтогов.Вставить("Участник2",ИтоговыеДанныеПоТаблицеПартий.Проигравший);
	Если ИтоговыеДанныеПоТаблицеПартий.ТехническоеП Тогда
		ОтборДляТаблицыИтогов.Вставить("КолПартий1","W");
		ОтборДляТаблицыИтогов.Вставить("КолПартий2","L");
	Иначе
		ОтборДляТаблицыИтогов.Вставить("КолПартий1",ИтоговыеДанныеПоТаблицеПартий.КолПартийВ);
		ОтборДляТаблицыИтогов.Вставить("КолПартий2",ИтоговыеДанныеПоТаблицеПартий.КолПартийП);
	КонецЕсли; 
	
	ИскомаяСтрока = ТаблицаВыбораПоИтогам.НайтиСтроки(ОтборДляТаблицыИтогов);
	
	Если ИскомаяСтрока.Количество() > 0 Тогда
		ИскомаяСтрока[0].ВыбраннаяСтрока = Истина;
	Иначе //попробуем наоборот
		ОтборДляТаблицыИтогов.Вставить("Участник1",ИтоговыеДанныеПоТаблицеПартий.Проигравший);
		ОтборДляТаблицыИтогов.Вставить("Участник2",ИтоговыеДанныеПоТаблицеПартий.Выигравший);
		Если ИтоговыеДанныеПоТаблицеПартий.ТехническоеП Тогда
			ОтборДляТаблицыИтогов.Вставить("КолПартий1","L");
			ОтборДляТаблицыИтогов.Вставить("КолПартий2","W");
		Иначе
			ОтборДляТаблицыИтогов.Вставить("КолПартий1",ИтоговыеДанныеПоТаблицеПартий.КолПартийП);
			ОтборДляТаблицыИтогов.Вставить("КолПартий2",ИтоговыеДанныеПоТаблицеПартий.КолПартийВ);
		КонецЕсли;
		ИскомаяСтрока = ТаблицаВыбораПоИтогам.НайтиСтроки(ОтборДляТаблицыИтогов);
		
		Если ИскомаяСтрока.Количество() > 0 Тогда
			ИскомаяСтрока[0].ВыбраннаяСтрока = Истина;
		КонецЕсли;
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ОчиститьВыбраннуюСтрокуВТаблице(ТаблицаВыбораПоИтогам)
	
	Для каждого ТекСтр Из ТаблицаВыбораПоИтогам Цикл
		ТекСтр.ВыбраннаяСтрока = Ложь;
	КонецЦикла; 
	
КонецПроцедуры

&НаСервере
Функция ОпределитьВыигравшегоИПроигравшегоПоТаблицеПартий()
	
	СтруктураВозврата = Новый Структура;
	СтруктураВозврата.Вставить("Выигравший",Справочники.Участники.ПустаяСсылка());
	СтруктураВозврата.Вставить("Проигравший",Справочники.Участники.ПустаяСсылка());
	СтруктураВозврата.Вставить("КолПартийИзСколькиИграли",0);
	СтруктураВозврата.Вставить("КолПартийВ",0);
	СтруктураВозврата.Вставить("КолПартийП",0);
	СтруктураВозврата.Вставить("ИндексСтрокиВ",0);
	СтруктураВозврата.Вставить("ИндексСтрокиП",0);
	СтруктураВозврата.Вставить("ТехническоеП",Ложь);
	
	Если ТаблицаПартий.Количество() = 2 Тогда
		ПерваяСтрока 	= ТаблицаПартий.Получить(0);
		ВтораяСтрока  	= ТаблицаПартий.Получить(1);
		
		ИтогВыигр1 = ПерваяСтрока.Итог;
		ИтогВыигр2 = ВтораяСтрока.Итог;
		
		Если ИтогВыигр1 > 0 Или ИтогВыигр2 > 0 Тогда
			Если ИтогВыигр1 > ИтогВыигр2 Тогда
				СтруктураВозврата.Выигравший 	= ПерваяСтрока.Участник;
				СтруктураВозврата.Проигравший	= ВтораяСтрока.Участник;
				СтруктураВозврата.КолПартийВ 	= ИтогВыигр1;
				СтруктураВозврата.КолПартийП 	= ИтогВыигр2;
				СтруктураВозврата.ИндексСтрокиВ = 0;
				СтруктураВозврата.ИндексСтрокиП = 1;
				СтруктураВозврата.ТехническоеП = ВтораяСтрока.ТехническоеП;
			Иначе
				СтруктураВозврата.Выигравший 	= ВтораяСтрока.Участник;
				СтруктураВозврата.Проигравший	= ПерваяСтрока.Участник;
				СтруктураВозврата.КолПартийВ 	= ИтогВыигр2;
				СтруктураВозврата.КолПартийП 	= ИтогВыигр1;
				СтруктураВозврата.ИндексСтрокиВ = 1;
				СтруктураВозврата.ИндексСтрокиП = 0;
				СтруктураВозврата.ТехническоеП = ПерваяСтрока.ТехническоеП;
			КонецЕсли;
		Иначе
			СтруктураВозврата.Выигравший 	= ПерваяСтрока.Участник;
			СтруктураВозврата.Проигравший	= ВтораяСтрока.Участник;
			СтруктураВозврата.КолПартийВ 	= ИтогВыигр1;
			СтруктураВозврата.КолПартийП 	= ИтогВыигр2;
			СтруктураВозврата.ИндексСтрокиВ = 0;
			СтруктураВозврата.ИндексСтрокиП = 1;
			СтруктураВозврата.ТехническоеП = ВтораяСтрока.ТехническоеП;
		КонецЕсли; 
		
		Если СтруктураВозврата.КолПартийВ = 2 Тогда
			СтруктураВозврата.КолПартийИзСколькиИграли = 3;
		ИначеЕсли СтруктураВозврата.КолПартийВ = 3 Тогда 
			СтруктураВозврата.КолПартийИзСколькиИграли = 5;
		ИначеЕсли СтруктураВозврата.КолПартийВ = 4 Тогда 
			СтруктураВозврата.КолПартийИзСколькиИграли = 7;
		Иначе
			СтруктураВозврата.КолПартийИзСколькиИграли = КолПартий;
		КонецЕсли; 
		
	КонецЕсли; 
	
	Возврат СтруктураВозврата;
	
КонецФункции

&НаКлиенте
Процедура ОбработкаДобавленияУдаления(Элемент,Отказ)
	Отказ = Истина;	
КонецПроцедуры

&НаКлиенте
Процедура ВариантыВыбораКоличестваПартийПриИзменении(Элемент)
	ВариантыВыбораКоличестваПартийПриИзмененииНаСервере();
	ИтогСтроки = Общий.ОпределитьКолПартий(ВариантыВыбораКоличестваПартий);
	Для каждого СтрокаПартии Из ТаблицаПартий Цикл
		Для П = ИтогСтроки + 1 По 7 Цикл
			СтрокаПартии["Игра"+П] = 0;
		КонецЦикла;
		СтрокаПартии.Итог = 0;
		СтрокаПартии.ТехническоеП = Ложь;
	КонецЦикла; 
	ПосчитатьИтогиПартийДляТаблицы();
КонецПроцедуры

&НаСервере
Процедура ВариантыВыбораКоличестваПартийПриИзмененииНаСервере()
	
	ТаблицаВыбораПоИтогам.Очистить();
	
	Если ТаблицаПартий.Количество() = 2 Тогда //всегда заполняется		
		ПервыйУчастник 	= ТаблицаПартий.Получить(0).Участник;
		ВторойУчастник		= ТаблицаПартий.Получить(1).Участник;
		
		ИтогСтроки = Общий.ОпределитьКолПартий(ВариантыВыбораКоличестваПартий);
		
		Для Н = 0 По ИтогСтроки-1 Цикл
			НовСтрока = ТаблицаВыбораПоИтогам.Добавить();
			НовСтрока.Участник1 		= ПервыйУчастник;
			НовСтрока.Участник2 		= ВторойУчастник;
			НовСтрока.КолПартий1	= ИтогСтроки;
			НовСтрока.КолПартий2	= Н;
		КонецЦикла; 
		
		//и наоборот
		Для Н = 0 По ИтогСтроки-1 Цикл
			НовСтрока = ТаблицаВыбораПоИтогам.Добавить();
			НовСтрока.Участник1 		= ПервыйУчастник;
			НовСтрока.Участник2 		= ВторойУчастник;
			НовСтрока.КолПартий1	= Н;
			НовСтрока.КолПартий2	= ИтогСтроки;
		КонецЦикла; 

		//W/L
		НовСтрока = ТаблицаВыбораПоИтогам.Добавить();
		НовСтрока.Участник1 		= ПервыйУчастник;
		НовСтрока.Участник2 		= ВторойУчастник;
		НовСтрока.КолПартий1	= "W";
		НовСтрока.КолПартий2	= "L";
		
		НовСтрока = ТаблицаВыбораПоИтогам.Добавить();
		НовСтрока.Участник1 		= ПервыйУчастник;
		НовСтрока.Участник2 		= ВторойУчастник;
		НовСтрока.КолПартий1	= "L";
		НовСтрока.КолПартий2	= "W";
		
		НовСтрока = ТаблицаВыбораПоИтогам.Добавить();
		НовСтрока.Участник1 		= ПервыйУчастник;
		НовСтрока.Участник2 		= ВторойУчастник;
		НовСтрока.КолПартий1	= "Удалить";
		НовСтрока.КолПартий2	= "Удалить";
		
	КонецЕсли; 	
	
	//устанавливаем видимость партиям
	Для Н = 3  По 7 Цикл
		Элементы["ТаблицаПартийИгра"+Н].Видимость = Ложь;
	КонецЦикла; 
	//устанавливаем видимость партиям
	Для Н = 1  По ВариантыВыбораКоличестваПартий Цикл
		Элементы["ТаблицаПартийИгра"+Н].Видимость = Истина;
	КонецЦикла; 
		
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаВыбораПоИтогамВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	СтрокаСДанными = ТаблицаВыбораПоИтогам.НайтиПоИдентификатору(ВыбраннаяСтрока);
	ОчиститьВыбраннуюСтрокуВТаблице(ТаблицаВыбораПоИтогам);
	СтрокаСДанными.ВыбраннаяСтрока = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаПартийПриИзменении(Элемент)
	
	ТекСтрока = Элемент.Родитель.ТекущиеДанные;	
	НомКолонки = СтрЗаменить(Элемент.Имя,"ТаблицаПартийИгра","");
	ИндексСтроки = ТаблицаПартий.Индекс(ТекСтрока);
	Если ИндексСтроки = 0 Тогда
		ИндексМеняемойСтроки = 1;
	Иначе
		ИндексМеняемойСтроки = 0;
	КонецЕсли;
	СтрокаДляУстановки = ТаблицаПартий.Получить(ИндексМеняемойСтроки);
	
	ТекЗначение = ТекСтрока["Игра"+НомКолонки];
	ЗначДляУстановки = СтрокаДляУстановки["Игра"+НомКолонки];
	Если ТекЗначение >=0 Тогда
		Если ТекЗначение >= 10 Тогда
			СтрокаДляУстановки["Игра"+НомКолонки] = ТекЗначение+2;
		ИначеЕсли ТекЗначение = 0 Или ТекЗначение = 1 Тогда
			СтрокаДляУстановки["Игра"+НомКолонки] = 11;
		ИначеЕсли ТекЗначение >= 2 Или ТекЗначение <= 9 Тогда
			//все хорошо
			СтрокаДляУстановки["Игра"+НомКолонки] = 11;
		Иначе
			ПоказатьПредупреждение(Новый ОписаниеОповещения("ТаблицаПартийПриИзмененииЗавершение", ЭтотОбъект, Новый Структура("НомГруппы, НомКолонки, СтрокаДляУстановки, ТекЗначение, ТекСтрока", НомерГруппы, НомКолонки, СтрокаДляУстановки, ТекЗначение, ТекСтрока)), "Проверьте правильность введенных очков !");
            Возврат;
		КонецЕсли;
	Иначе //ввели минусовое значение
		втТекЗнач = -ТекЗначение;//а дальше обработаем почти так же только в текущую строчку
		//устанавливаем 11 или больше, в другую это значение
		Если втТекЗнач >=0 Тогда
			Если втТекЗнач >= 10 Тогда
				ТекСтрока["Игра"+НомКолонки] = втТекЗнач+2;
				СтрокаДляУстановки["Игра"+НомКолонки] = втТекЗнач;
			ИначеЕсли втТекЗнач = 0 Или втТекЗнач = 1 Тогда
				ТекСтрока["Игра"+НомКолонки] = 11;
				СтрокаДляУстановки["Игра"+НомКолонки] = втТекЗнач;
			ИначеЕсли втТекЗнач >= 2 Или втТекЗнач <= 9 Тогда
				//все хорошо
				ТекСтрока["Игра"+НомКолонки] = 11;
				СтрокаДляУстановки["Игра"+НомКолонки] = втТекЗнач;
			Иначе
				ПоказатьПредупреждение(Новый ОписаниеОповещения("ТаблицаПартийПриИзмененииЗавершение", ЭтотОбъект, Новый Структура("НомГруппы, НомКолонки, СтрокаДляУстановки, ТекЗначение, ТекСтрока", НомерГруппы, НомКолонки, СтрокаДляУстановки, ТекЗначение, ТекСтрока)), "Проверьте правильность введенных очков !");
                Возврат;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	//секретное ))) если ввели 99, что маловероятно будет в реальной жизни, тогда скидываем значения на 0
	//для сброса значений 
	ТаблицаПартийПриИзмененииФрагмент(НомерГруппы, НомКолонки, СтрокаДляУстановки, ТекЗначение, ТекСтрока);
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаПартийПриИзмененииЗавершение(ДополнительныеПараметры) Экспорт
	
	НомГруппы = ДополнительныеПараметры.НомГруппы;
	НомКолонки = ДополнительныеПараметры.НомКолонки;
	СтрокаДляУстановки = ДополнительныеПараметры.СтрокаДляУстановки;
	ТекЗначение = ДополнительныеПараметры.ТекЗначение;
	ТекСтрока = ДополнительныеПараметры.ТекСтрока;
	
	//ТекСтрока["Игра"+НомКолонки] = глСтароеЗначениеКолонки;
	
	ТаблицаПартийПриИзмененииФрагмент(НомГруппы, НомКолонки, СтрокаДляУстановки, ТекЗначение, ТекСтрока);

КонецПроцедуры

&НаКлиенте
Процедура ТаблицаПартийПриИзмененииФрагмент(Знач НомГруппы, Знач НомКолонки, Знач СтрокаДляУстановки, Знач ТекЗначение, Знач ТекСтрока)
	
	Если ТекЗначение = 99 Тогда
		СтрокаДляУстановки["Игра"+НомКолонки] = 0;
		ТекСтрока["Игра"+НомКолонки] = 0;
	КонецЕсли;
	ПосчитатьИтогиПартийДляТаблицы();

КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция НайтиВыбраннуюСтроку(ТаблицаВариантов)
	
	ВыбраннаяСтрока = Неопределено;
	
	Для каждого ТекСтр Из ТаблицаВариантов Цикл
		Если ТекСтр.ВыбраннаяСтрока Тогда
			ВыбраннаяСтрока = ТекСтр.ПолучитьИдентификатор();
			Прервать;
		КонецЕсли; 	
	КонецЦикла; 
	
	Возврат ВыбраннаяСтрока;
	
КонецФункции

&НаКлиенте
Процедура Выбрать(Команда)
	
	ВыбраннаяСтрока = НайтиВыбраннуюСтроку(ТаблицаВыбораПоИтогам);
	Если ВыбраннаяСтрока = Неопределено Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Не выбрана строка со счетом по партиям";
		Сообщение.Сообщить(); 
	Иначе
		Если ПроверитьКорректноеЗаполнениеПоОчкам() Тогда
			ЭтотОбъект.Закрыть(ПодготовитьЗаполненныеДанные());
		КонецЕсли; 
	КонецЕсли; 
		
КонецПроцедуры

&НаСервере
Функция ПодготовитьЗаполненныеДанные()
	
	СтруктураВозврата = Новый Структура;
	ВыбраннаяСтрока = НайтиВыбраннуюСтроку(ТаблицаВыбораПоИтогам);
	
	Если ВыбраннаяСтрока <> Неопределено Тогда
		ВыбраннаяСтрока = ТаблицаВыбораПоИтогам.НайтиПоИдентификатору(ВыбраннаяСтрока);
		мПроигравшийСТехническим = Ложь;
		Если ТипЗнч(ВыбраннаяСтрока.КолПартий1) = Тип("Строка") И ТипЗнч(ВыбраннаяСтрока.КолПартий2) = Тип("Строка") Тогда //это техническое 
			Если ВыбраннаяСтрока.КолПартий1 = "W" И ВыбраннаяСтрока.КолПартий2 = "L" Тогда
				Выигравший 	= ВыбраннаяСтрока.Участник1;
				Проигравший 	= ВыбраннаяСтрока.Участник2;
				КолПартийВ		= Общий.ОпределитьКолПартий(ВариантыВыбораКоличестваПартий);
				КолПартийП		= 0;
			ИначеЕсли ВРег(ВыбраннаяСтрока.КолПартий1) = "УДАЛИТЬ" И ВРег(ВыбраннаяСтрока.КолПартий2) = "УДАЛИТЬ" Тогда
				Выигравший 	= ВыбраннаяСтрока.Участник1;
				Проигравший 	= ВыбраннаяСтрока.Участник2;
				КолПартийВ		= ВыбраннаяСтрока.КолПартий1;
				КолПартийП		= ВыбраннаяСтрока.КолПартий2;
			Иначе
				Выигравший 	= ВыбраннаяСтрока.Участник2;
				Проигравший 	= ВыбраннаяСтрока.Участник1;
				КолПартийВ		= Общий.ОпределитьКолПартий(ВариантыВыбораКоличестваПартий);
				КолПартийП		= 0;
			КонецЕсли;
			мПроигравшийСТехническим = Истина;
		Иначе
			Если ВыбраннаяСтрока.КолПартий1 >  ВыбраннаяСтрока.КолПартий2 Тогда
				Выигравший 	= ВыбраннаяСтрока.Участник1;
				Проигравший 	= ВыбраннаяСтрока.Участник2;
				КолПартийВ		= ВыбраннаяСтрока.КолПартий1;
				КолПартийП		= ВыбраннаяСтрока.КолПартий2;
			Иначе
				Выигравший 	= ВыбраннаяСтрока.Участник2;
				Проигравший 	= ВыбраннаяСтрока.Участник1;
				КолПартийВ		= ВыбраннаяСтрока.КолПартий2;
				КолПартийП		= ВыбраннаяСтрока.КолПартий1;
			КонецЕсли;
			мПроигравшийСТехническим = Ложь;
		КонецЕсли;
		
		СтруктураВозврата.Вставить("НомерТура",НомерТура);
		СтруктураВозврата.Вставить("НомерГруппы",НомерГруппы);
		СтруктураВозврата.Вставить("Выигравший",Выигравший);
		СтруктураВозврата.Вставить("Проигравший",Проигравший);
		СтруктураВозврата.Вставить("КолПартий",ВариантыВыбораКоличестваПартий);
		СтруктураВозврата.Вставить("КолПартийВ",КолПартийВ);
		СтруктураВозврата.Вставить("КолПартийП",КолПартийП);
		СтруктураВозврата.Вставить("ТехПоражение",мПроигравшийСТехническим);
		СтруктураВозврата.Вставить("ТаблицаОчков",Серверные.ТаблицаЗначенийВМассив(ТаблицаПартий.Выгрузить()));
		СтруктураВозврата.Вставить("ЕстьДанныеПоОчкам",Ложь);
		СтруктураВозврата.Вставить("Удалить", Ложь);
		
		Если СтрНайти(ВРег(Строка(КолПартийВ)),"УДАЛИТЬ") > 0 И СтрНайти(ВРег(Строка(КолПартийП)),"УДАЛИТЬ") Тогда
			СтруктураВозврата.Удалить = Истина;
			СтруктураВозврата.КолПартийВ = 0;
			СтруктураВозврата.КолПартийП = 0;
		КонецЕсли; 
		
		втСуммаОчков = 0;
		Для Н = 1 По 7 Цикл
			втСуммаОчков = втСуммаОчков + ТаблицаПартий.Итог("Игра"+Н);
		КонецЦикла; 
		
		Если втСуммаОчков <> 0 Тогда
			СтруктураВозврата.ЕстьДанныеПоОчкам = Истина;
		КонецЕсли;
		
	КонецЕсли; 
	
	Возврат СтруктураВозврата;
	
КонецФункции

&НаКлиенте
Функция ПроверитьКорректноеЗаполнениеПоОчкам()
	
	ЗаполнениеКорректное = Ложь;
	
	втСуммаОчков = 0;
	Для Н = 1 По 7 Цикл
		втСуммаОчков = втСуммаОчков + ТаблицаПартий.Итог("Игра"+Н);
	КонецЦикла; 
	втСуммаОчков = втСуммаОчков + ТаблицаПартий.Итог("Итог"); 
	
	Если втСуммаОчков <> 0 Тогда
		ИтогСтроки = Общий.ОпределитьКолПартий(ВариантыВыбораКоличестваПартий);
		Если ТаблицаПартий.Получить(0).Итог = ИтогСтроки
			Или ТаблицаПартий.Получить(1).Итог = ИтогСтроки Тогда
			ЗаполнениеКорректное = Истина;
		Иначе
			ЗаполнениеКорректное = Ложь;
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = "Ни один итог по очкам не соответствует выбранному количеству партий для победы: "+ ИтогСтроки;
			Сообщение.Сообщить(); 
		КонецЕсли; 
	ИначеЕсли втСуммаОчков = 0 Тогда //ничего не заполнялось
		ЗаполнениеКорректное = Истина;
	КонецЕсли; 
	
	Возврат ЗаполнениеКорректное;
	
КонецФункции

&НаКлиенте
Процедура ТаблицаПартийПередНачаломИзменения(Элемент, Отказ)
	
	ТекСтрока = Элемент.ТекущиеДанные;
	Если Элемент.ТекущийЭлемент.Имя <> "ТаблицаПартийИтог" Тогда
		глСтароеЗначениеКолонки = ТекСтрока[СтрЗаменить(Элемент.ТекущийЭлемент.Имя,"ТаблицаПартий","")];
		ТекЗначениеСтроки = ТекСтрока[СтрЗаменить(Элемент.ТекущийЭлемент.Имя,"ТаблицаПартий","")];
		
		//а теперь проверим итоги может уже все проставлено
		ИндексСтроки =ТаблицаПартий.Индекс(ТекСтрока);
		Если ИндексСтроки = 0 Тогда
			ИндексМеняемойСтроки = 1;
		Иначе
			ИндексМеняемойСтроки = 0;
		КонецЕсли;
		СтрокаДляУстановки = ТаблицаПартий.Получить(ИндексМеняемойСтроки);
		ПерваяСтрока = ТаблицаПартий.Получить(0);
		ВтораяСтрока = ТаблицаПартий.Получить(1);
		мЗначИтога1 = ТекСтрока.Итог;
		Если мЗначИтога1 = "" Тогда
			Итог1 = 0;
		Иначе
			Итог1 =  Число(мЗначИтога1);
		КонецЕсли;
		мЗначИтога2 = СтрокаДляУстановки.Итог;
		Если мЗначИтога2 = "" Тогда
			Итог2 = 0;
		Иначе
			Итог2 = Число(мЗначИтога2);
		КонецЕсли; 
		мОтказ = Ложь;
		Если ВариантыВыбораКоличестваПартий = 3 Тогда
			Если Итог1 = 2 Или Итог2 = 2 Тогда //уже есть итог
				мОтказ = Истина;
			КонецЕсли;
		ИначеЕсли ВариантыВыбораКоличестваПартий = 5 Тогда
			Если Итог1 = 3 Или Итог2 = 3 Тогда //все данные заполненны
				мОтказ = Истина;
			КонецЕсли;
		ИначеЕсли ВариантыВыбораКоличестваПартий = 7 Тогда
			Если Итог1 = 4 Или Итог2 = 4 Тогда //все данные заполненны
				мОтказ = Истина;
			КонецЕсли;
		КонецЕсли;
		Если мОтказ И ТекЗначениеСтроки = 0 Тогда
			Отказ = Истина;
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ТаблицаПартийПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	ТекСтрока = Элемент.ТекущиеДанные;	
	НомТекСтроки =ТаблицаПартий.Индекс(ТекСтрока);
	ИмяЭлемента = Элемент.ТекущийЭлемент.Имя;	
	НомЭлемента = СтрЗаменить(ИмяЭлемента,"ТаблицаПартийИгра","");
	СледКолонка = Число(НомЭлемента)+1;
	Если СледКолонка > ВариантыВыбораКоличестваПартий Тогда
		Возврат;//последня	КонецЕсли;
	КонецЕсли;
	Элемент.ТекущийЭлемент = Элементы["ТаблицаПартийИгра"+СледКолонка];
	
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьОчкиПоСетам(Команда)
	
	Для каждого СтрокаПартии Из ТаблицаПартий Цикл
		Для П = 1 По 7 Цикл
			СтрокаПартии["Игра"+П] = 0;
		КонецЦикла;
		СтрокаПартии.Итог = 0;
		СтрокаПартии.ТехническоеП = Ложь;
	КонецЦикла; 
	ПосчитатьИтогиПартийДляТаблицы();
	
КонецПроцедуры

