
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Участник",ПараметрКоманды);
	ПараметрыФормы.Вставить("СформироватьПриОткрытии",Истина);
	ОткрытьФорму("Отчет.ОтчетКарточкаУчастника.Форма.ФормаОтчета", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно);
КонецПроцедуры
