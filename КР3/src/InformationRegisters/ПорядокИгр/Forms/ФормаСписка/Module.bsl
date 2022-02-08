
&НаКлиенте
Процедура КомандаЗаполнитьПоУмолчанию(Команда)
	ОповещениеВопроса = Новый ОписаниеОповещения("ПослеЗакрытияВопроса",ЭтотОбъект);
	ПоказатьВопрос(ОповещениеВопроса,"Все записи будут удалены.Продолжить",РежимДиалогаВопрос.ДаНет,30);
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗакрытияВопроса(Результат,ДопПараметры) Экспорт
	
	Если Результат <> Неопределено Тогда
		Если Результат = КодВозвратаДиалога.Да Тогда
			ЗаполнитьПорядокИгр();
		КонецЕсли; 
	КонецЕсли; 
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ЗаполнитьПорядокИгр()
	
	Набор = РегистрыСведений.ПорядокИгр.ЗагрузитьПорядокИгрВМодуле();
	Набор.Записать();
	
КонецПроцедуры
