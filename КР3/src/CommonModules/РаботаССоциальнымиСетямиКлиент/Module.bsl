
#Область Общие_Процедуры

Процедура ОткрытьФормуОтправкиВСоцСеть(ИсточникВызова, ТипСоцСети) Экспорт
		
	ПараметрыОтправки = Новый Структура;
	ПараметрыОтправки.Вставить("СоцСеть", ТипСоцСети);
	ПараметрыОтправки.Вставить("ИсточникВызова", ОпределитьПараметрыИсточникаВызова(ИсточникВызова));

	ОповещениеПослеЗакрытия = Новый ОписаниеОповещения("ПослеЗакрытияФормыОтправки", РаботаССоциальнымиСетямиКлиент,
		ПараметрыОтправки);

	ОткрытьФорму("ОбщаяФорма.ОтправкаДанныхВСоциальныеСети", ПараметрыОтправки, , , , , ОповещениеПослеЗакрытия);
	
КонецПроцедуры

Процедура ПослеЗакрытияФормыОтправки(Результат, ДопПараметры) Экспорт
	
	Если Результат <> Неопределено Тогда
		
		Результат.Вставить("втИмяФайла", КаталогВременныхФайлов()+Результат.Заголовок+"."+Результат.Формат);
		Результат.Вставить("ЗаголовокОтчета", ДопПараметры.ИсточникВызова.ЗаголовокОтчета);
		Результат.ТабДокДляОтправки.НачатьЗапись(Новый ОписаниеОповещения("ПослеЗаписиФайла",РаботаССоциальнымиСетямиКлиент,Результат),Результат.втИмяФайла,ТипФайлаТабличногоДокумента[Результат.Формат]);
		
	КонецЕсли; 
	
КонецПроцедуры

Процедура ПослеЗаписиФайла(Результат,ДопПараметры) Экспорт
		
	Если Результат Тогда
		Если ДопПараметры.Формат = "HTML" Тогда //надо переконвертировать в png
			ПараметрыДляСохранения = СерверныеСервер.ДанныеКПрограммеДляСохраненияВPNG();
			Если Не ЗначениеЗаполнено(ПараметрыДляСохранения.ПутьКПрограмме) Тогда
				ПоказатьПредупреждение( ,"Нужно заполнить путь к программе wkhtmltoimage");
			Иначе
				втФайлPNG = ПолучитьИмяВременногоФайла("png");
				Кавычка = Символ(34);
				Если ОбщийКлиентСервер.ЭтоWindows() Тогда
					СтрокаКонвертирования = Кавычка+ПараметрыДляСохранения.ПутьКПрограмме + Кавычка + " "+ДопПараметры.втИмяФайла+" "+Кавычка+втФайлPNG+Кавычка;
				ИначеЕсли ОбщийКлиентСервер.ЭтоLinux() Тогда 
					СтрокаКонвертирования = ПараметрыДляСохранения.ПутьКПрограмме + " "+Кавычка+ДопПараметры.втИмяФайла+Кавычка+" "+втФайлPNG;
				КонецЕсли; 
				ДопПараметры.Вставить("СтрокаКонвертирования", СтрокаКонвертирования);
				ДопПараметры.Вставить("ФайлКартинки", втФайлPNG);
				КонвертироватьHTMLвPNG(ДопПараметры);
			КонецЕсли; 
		Иначе
			ОтправитьДокументыВСоцСеть(ДопПараметры);
		КонецЕсли; 
		
	КонецЕсли; 

КонецПроцедуры

Процедура КонвертироватьHTMLвPNG(ПараметрыДляОтправки)
	
	НачатьЗапускПриложения(Новый ОписаниеОповещения("ПослеЗапускаПриложенияКонвертирования",РаботаССоциальнымиСетямиКлиент,ПараметрыДляОтправки),ПараметрыДляОтправки.СтрокаКонвертирования,,Истина);
	
КонецПроцедуры

Процедура ПослеЗапускаПриложенияКонвертирования(КодВозврата,ДопПараметры) Экспорт
	
	ОтправитьДокументыВСоцСеть(ДопПараметры);
	
КонецПроцедуры

Процедура ОтправитьДокументыВСоцСеть(ИсходныеДанные) Экспорт
	
	Если ИсходныеДанные.СоцСеть = ПредопределенноеЗначение("Перечисление.СоцСеть.Вконтакте") Тогда
		ОтправитьДокументыВоВконтакте(ИсходныеДанные);	
	ИначеЕсли ИсходныеДанные.СоцСеть = ПредопределенноеЗначение("Перечисление.СоцСеть.Телеграмм") Тогда 
		//ОтправитьФайлТелеграммБоту(ИсходныеДанные);		
		ОтправитьФайлТелеграммБотуЧерез_SDK(ИсходныеДанные);		
	КонецЕсли; 
	
