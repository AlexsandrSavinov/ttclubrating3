
Процедура ДействияПриНачалеРаботыСистемыКлиент() Экспорт
	
	СерверныеСервер.ВыполнитьПроцедурыИФункцииПриНачалеРаботыСистемы();
	
КонецПроцедуры

Процедура ОбработатьВызовЗаСтолТекущиеИгры(Данные,УдалениеИгры = Ложь) Экспорт
	
	Если УдалениеИгры Тогда
		СерверныеСервер.УдалитьВстречуВСписке(Данные);
	Иначе
		СерверныеСервер.ПоказатьВстречуВСписке(Данные);
	КонецЕсли; 
	Оповестить("ОбновлениеСпискаВстреч");
	
КонецПроцедуры

Процедура ПослеВыбораПередЗавершения(Результат,ДопПараметры) Экспорт
	
	Если Результат <> Неопределено Тогда
		Если Результат Тогда
			ЗавершитьРаботуСистемы(Ложь);
		КонецЕсли; 
	КонецЕсли; 
	
КонецПроцедуры

Процедура СохранитьФайл(Формат,ИсточникВызова) Экспорт
	
	Если ИсточникВызова.ИмяФормы = "ОбщаяФорма.ФормаВыводаНаПечать" Тогда
		ТабДок 				= ИсточникВызова.ТабДок;
		ИмяДляСохранения 	= СерверныеСервер.ПолучитьЗаголовокПоСоревнованию(ИсточникВызова.СсылкаНаДокумент);
	ИначеЕсли ИсточникВызова.ИмяФормы = "Документ.ПроведениеСоревнования.Форма.ФормаПроведенияСоревнования" Тогда
		ТабДок 				= ИсточникВызова.ТабличныйДокументГрупп;
		ИмяДляСохранения 	= СокрЛП(ИсточникВызова.Окно.Заголовок);
	Иначе
		ТабДок 				= ИсточникВызова.ОтчетТабличныйДокумент;
		ИмяДляСохранения 	= ИсточникВызова.Окно.Заголовок;
	КонецЕсли; 	
	
	ИмяДляСохранения = ОбщегоНазначенияКлиентСервер.ЗаменитьНедопустимыеСимволыВИмениФайла(ИмяДляСохранения);
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
	Диалог.Заголовок = "Сохранить как...";
	Диалог.ПолноеИмяФайла = ИмяДляСохранения;
	Если Формат = "PDF" Тогда
		Диалог.Фильтр = "Документ PDF (*.pdf) | *.pdf";
		Диалог.Расширение = "pdf";
		ТипФайла = ТипФайлаТабличногоДокумента.PDF;
	ИначеЕсли Формат = "EXCEL" Тогда 
		Диалог.Фильтр = "Лист Excel 2007 (*.xlsx) | *.xlsx";
		Диалог.Расширение = "xlsx";
		ТипФайла = ТипФайлаТабличногоДокумента.XLSX;
	ИначеЕсли Формат = "PNG" Тогда 
		Диалог.Фильтр = "Картинка (*.png) | *.png";
		Диалог.Расширение = "png";
		ТипФайла = "PNG";
	КонецЕсли;
	Если Формат = "PNG" Тогда
		ПараметрыДляСохранения = СерверныеСервер.ДанныеКПрограммеДляСохраненияВPNG();
		Если ЗначениеЗаполнено(ПараметрыДляСохранения.ПутьКПрограмме) Тогда
			Диалог.Показать(Новый ОписаниеОповещения("СохранитьФайлЗавершение", ЭтотОбъект,
				Новый Структура("Диалог, ТипФайла, ТабДок", Диалог, ТипФайла, ТабДок)));
		Иначе
			ПоказатьПредупреждение(Новый ОписаниеОповещения("ПослеПоказаПредупреждения", ЭтотОбъект),
				"Нужно заполнить путь к программе wkhtmltoimage");
		КонецЕсли;
	Иначе
		Диалог.Показать(Новый ОписаниеОповещения("СохранитьФайлЗавершение", ЭтотОбъект,
			Новый Структура("Диалог, ТипФайла, ТабДок", Диалог, ТипФайла, ТабДок)));
	КонецЕсли; 

КонецПроцедуры

