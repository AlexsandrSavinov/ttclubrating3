
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	ПараметрыФормы = Новый Структура("Отбор",ПолучитьОтборСоревнования(ПараметрКоманды));
	ПараметрыФормы.Вставить("СформироватьПриОткрытии",Истина);
	ПараметрыФормы.Вставить("НастройкиПоОтбору",Истина);
	ОткрытьФорму("Отчет.ТекущийРейтингУчастников.Форма", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно, ПараметрыВыполненияКоманды.НавигационнаяСсылка);
КонецПроцедуры

&НаСервере
Функция ПолучитьОтборСоревнования(ДокСсылка)
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	ПроведениеСоревнованияСписокУчастников.Участник
	|ПОМЕСТИТЬ ВсеУчастники
	|ИЗ
	|	Документ.ПроведениеСоревнования.СписокУчастников КАК ПроведениеСоревнованияСписокУчастников
	|ГДЕ
	|	ПроведениеСоревнованияСписокУчастников.Ссылка = &Ссылка
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ПроведениеСоревнованияТаблицаКоманд.Участник
	|ИЗ
	|	Документ.ПроведениеСоревнования.ТаблицаКоманд КАК ПроведениеСоревнованияТаблицаКоманд
	|ГДЕ
	|	ПроведениеСоревнованияТаблицаКоманд.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ВсеУчастники.Участник КАК Участник
	|ИЗ
	|	ВсеУчастники КАК ВсеУчастники
	|
	|УПОРЯДОЧИТЬ ПО
	|	Участник";
	Запрос.УстановитьПараметр("Ссылка",ДокСсылка);
	Результат = Запрос.Выполнить().Выгрузить();
	
	Отбор = Новый Структура;
	Отбор.Вставить("Участник",Результат.ВыгрузитьКолонку("Участник"));
	//Отбор.Вставить("Период",ДокСсылка.Дата);
	
	Возврат Отбор;
	
КонецФункции
 