КонецПроцедуры

#КонецОбласти 
 
#Область ВКОНТАКТЕ

////////////////////////////////////////////////////////////////////////////////
//
// Процедура 
//
// Описание:
//
// Параметры:
// ИсточникВызова - УправляемаяФорма - откуда вызвана команда
// ПутьКФайлу - Строка - конечный путь к отправляемому файлу
// парФормат - Строка - форма файла для загрузки xlsx,pdf,png.
Процедура ОтправитьДокументыВоВконтакте(ДанныеДляОтправки) Экспорт
	
	//https://api.vk.com/method/METHOD_NAME?PARAMETERS&access_token=ACCESS_TOKEN&v=V
	//Он состоит из нескольких частей:
	//
	//METHOD_NAME (обязательно) — название метода API, к которому Вы хотите обратиться. Полный список методов доступен на этой странице. Обратите внимание: имя метода чувствительно к регистру.
	//PARAMETERS (опционально) — входные параметры соответствующего метода API, последовательность пар name=value, разделенных амперсандом. Список параметров указан на странице с описанием метода.
	//ACCESS_TOKEN (обязательно) — ключ доступа. Подробнее о получении токена Вы можете узнать в этом руководстве.
	//V (обязательно) — используемая версия API. Использование этого параметра применяет некоторые изменения в формате ответа различных методов. На текущий момент актуальная версия API — 5.92. Этот параметр следует передавать со всеми запросами.
		
	ВерсияАпи = "5.92";
	
	Токен = ДанныеДляОтправки.ТокенВК;
	Если ЗначениеЗаполнено(ДанныеДляОтправки.ЗаголовокОтчета) Тогда
		ЗаголовокДокумента = ДанныеДляОтправки.ЗаголовокОтчета;	
	Иначе
		ЗаголовокДокумента = ДанныеДляОтправки.Заголовок;
	КонецЕсли; 
	
	ПутьКФайлу = ДанныеДляОтправки.втИмяФайла;
	парФормат	= ДанныеДляОтправки.Формат;
	
	Если ДанныеДляОтправки.ИДДляОтправки.Количество() = 0 Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Нет активных записей для размещения документов.";
		Сообщение.Сообщить(); 
		//можно удалить файл
		НачатьУдалениеФайлов(Новый ОписаниеОповещения("ПослеУдаленияФайлов",РаботаССоциальнымиСетямиКлиент),ПутьКФайлу);
		Возврат;
	КонецЕсли; 
	
	СоединениеОсновное = Новый HTTPСоединение("api.vk.com",,,,,,Новый ЗащищенноеСоединениеOpenSSL);
	Если парФормат = "HTML" Тогда
		парФормат = "PNG";
		ПутьКФайлу = ДанныеДляОтправки.ФайлКартинки;
	КонецЕсли;
	
	Для Каждого ТекЗапись Из ДанныеДляОтправки.ИДДляОтправки Цикл
		
		ФорматированныйИД = Формат(ТекЗапись.ИД,"ЧГ=0");
		ЭтоПубликацияГруппы = Ложь;
		Если ТекЗапись.ТипПубликации = ПредопределенноеЗначение("Перечисление.ТипПубликации.Группа") Тогда
			ЭтоПубликацияГруппы = Истина;
		КонецЕсли; 
		
		//docs.getUploadServer
		//1 получение адреса для загрузки файла       //group_id
		Если ЭтоПубликацияГруппы Тогда
			СтрокаЗапросаДок = Новый HTTPЗапрос("/method/docs.getWallUploadServer?group_id="+ФорматированныйИД+"&access_token="+Токен+"&v="+ВерсияАпи+"");
		Иначе
			СтрокаЗапросаДок = Новый HTTPЗапрос("/method/docs.getWallUploadServer?access_token="+Токен+"&v="+ВерсияАпи+"");
		КонецЕсли; 
		
		Ответ = СоединениеОсновное.Получить(СтрокаЗапросаДок);
		
		СтруктураДанных = ОбщийКлиентСервер.СформироватьОтветHTTPВСтруктуру(Ответ);	//считывание в структуру			
		
		Если Ответ.КодСостояния = 200 Тогда
			Если СтруктураДанных.Свойство("response") Тогда
				АдресДляЗагрузкиФайла = СтруктураДанных.response.upload_url;		
				
				//2 загружаем документ на сервер вк
				СтруктураАдреса = КлиентскиеКлиент.СтруктураURI(АдресДляЗагрузкиФайла);
				Boundary  = СтрЗаменить(Строка(Новый УникальныйИдентификатор()), "-", "");
				
				Тело         = Новый ПотокВПамяти();
				ЗаписьДанных = Новый ЗаписьДанных(Тело,КодировкаТекста.ANSI);
				ЗаписьДанных.ЗаписатьСтроку("--"+Boundary);
				ЗаписьДанных.ЗаписатьСтроку("Content-Disposition: form-data; name=""file""; filename=""doc."+парФормат+"""");
				ЗаписьДанных.ЗаписатьСтроку("");
				ЗаписьДанных.Записать(Новый ДвоичныеДанные(ПутьКФайлу));
				ЗаписьДанных.ЗаписатьСтроку("");
				ЗаписьДанных.ЗаписатьСтроку("--"+Boundary);
				
				ДвоичныеДанныеДляОтправки = Тело.ЗакрытьИПолучитьДвоичныеДанные();
				
				ЗаголовокHTTP = Новый Соответствие;
				ЗаголовокHTTP.Вставить("Content-Type", "multipart/form-data; boundary="+Boundary);
				ЗаголовокHTTP.Вставить("Content-Length", XMLСтрока(ДвоичныеДанныеДляОтправки.Размер()));
				
				НТТР = Новый HTTPСоединение(СтруктураАдреса.ИмяСервера+"/"+СтруктураАдреса.ПутьНаСервере,,,,,,Новый ЗащищенноеСоединениеOpenSSL);
				
				ЗапросHTTP      = Новый HTTPЗапрос("",ЗаголовокHTTP);
				ЗапросHTTP.УстановитьТелоИзДвоичныхДанных(ДвоичныеДанныеДляОтправки);
				
				ОтветHTTP       = НТТР.ОтправитьДляОбработки(ЗапросHTTP);
				ПараметрыОтвета = ОбщийКлиентСервер.СформироватьОтветHTTPВСтруктуру(ОтветHTTP);
				
				Если ПараметрыОтвета.Свойство("file") Тогда
					//3 сохраняем документ на стене
					ЗапросНаСохранение = Новый HTTPЗапрос("/method/docs.save?file="+ПараметрыОтвета.file+"&title="+ЗаголовокДокумента+"&access_token="+Токен+"&v="+ВерсияАпи+"");
					ОтветНаЗапрос = СоединениеОсновное.Получить(ЗапросНаСохранение);
					
					РезультатПубликации = ОбщийКлиентСервер.СформироватьОтветHTTPВСтруктуру(ОтветНаЗапрос);
					
					Если РезультатПубликации.Свойство("response") Тогда
						//<type><owner_id>_<media_id>,<type><owner_id>_<media_id>
						Аттач = РезультатПубликации.response.type+Формат(РезультатПубликации.response.doc.owner_id,"ЧГ=0")+"_"+Формат(РезультатПубликации.response.doc.id,"ЧГ=0");
						//https://api.vk.com/method/wall.post?owner_id=13072&message=Соревнование&attachments=&access_token="+Токен+"&v=5.92"
						Если ЭтоПубликацияГруппы Тогда
							СтрокаЗапроса = Новый HTTPЗапрос("/method/wall.post?owner_id=-"+ФорматированныйИД+"&message="+ЗаголовокДокумента+"&attachments="+Аттач+"&access_token="+Токен+"&v="+ВерсияАпи+"");
						Иначе
							СтрокаЗапроса = Новый HTTPЗапрос("/method/wall.post?owner_id="+ФорматированныйИД+"&message="+ЗаголовокДокумента+"&attachments="+Аттач+"&access_token="+Токен+"&v="+ВерсияАпи+"");
						КонецЕсли; 
						ОтветНаРазмещениеЗаписи = СоединениеОсновное.Получить(СтрокаЗапроса);
						
						РезультатОтправки = ОбщийКлиентСервер.СформироватьОтветHTTPВСтруктуру(ОтветНаРазмещениеЗаписи);
						
						Если РезультатОтправки.Свойство("response") Тогда
							Сообщение = Новый СообщениеПользователю;
							Сообщение.Текст = "Запись успешно размещена у "+ФорматированныйИД;
							Сообщение.Сообщить();
						Иначе
							Сообщение = Новый СообщениеПользователю;
							Сообщение.Текст = "Ошибка: "+РезультатОтправки.КодСостояния + Символы.ПС + РезультатОтправки.ПолучитьТелоКакСтроку();
							Сообщение.Сообщить(); 
						КонецЕсли; 
						//можно удалить файл
						Если ДанныеДляОтправки.Свойство("втИмяФайла") Тогда
							Если ЗначениеЗаполнено(ДанныеДляОтправки.втИмяФайла) Тогда
								НачатьУдалениеФайлов(Новый ОписаниеОповещения("ПослеУдаленияФайлов",РаботаССоциальнымиСетямиКлиент),ДанныеДляОтправки.втИмяФайла);
							КонецЕсли; 
						КонецЕсли; 
						Если ДанныеДляОтправки.Свойство("ФайлКартинки") Тогда
							Если ЗначениеЗаполнено(ДанныеДляОтправки.ФайлКартинки) Тогда
								НачатьУдалениеФайлов(Новый ОписаниеОповещения("ПослеУдаленияФайлов",РаботаССоциальнымиСетямиКлиент),ДанныеДляОтправки.ФайлКартинки);
							КонецЕсли; 
						КонецЕсли; 
					КонецЕсли; 
				КонецЕсли;
			ИначеЕсли СтруктураДанных.Свойство("error") Тогда 
				Сообщение = Новый СообщениеПользователю;
				Сообщение.Текст = "Ошибка: "+Ответ.КодСостояния + Символы.ПС + Ответ.ПолучитьТелоКакСтроку();
				Сообщение.Сообщить(); 
			КонецЕсли; 
		Иначе
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = "Ошибка: "+СтруктураДанных.error.error_code + Символы.ПС + СтруктураДанных.error.error_msg;
			Сообщение.Сообщить(); 
		КонецЕсли; 			
	КонецЦикла; 
	
КонецПроцедуры

#КонецОбласти 

#Область ТЕЛЕГРАММ
  
////////////////////////////////////////////////////////////////////////////////
//
// Функция ОтправитьФайлТелеграммБоту
//
// Описание:
//
//
// Параметры:
// Название - тип - дифференцированное значение
//
// Возвращаемое значение: 
//
Процедура ОтправитьФайлТелеграммБоту(ДанныеДляОтправки) Экспорт
	
	Для каждого ТекУчастник Из ДанныеДляОтправки.ИДДляОтправки Цикл
		
		// Сформировать тело запроса
		Разделитель     = Строка(Новый УникальныйИдентификатор());
		
		
		// Формируем основное составное сообщение
		Тело            = Новый ПотокВПамяти();
		ЗаписьДанных    = Новый ЗаписьДанных(Тело, КодировкаТекста.UTF8, ПорядокБайтов.LittleEndian, Символы.ВК + Символы.ПС, Символы.ПС, Истина);
		
		// chat_id
		ЗаписьДанных.ЗаписатьСтроку("--" + Разделитель);
		ЗаписьДанных.ЗаписатьСтроку("Content-Disposition: form-data; name=""chat_id""");
		ЗаписьДанных.ЗаписатьСтроку("");
		ЗаписьДанных.ЗаписатьСтроку(ТекУчастник.ИД);
		
		// disable_notification
		ЗаписьДанных.ЗаписатьСтроку("--" + Разделитель);
		ЗаписьДанных.ЗаписатьСтроку("Content-Disposition: form-data; name=""disable_notification""");
		ЗаписьДанных.ЗаписатьСтроку("");
		ЗаписьДанных.ЗаписатьСтроку("True");
		
		Если ЗначениеЗаполнено(ДанныеДляОтправки.СсылкаНаДокумент) Тогда
			парЗаголовок = ДанныеДляОтправки.Заголовок;	
		Иначе
			парЗаголовок = ДанныеДляОтправки.ЗаголовокОтчета;
		КонецЕсли; 
		
		Если Не ПустаяСтрока(парЗаголовок) Тогда 
		    // caption
		    ЗаписьДанных.ЗаписатьСтроку("--" + Разделитель);
		    ЗаписьДанных.ЗаписатьСтроку("Content-Disposition: form-data; name=""caption""");
		    ЗаписьДанных.ЗаписатьСтроку("");
		    ЗаписьДанных.ЗаписатьСтроку(парЗаголовок);        
		    
		    // parse_mode
		    ЗаписьДанных.ЗаписатьСтроку("--" + Разделитель);
		    ЗаписьДанных.ЗаписатьСтроку("Content-Disposition: form-data; name=""parse_mode""");
		    ЗаписьДанных.ЗаписатьСтроку("");
		    ЗаписьДанных.ЗаписатьСтроку("HTML");
		КонецЕсли;
		
		парФормат 	= ДанныеДляОтправки.Формат;
		Если парФормат = "HTML" Тогда
			парФормат = "PNG";
			ПараметрИмени = "photo";
			МетодОтправки = "sendPhoto";
		Иначе
			ПараметрИмени = "document";
			МетодОтправки = "sendDocument";
		КонецЕсли;
		
		ИмяФайла = парЗаголовок;
		// document    
		ЗаписьДанных.ЗаписатьСтроку("--" + Разделитель);
		ЗаписьДанных.ЗаписатьСтроку(СтрШаблон("Content-Disposition: form-data; name="""+ПараметрИмени+"""; filename=""%1."+парФормат+"""", ?(ПустаяСтрока(ИмяФайла), "document_" + Строка(Новый УникальныйИдентификатор()), ИмяФайла)));
		ЗаписьДанных.ЗаписатьСтроку("Content-Type: application/"+парФормат+"");
		ЗаписьДанных.ЗаписатьСтроку("");   
		ЗаписьДанных.Закрыть();    
		
		Если парФормат = "HTML" Тогда
		Иначе	
			// Добавим файл
			ДанныеДляОтправки.ТабДокДляОтправки.Записать(Тело, ТипФайлаТабличногоДокумента.PDF);
		КонецЕсли; 
				
		// Завершение записи
		ЗаписьДанных    = Новый ЗаписьДанных(Тело, КодировкаТекста.UTF8, ПорядокБайтов.LittleEndian, Символы.ВК
			+ Символы.ПС, Символы.ПС, Ложь);
		ЗаписьДанных.ЗаписатьСтроку("");
		ЗаписьДанных.ЗаписатьСтроку("--" + Разделитель + "--");
		ЗаписьДанных.Закрыть();
		
		ДанныеТела          = Тело.ЗакрытьИПолучитьДвоичныеДанные();   
		
		// Сформировать соединение и запрос
		Соединение  = РаботаССоциальнымиСетямиКлиентСервер.УстановитьСоединениеСТелеграмм();
		Заголовки   = Новый Соответствие;
		Заголовки.Вставить("Content-Type",      "multipart/form-data; boundary=" + Разделитель);
		Заголовки.Вставить("Accept",            "*/*");
		Заголовки.Вставить("Cache-Control",     "no-cache");
		Заголовки.Вставить("Host",              "api.telegram.org");
		Заголовки.Вставить("Accept-Encoding",   "gzip, deflate");
		Заголовки.Вставить("Content-Length",    Формат(ДанныеТела.Размер(), "ЧДЦ=0; ЧН=0; ЧГ=0"));
		Заголовки.Вставить("Connection",        "close");
		Адрес       = СтрШаблон("/bot%1/%2", ДанныеДляОтправки.ТокенБота, МетодОтправки);
		Запрос      = Новый HTTPЗапрос(Адрес, Заголовки);
		Запрос.УстановитьТелоИзДвоичныхДанных(ДанныеТела);
		
		// POST
		Ответ       = Соединение.ОтправитьДляОбработки(Запрос);
		
		// Разбор ответа
		Если Ответ.КодСостояния <> 200 Тогда
		    ОтветСтрокой   = ОбщийКлиентСервер.СформироватьОтветHTTPВСтруктуру(Ответ);
		    ВызватьИсключение СтрШаблон("Ошибка отправки вложения в телеграм.
		        |Код состояния: %1
		        |Тело: %2"
		        , Ответ.КодСостояния
		        , Строка(ОтветСтрокой)
		    ); 
		КонецЕсли;
				
	КонецЦикла; 
	
	//можно удалить файл
	Если ДанныеДляОтправки.Свойство("втИмяФайла") Тогда
		Если ЗначениеЗаполнено(ДанныеДляОтправки.втИмяФайла) Тогда
			НачатьУдалениеФайлов(Новый ОписаниеОповещения("ПослеУдаленияФайлов",РаботаССоциальнымиСетямиКлиент),ДанныеДляОтправки.втИмяФайла);
		КонецЕсли; 
	КонецЕсли; 
	Если ДанныеДляОтправки.Свойство("ФайлКартинки") Тогда
		Если ЗначениеЗаполнено(ДанныеДляОтправки.ФайлКартинки) Тогда
			НачатьУдалениеФайлов(Новый ОписаниеОповещения("ПослеУдаленияФайлов",РаботаССоциальнымиСетямиКлиент),ДанныеДляОтправки.ФайлКартинки);
		КонецЕсли; 
	КонецЕсли; 
	
КонецПроцедуры //ОтправитьФайлТелеграммБоту

Процедура ОтправитьФайлТелеграммБотуЧерез_SDK(ДанныеДляОтправки) Экспорт
	
	Для каждого ТекУчастник Из ДанныеДляОтправки.ИДДляОтправки Цикл
		
		Если ЗначениеЗаполнено(ДанныеДляОтправки.СсылкаНаДокумент) Тогда
			парЗаголовок = ДанныеДляОтправки.Заголовок;	
		Иначе
			парЗаголовок = ДанныеДляОтправки.ЗаголовокОтчета;
		КонецЕсли; 
		
		парФормат 	= ДанныеДляОтправки.Формат;
		
		парЗаголовок = парЗаголовок + "."+НРег(парФормат);
		
		Если парФормат = "HTML" Тогда
			sendPhoto(ТекУчастник.ИД, ДанныеДляОтправки.ФайлКартинки, ДанныеДляОтправки.ТокенБота, парЗаголовок); 
		Иначе
			sendDocument(ТекУчастник.ИД, ДанныеДляОтправки.втИмяФайла, ДанныеДляОтправки.ТокенБота, парЗаголовок); 
		КонецЕсли;
						
	КонецЦикла; 
	
	//можно удалить файл
	Если ДанныеДляОтправки.Свойство("втИмяФайла") Тогда
		Если ЗначениеЗаполнено(ДанныеДляОтправки.втИмяФайла) Тогда
			НачатьУдалениеФайлов(Новый ОписаниеОповещения("ПослеУдаленияФайлов",РаботаССоциальнымиСетямиКлиент),ДанныеДляОтправки.втИмяФайла);
		КонецЕсли; 
	КонецЕсли; 
	Если ДанныеДляОтправки.Свойство("ФайлКартинки") Тогда
		Если ЗначениеЗаполнено(ДанныеДляОтправки.ФайлКартинки) Тогда
			НачатьУдалениеФайлов(Новый ОписаниеОповещения("ПослеУдаленияФайлов",РаботаССоциальнымиСетямиКлиент),ДанныеДляОтправки.ФайлКартинки);
		КонецЕсли; 
	КонецЕсли; 
	
КонецПроцедуры //ОтправитьФайлТелеграммБоту

//-352042906
Процедура ОтправитьСообщениеВТелеграм(ДанныеДляОтправки, Сообщение) Экспорт
	
	Соединение = РаботаССоциальнымиСетямиКлиентСервер.УстановитьСоединениеСТелеграмм();
	
	Для каждого ТекУчастник Из ДанныеДляОтправки.Участники Цикл
		Адрес       = СтрШаблон("/bot%1/sendMessage?chat_id=%2&parse_mode=HTML&text=%3"
		, ДанныеДляОтправки.Бот.Токен
		, ТекУчастник
		, РаботаССоциальнымиСетямиСервер.ЗакодироватьСтроку(Сообщение));
		Заголовки   = Новый Соответствие;
		Запрос      = Новый HTTPЗапрос(Адрес, Заголовки);
		
		// GET
		Ответ       = Соединение.Получить(Запрос);
		
		// Разбор ответа
		Если Ответ.КодСостояния <> 200 Тогда
			ОтветСтрокой    = ОбщийКлиентСервер.СформироватьОтветHTTPВСтруктуру(Ответ);
			ВызватьИсключение СтрШаблон("Ошибка отправки вложения в телеграм.
			|Код состояния: %1
			|Тело: %2"
			, Ответ.КодСостояния
			, Строка(ОтветСтрокой)
			); 
			
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры // ОтправитьСообщениеВТелеграм()

#Область TelegramAPI

Функция sendDocument(chat_id, ИмяФайлаПолное, AccessToken, ИмяФайла) Экспорт
	
	Если НЕ ЗначениеЗаполнено(chat_id) Тогда
		Возврат Неопределено;
	КонецЕсли; 	
	
	method_param = Новый Массив;
	method_param.Добавить("chat_id=" + ФорматироватьСтроку(chat_id));
	
	ТекущийФайл = Новый Файл(ИмяФайлаПолное);
		
	Данные = Новый Соответствие;
	Данные.Вставить("Boundary", "----" + Строка(Новый УникальныйИдентификатор));
	Данные.Вставить("ИмяФайлаПолное", ИмяФайлаПолное);
	Данные.Вставить("ИмяФайла", СерверныеСервер.Транслитерация(ТекущийФайл.ИмяБезРасширения)+"."+ТекущийФайл.Расширение);
	Данные.Вставить("name", "document");
	
	Результат = ОтправитьHTTPЗапрос(AccessToken, "sendDocument", method_param, Данные);
	
	Возврат ОбработатьJSON(Результат);
КонецФункции

Функция sendPhoto(chat_id, ИмяФайлаПолное, AccessToken, ИмяФайла) Экспорт
	
	Если НЕ ЗначениеЗаполнено(chat_id) Тогда
		Возврат Неопределено;
	КонецЕсли; 	
	
	method_param = Новый Массив;
	method_param.Добавить("chat_id=" + ФорматироватьСтроку(chat_id));
	
	ТекущийФайл 	= Новый Файл(ИмяФайла);
	ВтФайл				= Новый Файл(ИмяФайлаПолное);
	
	Данные = Новый Соответствие;
	Данные.Вставить("Boundary", "----" + Строка(Новый УникальныйИдентификатор));
	Данные.Вставить("ИмяФайлаПолное", ИмяФайлаПолное);
	Данные.Вставить("ИмяФайла", СерверныеСервер.Транслитерация(ТекущийФайл.ИмяБезРасширения)+"."+ВтФайл.Расширение);
	Данные.Вставить("name", "photo");
	
	Результат = ОтправитьHTTPЗапрос(AccessToken, "sendPhoto", method_param, Данные);
	
	Возврат ОбработатьJSON(Результат);
КонецФункции

#КонецОбласти 

#Область WEB

#Область Интерфейс

Функция ОтправитьHTTPЗапрос(access_token, method, method_param = Неопределено, Данные = Неопределено) Экспорт
	
	Результат = Неопределено;
	
	Попытка
		СоединениеHTTP  = РаботаССоциальнымиСетямиКлиентСервер.УстановитьСоединениеСТелеграмм();
		
		ПараметрыЗапроса = Новый Соответствие;
		ПараметрыЗапроса.Вставить("access_token", access_token);
		ПараметрыЗапроса.Вставить("method", method);
		ПараметрыЗапроса.Вставить("method_param", method_param);
		
		HTTPЗапрос = Новый HTTPЗапрос;
		Если Данные = Неопределено Тогда
			HTTPЗапрос.Заголовки.Вставить("Content-type", "application/json");
		Иначе
			HTTPЗапрос.Заголовки.Вставить("Content-type", "multipart/form-data; boundary=" + Данные["Boundary"]);
			
			ТекстЗапроса = СформироватьТекстЗапроса(Данные);
			HTTPЗапрос.УстановитьТелоИзСтроки(ТекстЗапроса, КодировкаТекста.ANSI, ИспользованиеByteOrderMark.НеИспользовать);
		КонецЕсли; 
		HTTPЗапрос.АдресРесурса = СформироватьМетод(ПараметрыЗапроса);
		
		Если Данные = Неопределено Тогда
			РезультатЗапроса = СоединениеHTTP.Получить(HTTPЗапрос);
		Иначе	
			РезультатЗапроса = СоединениеHTTP.ОтправитьДляОбработки(HTTPЗапрос);
		КонецЕсли; 
		
		Если РезультатЗапроса.КодСостояния = 200 Тогда
			Результат = РезультатЗапроса.ПолучитьТелоКакСтроку();
		Иначе
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = РезультатЗапроса.ПолучитьТелоКакСтроку();
			Сообщение.Сообщить(); 
		КонецЕсли; 
		
	Исключение
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = ОписаниеОшибки();
		Сообщение.Сообщить(); 
	КонецПопытки; 
	
	Возврат Результат;
КонецФункции
 
#КонецОбласти 

#Область СлужебныеПроцедурыИФункции

Функция СформироватьМетод(ПараметрыЗапроса)
	Стр = "";
	ПараметрыМетода = "";
	
	// Переделать формирование строки с методом и параметрами под конкретный API
	// данная реализация для ВКонтакте
	Если ЗначениеЗаполнено(ПараметрыЗапроса["method_param"]) Тогда
		Для каждого Строка Из ПараметрыЗапроса["method_param"] Цикл
			ПараметрыМетода = ПараметрыМетода + Строка + "&";
		КонецЦикла; 
	КонецЕсли; 
	
	Если ЗначениеЗаполнено(ПараметрыМетода) Тогда
		Стр = "bot" + ПараметрыЗапроса["access_token"] + "/" + ПараметрыЗапроса["method"] + "?";
		Стр = Стр + ПараметрыМетода;
	Иначе
		Стр = "bot" + ПараметрыЗапроса["access_token"] + "/" + ПараметрыЗапроса["method"];
	КонецЕсли; 
	
	Возврат Стр;
КонецФункции
 
Функция СформироватьJSON(СтруктураДанных, ФормироватьСПереносами = Ложь) Экспорт
	
	ЗаписьJSON = Новый ЗаписьJSON;
	Если ФормироватьСПереносами Тогда
		ЗаписьJSON.УстановитьСтроку(Новый ПараметрыЗаписиJSON(, Символы.Таб));
	Иначе
		ЗаписьJSON.УстановитьСтроку(Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Нет, Символы.Таб));
	КонецЕсли; 
	
	НастройкиСериализацииJSON = Новый НастройкиСериализацииJSON;
	НастройкиСериализацииJSON.ВариантЗаписиДаты = ВариантЗаписиДатыJSON.ЛокальнаяДатаСоСмещением;
	НастройкиСериализацииJSON.ФорматСериализацииДаты = ФорматДатыJSON.ISO;
	
	ЗаписатьJSON(ЗаписьJSON, СтруктураДанных, НастройкиСериализацииJSON);
	
	Возврат ЗаписьJSON.Закрыть();
КонецФункции
 
Функция ОбработатьJSON(СтрокаJSON) Экспорт
	
	СтруктураВозврата = Новый Структура;
	
	Попытка
		Чтение = Новый ЧтениеJSON;
		Чтение.УстановитьСтроку(СтрокаJSON);
		
		СтруктураВозврата = ПрочитатьJSON(Чтение);
	Исключение
	КонецПопытки; 
	
	Возврат СтруктураВозврата;
	
КонецФункции

Функция ФорматироватьСтроку(ТекущееЗначение) Экспорт
	Возврат Формат(ТекущееЗначение, "ЧРГ=''; ЧГ=0");
КонецФункции

Функция СформироватьТекстЗапроса(Данные)
	
	ТекстЗапроса = "";
	
	ТекстЗапроса = ТекстЗапроса + "--" + Данные["Boundary"] + Символы.ВК + Символы.ПС;
	ТекстЗапроса = ТекстЗапроса + "Content-Disposition: form-data; name=""" + Данные["name"] + """; filename=""" + Данные["ИмяФайла"] + """" + Символы.ВК + Символы.ПС;
	ТекстЗапроса = ТекстЗапроса + "Content-Type: application/x-zip-compressed" + Символы.ВК + Символы.ПС + Символы.ВК + Символы.ПС; 
	
	ДвоичныеДанныеСтрокой = ПолучитьДвоичныеДанныеВСтрокуБезКодирования(Данные["ИмяФайлаПолное"]);
	
	ТекстЗапроса = ТекстЗапроса + ДвоичныеДанныеСтрокой + Символы.ВК + Символы.ПС;
	
	ТекстЗапроса = ТекстЗапроса + "--" + Данные["Boundary"] + "--" + Символы.ВК + Символы.ПС;
	
	Возврат ТекстЗапроса;
КонецФункции

Функция ПолучитьДвоичныеДанныеВСтрокуБезКодирования(ИмяФайлаПолное)
	
	ТекстовыйДокумент = Новый ТекстовыйДокумент;
	ТекстовыйДокумент.Прочитать(ИмяФайлаПолное, КодировкаТекста.ANSI, Символы.ПС);
	
	Возврат ТекстовыйДокумент.ПолучитьТекст();
КонецФункции

#КонецОбласти 

#КонецОбласти 

#КонецОбласти 

Функция ОпределитьПараметрыИсточникаВызова(ИсточникВызова) Экспорт
	
	ПараметрыИсточника = Новый Структура;
	ПараметрыИсточника.Вставить("СсылкаНаДокумент", ПредопределенноеЗначение("Документ.ПроведениеСоревнования.ПустаяСсылка"));
	ПараметрыИсточника.Вставить("ТабДокДляОтправки", Неопределено);
	
	Если ИсточникВызова.ИмяФормы = "ОбщаяФорма.ФормаВыводаНаПечать" Тогда
		ПараметрыИсточника.ТабДокДляОтправки = ИсточникВызова.ТабДок;
		Если ЗначениеЗаполнено(ИсточникВызова.СсылкаНаДокумент) Тогда
			ПараметрыИсточника.СсылкаНаДокумент = ИсточникВызова.СсылкаНаДокумент;
		КонецЕсли; 
	Иначе 
		ТабДок = ИсточникВызова.ОтчетТабличныйДокумент;
		ТабДок.АвтоМасштаб = Истина;
		ПараметрыИсточника.ТабДокДляОтправки = ТабДок;
	КонецЕсли; 	
	
	Если СтрНайти(ИсточникВызова.ИмяФормы,"Отчет") > 0 Тогда
		ЗаголовокОтчета 	= ИсточникВызова.Окно.Заголовок + " от " + ТекущаяДата();
	Иначе
		ЗаголовокОтчета	= "";
	КонецЕсли; 
	
	ПараметрыИсточника.Вставить("ЗаголовокОтчета", ЗаголовокОтчета);
	
	Возврат ПараметрыИсточника;
	
КонецФункции

Процедура ПослеУдаленияФайлов(ДопПараметры) Экспорт
	
КонецПроцедуры
