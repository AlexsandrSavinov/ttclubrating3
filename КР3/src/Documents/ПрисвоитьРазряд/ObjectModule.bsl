
Процедура ОбработкаПроведения(Отказ, Режим)
	// регистр РазрядыУчастников
	Движения.РазрядыУчастников.Записывать = Истина;
	Для Каждого ТекСтрокаУчастники Из Участники Цикл
		Движение = Движения.РазрядыУчастников.Добавить();
		Движение.Период = Дата;
		Движение.Участник = ТекСтрокаУчастники.Участник;
		Движение.ДатаПрисвоения = Дата;
		Движение.Разряд = ТекСтрокаУчастники.РазрядЗвание;
	КонецЦикла;

КонецПроцедуры