Процедура СохранитьФайлЗавершение(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	
	Диалог 		= ДополнительныеПараметры.Диалог;
	ТипФайла 	= ДополнительныеПараметры.ТипФайла;
	ТабДок		= ДополнительныеПараметры.ТабДок;
	
	ПроверкаРасширения = Новый Файл(Диалог.ПолноеИмяФайла);
	
	Если ВРег(ПроверкаРасширения.Расширение) <> ВРег("."+Диалог.Расширение) Тогда
		ИмяФайлаСохранения = Диалог.ПолноеИмяФайла + "." + Диалог.Расширение;
	Иначе
		ИмяФайлаСохранения = Диалог.ПолноеИмяФайла;
	КонецЕсли; 
	
	Если (ВыбранныеФайлы <> Неопределено) Тогда
		Если ТипФайла = "PNG" Тогда
			СохранитьВКартинку(ИмяФайлаСохранения,ТабДок);	
		Иначе
			ТабДок.АвтоМасштаб = Истина;
			ТабДок.НачатьЗапись(Новый ОписаниеОповещения("ПослеЗаписиФайлаЗавершение",КлиентскиеКлиент,ИмяФайлаСохранения),ИмяФайлаСохранения,ТипФайла);
		КонецЕсли; 
	КонецЕсли;
	
КонецПроцедуры

Процедура ПослеЗаписиФайлаЗавершение(Результат,ДопПараметры) Экспорт
	
	Если Результат Тогда
		ПоказатьОповещениеПользователя("Файл сохранен",Новый ОписаниеОповещения("НажатиеНаОповещение",КлиентскиеКлиент,ДопПараметры),"Файл был сохранен в "+ДопПараметры,БиблиотекаКартинок.Информация);
	КонецЕсли; 
	
КонецПроцедуры

Процедура НажатиеНаОповещение(ДопПараметры) Экспорт
	
	НачатьЗапускПриложения(Новый ОписаниеОповещения("ПослеЗапускаПриложения",КлиентскиеКлиент),ДопПараметры);
	
КонецПроцедуры

Процедура СохранитьВКартинку(ИмяВыходногоФайла,ТабДок)
	
	ПараметрыДляСохранения = СерверныеСервер.ДанныеКПрограммеДляСохраненияВPNG();
	#Если Не ВебКлиент Тогда
		втФайл = ПолучитьИмяВременногоФайла("html");
	#Иначе
		втФайл = "";     	
	#КонецЕсли
	ТабДок.АвтоМасштаб = Истина;  
	ТабДок.Записать(втФайл,ТипФайлаТабличногоДокумента.HTML5);
	
	Кавычка = Символ(34);
	Если ОбщийКлиентСервер.ЭтоWindows() Тогда
		//ИмяВыходногоФайла = "C:\output.png";
		СтрокаКонвертирования = Кавычка+ПараметрыДляСохранения.ПутьКПрограмме + Кавычка + " --quality " + ПараметрыДляСохранения.КачествоКартинки + " "+втФайл+" "+Кавычка+ИмяВыходногоФайла+Кавычка;
	ИначеЕсли ОбщийКлиентСервер.ЭтоLinux() Тогда 
		СтрокаКонвертирования = ПараметрыДляСохранения.ПутьКПрограмме + " --quality "+ ПараметрыДляСохранения.КачествоКартинки +" " + втФайл+" "+Кавычка+ИмяВыходногоФайла+Кавычка;
	КонецЕсли; 
	
	Попытка
		НачатьЗапускПриложения(Новый ОписаниеОповещения("ПослеЗапускаПриложения",ЭтотОбъект),СтрокаКонвертирования,,Истина);
		НачатьУдалениеФайлов(Новый ОписаниеОповещения("ПослеУдаленияФайла",ЭтотОбъект),втФайл);
	Исключение
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = ОписаниеОшибки();
		Сообщение.Сообщить(); 
	КонецПопытки; 

КонецПроцедуры

Процедура ПослеУдаленияФайла(ДополнительныеПараметры) Экспорт
	
КонецПроцедуры
 
Процедура ПослеЗапускаПриложения(КодВозврата,ДопПараметры) Экспорт
	
КонецПроцедуры

Процедура ПослеПоказаПредупреждения(ДополнительныеПараметры) Экспорт
	ОткрытьФорму("ОбщаяФорма.НастройкиПрограммы",,ЭтотОбъект);
КонецПроцедуры

Функция СтруктураURI(Знач СтрокаURI) Экспорт
    СтрокаURI = СокрЛП(СтрокаURI);
    
    Схема = "";
    Позиция = Найти(СтрокаURI, "://");
    Если Позиция > 0 Тогда
        Схема = НРег(Лев(СтрокаURI, Позиция - 1));
        СтрокаURI = Сред(СтрокаURI, Позиция + 3);
    КонецЕсли;
 
    СтрокаСоединения = СтрокаURI;
    ПутьНаСервере = "";
    Позиция = Найти(СтрокаСоединения, "/");
    Если Позиция > 0 Тогда
        ПутьНаСервере = Сред(СтрокаСоединения, Позиция + 1);
        СтрокаСоединения = Лев(СтрокаСоединения, Позиция - 1);
    КонецЕсли;
        
    СтрокаАвторизации = "";
    ИмяСервера = СтрокаСоединения;
    Позиция = Найти(СтрокаСоединения, "@");
    Если Позиция > 0 Тогда
        СтрокаАвторизации = Лев(СтрокаСоединения, Позиция - 1);
        ИмяСервера = Сред(СтрокаСоединения, Позиция + 1);
    КонецЕсли;
    
    Логин = СтрокаАвторизации;
    Пароль = "";
    Позиция = Найти(СтрокаАвторизации, ":");
    Если Позиция > 0 Тогда
        Логин = Лев(СтрокаАвторизации, Позиция - 1);
        Пароль = Сред(СтрокаАвторизации, Позиция + 1);
    КонецЕсли;
    
    Хост = ИмяСервера;
    Порт = "";
    Позиция = Найти(ИмяСервера, ":");
    Если Позиция > 0 Тогда
        Хост = Лев(ИмяСервера, Позиция - 1);
        Порт = Сред(ИмяСервера, Позиция + 1);
    КонецЕсли;
    
    Результат = Новый Структура;
    Результат.Вставить("Схема", Схема);
    Результат.Вставить("Логин", Логин);
    Результат.Вставить("Пароль", Пароль);
    Результат.Вставить("ИмяСервера", ИмяСервера);
    Результат.Вставить("Хост", Хост);
    Результат.Вставить("Порт", ?(Порт <> "", Число(Порт), Неопределено));
    Результат.Вставить("ПутьНаСервере", ПутьНаСервере);
    
    Возврат Результат;
КонецФункции
