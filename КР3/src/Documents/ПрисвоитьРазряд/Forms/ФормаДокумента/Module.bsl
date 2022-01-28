
&НаКлиенте
Процедура КомандаПодбор(Команда)
	Данные = Новый Структура;
	Данные.Вставить("Соревнование",втДокОбъект);
	Данные.Вставить("Новый",Ложь);
	ОписаниеОповещения = Новый ОписаниеОповещения("ПослеПодбора",ЭтотОбъект);
	ОткрытьФорму("Документ.ПроведениеСоревнования.Форма.ПодборУчастников",Данные,ЭтотОбъект,Новый УникальныйИдентификатор,,,ОписаниеОповещения,СерверныеСервер.ПолучитьРежимОткрытияФормыПодбора());
КонецПроцедуры

&НаКлиенте
Процедура ПослеПодбора(Результат,ДопПараметры) Экспорт
	
	Если Результат <> Неопределено Тогда
		Для Каждого ТекСтрока Из Результат Цикл
			НовСтрока = Объект.Участники.Добавить();
			НовСтрока.Участник = ТекСтрока.Участник;
		КонецЦикла;
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаЗагрузитьСписок(Команда)
	ОткрытьФорму("Документ.ПрисвоитьРазряд.Форма.ЗагрузкаУчастников", , ЭтотОбъект, , , ,
		Новый ОписаниеОповещения("ПослеЗагрузкиСписка", ЭтотОбъект));
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗагрузкиСписка(Результат,ДопПараметры) Экспорт
	
	Если Результат <> Неопределено Тогда
		Для каждого ТекСтр Из Результат Цикл
			НовСтрока = Объект.Участники.Добавить();
			НовСтрока.Участник = ТекСтр.Участник;
			НовСтрока.РазрядЗвание = ТекСтр.Разряд;
		КонецЦикла; 
	КонецЕсли; 
	
КонецПроцедуры
 