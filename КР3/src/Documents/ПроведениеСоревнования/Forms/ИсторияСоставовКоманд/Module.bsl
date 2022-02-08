
&НаКлиенте
Процедура ДеревоКомандПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ДеревоКомандПередУдалением(Элемент, Отказ)
	Отказ = Истина;
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("СписокКоманд") Тогда
		фСписокКоманд = Параметры.СписокКоманд;
	КонецЕсли; 
	ЗаполнитьИсториюКоманд();
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьИсториюКоманд()
	
	ДеревоКоманд.ПолучитьЭлементы().Очистить();
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	ЛОЖЬ КАК Пометка,
	|	КомандыСоревнований.НазваниеКоманды КАК НазваниеКоманды,
	|	КомандыСоревнований.Участник КАК Участник
	|ИЗ
	|	РегистрСведений.КомандыСоревнований КАК КомандыСоревнований
	|ГДЕ
	|	НЕ КомандыСоревнований.НазваниеКоманды В (&СписокКоманд)
	|
	|СГРУППИРОВАТЬ ПО
	|	КомандыСоревнований.НазваниеКоманды,
	|	КомандыСоревнований.Участник
	|
	|УПОРЯДОЧИТЬ ПО
	|	НазваниеКоманды
	|ИТОГИ
	|	НазваниеКоманды КАК Участник
	|ПО
	|	НазваниеКоманды";
	Запрос.УстановитьПараметр("СписокКоманд",фСписокКоманд);
	Результат = Запрос.Выполнить().Выгрузить(ОбходРезультатаЗапроса.ПоГруппировкам);
	ЗначениеВРеквизитФормы(Результат,"ДеревоКоманд");
	 
КонецПроцедуры

&НаКлиенте
Процедура ДеревоКомандПометкаПриИзменении(Элемент)
	
	ТекСтр = Элементы.ДеревоКоманд.ТекущиеДанные;
	Если ТекСтр = Неопределено Тогда
		Возврат;
	КонецЕсли; 
	мРодительСтроки = ТекСтр.ПолучитьРодителя();
	Если мРодительСтроки = Неопределено Тогда
		//это корневая строка
		СтрокиРодителя = ТекСтр.ПолучитьЭлементы(); 
		Для Каждого Дочерняя Из СтрокиРодителя Цикл
			Дочерняя.Пометка = ТекСтр.Пометка;
		КонецЦикла; 
	Иначе
		//установим пометку еще и в родительскую
		Если ТекСтр.Пометка Тогда
			мРодительСтроки.Пометка = Истина;
		КонецЕсли; 
		СтрокиРодителя = мРодительСтроки.ПолучитьЭлементы();
		//посчтиаем количество помеченных
		Сч = 0;
		Для Каждого СтрРод Из СтрокиРодителя Цикл
			Если СтрРод.Пометка Тогда
				Сч = Сч + 1;
			КонецЕсли; 
		КонецЦикла; 
		мРодительСтроки.Пометка = ?(Сч = 0,Ложь,Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаВыбратьКоманды(Команда)
	ОповеститьОВыборе(ДеревоКоманд);
КонецПроцедуры
