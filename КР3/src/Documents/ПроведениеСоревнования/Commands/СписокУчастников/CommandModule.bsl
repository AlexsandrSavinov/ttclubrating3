
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	Отбор = Новый Структура("Соревнование",ПараметрКоманды);
	ПараметрыФормы = Новый Структура("Отбор",Отбор);
	ПараметрыФормы.Вставить("СформироватьПриОткрытии",Истина);
	ПараметрыФормы.Вставить("НастройкиПоОтбору",Истина);
	ОткрытьФорму("Отчет.СписокУчастниковСоревнований.Форма", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно);
КонецПроцедуры
