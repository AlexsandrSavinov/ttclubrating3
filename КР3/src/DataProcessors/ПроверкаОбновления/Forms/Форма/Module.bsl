
&НаКлиенте
Процедура Проверить(Команда)
	ПроверитьНаСервере();
КонецПроцедуры

&НаСервере
Процедура ПроверитьНаСервере()
	
	мОбъект = РеквизитФормыВЗначение("Объект"); 
	Данные = мОбъект.ПроверкаОбновленияПрограммы();
	Если Данные.ОбновлениеПрошло Тогда
		ПоследняяВерсия = Данные.Описание;
		втТекВерсия = Число(СтрЗаменить(ТекущаяВерсия,".",""));
		втПоследняяВерсия = Число(СтрЗаменить(ПоследняяВерсия,".",""));
		//Если ТекущаяВерсия <> ПоследняяВерсия Тогда
		Если втПоследняяВерсия > втТекВерсия Тогда
			Инф = "Появилось обновление программы!";
			//Элементы.НастройкиОбновления.Видимость = Истина;
			//Элементы.КомандаСохранитьОбновление.Видимость = Истина;
			Элементы.ПолеПомощьПриОбновлении.Видимость = Истина;
			//Пользователь = Строка(ПараметрыСеанса.ТекущийПользователь);
		Иначе
			Инф = "У Вас установлена последняя версия программы!";
		КонецЕсли;
	Иначе
		Инф = "Не удалось проверить обновление программы."+Символы.ПС+Данные.Описание;
	КонецЕсли;
		
КонецПроцедуры
 
 &НаКлиенте
Процедура ПриОткрытии(Отказ)
	#Если ВебКлиент Тогда
		Отказ = Истина;
		ПоказатьПредупреждение(,"Обновление не доступно в Web интерфейсе",15);
	#КонецЕсли
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ТекущаяВерсия = Метаданные.Версия;
	Элементы.НастройкиОбновления.Видимость = Ложь;
	Элементы.КомандаСохранитьОбновление.Видимость = Ложь;
	Если Параметры.Свойство("ОперацияРезервногоКопирования") Тогда
		ОперацияРезервногоКопирования = Параметры.ОперацияРезервногоКопирования;
	КонецЕсли; 
	мОБъект = РеквизитФормыВЗначение("Объект");
	Если ОперацияРезервногоКопирования = 1 Тогда
		Элементы.СервисныеСтраницы.ТекущаяСтраница = Элементы.ГруппаОбновление;	
		ПолеПомощьПриОбновлении = мОБъект.ПолучитьМакет("МакетОбновления").ПолучитьТекст();
		Если Параметры.ПроверятьСразу Тогда
			ПроверитьНаСервере();
			Если ТекущаяВерсия = ПоследняяВерсия Тогда
				Отказ = Истина;
			КонецЕсли;
		КонецЕсли;
		ЭтотОбъект.Заголовок = "Обновление программы";
	ИначеЕсли ОперацияРезервногоКопирования = 2 Тогда
		Элементы.СервисныеСтраницы.ТекущаяСтраница = Элементы.ГруппаРезервнойКопии;	
		ПолеПомощьПриВыгрузки = мОБъект.ПолучитьМакет("МакетСохранения").ПолучитьТекст();
		ЭтотОбъект.Заголовок = "Резервная копия программы";
	ИначеЕсли ОперацияРезервногоКопирования = 3 Тогда
		Элементы.СервисныеСтраницы.ТекущаяСтраница = Элементы.ГруппаВосстановление;	
		ПолеПомощьПриВосстановлении = мОБъект.ПолучитьМакет("МакетВосстановления").ПолучитьТекст();
		ЭтотОбъект.Заголовок = "Восстановить из копии";
	КонецЕсли; 
	Пользователь = ИмяПользователя();
	мПуть = СтрокаСоединенияИнформационнойБазы();
	ПутьКБазе = СтрЗаменить(Сред(мПуть, 6, СтрДлина(мПуть) - 6),Символ(34),"");
	ПутьКПрограмме = КаталогПрограммы()+"1cv8c.exe";
	
КонецПроцедуры
