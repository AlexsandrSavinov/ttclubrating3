
Функция ЗагрузитьПорядокИгрВМодуле() Экспорт
	
	//сначала очищаем
	ВыборкаЗаписей = РегистрыСведений.ПорядокИгр.Выбрать();
	Пока ВыборкаЗаписей.Следующий()Цикл
		ВыборкаЗаписей.ПолучитьМенеджерЗаписи().Удалить();
	КонецЦикла; 
	НаборЗаписей = РегистрыСведений.ПорядокИгр.СоздатьНаборЗаписей();
	
	//групповой
	
	//сетки
	//МИНУС2 
	//на 8 
	ДобавитьПорядокИгрСетка8(НаборЗаписей);
	//на 16 
	ДобавитьПорядокИгрСетка16(НаборЗаписей);
	//на 24
	ДобавитьПорядокИгрСетка24(НаборЗаписей);
	//на 32
	ДобавитьПорядокИгрСетка32(НаборЗаписей);
	//на 48
	ДобавитьПорядокИгрСетка48(НаборЗаписей);
	//на 64
	ДобавитьПорядокИгрСетка64(НаборЗаписей);
	
	//ОЛИМПИЙКА
	ДобавитьПорядокОлимпийка8(НаборЗаписей);
	ДобавитьПорядокОлимпийка16(НаборЗаписей);
	ДобавитьПорядокОлимпийка24(НаборЗаписей);
	ДобавитьПорядокОлимпийка32(НаборЗаписей);
	ДобавитьПорядокОлимпийка48(НаборЗаписей);
	ДобавитьПорядокОлимпийка64(НаборЗаписей);
	
	//ПРОГРЕССИВКА
	ДобавитьПорядокИгрПрогрессивка8(НаборЗаписей);
	ДобавитьПорядокИгрПрогрессивка16(НаборЗаписей);
	ДобавитьПорядокИгрПрогрессивка32(НаборЗаписей);
	
	Возврат НаборЗаписей;
	
КонецФункции
 
Процедура ДобавитьЗаписьВНабор(ВсеЗаписи,Режим,КолУчастников,ПриоритетВызоыва,НомерИгры)
	
	ЗаписьРегистра = ВсеЗаписи.Добавить();
	ЗаписьРегистра.РежимТура							= Режим;
	ЗаписьРегистра.КоличествоУчастников		= КолУчастников;
	ЗаписьРегистра.ПриоритетВызова				= ПриоритетВызоыва;
	ЗаписьРегистра.НомерИгры							= НомерИгры;
	
КонецПроцедуры

// СИСТЕМА -2
Процедура ДобавитьПорядокИгрСетка8(ВсеЗаписи)
	
	//1.	1-4
	//2.	8-9,10-11
	//3.	5-6
	//4.	13-14
	//5.	12
	//6.	7
	
	//1
	Для Н = 1 По 4 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,8,1,Н);
	КонецЦикла; 
	//2
	Для Н = 8 По 9 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,8,2,Н);
	КонецЦикла;
	//3
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,8,3,5);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,8,3,6);
	//4
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,8,4,10);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,8,4,11);
	//5
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,8,5,13);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,8,5,14);
	//6
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,8,5,12);
	//7
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,8,6,7);
			
КонецПроцедуры

Процедура ДобавитьПорядокИгрСетка16(ВсеЗаписи)
	
	//1.	1-8
	//2.	16-19,9-12
	//3.	20-23
	//4.	13-14,24-25
	//5.	31-32,35-36
	//6.	26-27
	//7.	38,37,34,33,30,29,28
	//8.	15 - финал
	
	//1
	Для Н = 1 По 8 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,16,1,Н);
	КонецЦикла; 
	//2
	Для Н = 16 По 19 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,16,2,Н);
	КонецЦикла;
	Для Н = 9 По 12 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,16,2,Н);
	КонецЦикла;
	//3
	Для Н = 20 По 23 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,16,3,Н);
	КонецЦикла;
	//4
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,16,4,13);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,16,4,14);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,16,4,24);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,16,4,25);
	//5
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,16,5,31);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,16,5,32);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,16,5,35);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,16,5,36);
	//6
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,16,6,26);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,16,6,27);
	//7
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,16,7,38);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,16,7,37);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,16,7,34);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,16,7,33);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,16,7,30);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,16,7,29);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,16,7,28);
	//8
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,16,8,15);
			
КонецПроцедуры

Процедура ДобавитьПорядокИгрСетка24(ВсеЗаписи)
	
	//1.	1-8,9-16
	//2.	24-31
	//3.	32-35,17-20
	//4.	36-39,55-58
	//5.	40-41,21-22
	//6.	63,64,59-60,51-52,47-48,42-43
	//7.	66,65,62,61,54,53,50,49,46,45,44
	//8.	23 - финал
	
	//1
	Для Н = 1 По 16 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,1,Н);
	КонецЦикла; 
	//2
	Для Н = 24 По 31 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,2,Н);
	КонецЦикла;
	//3
	Для Н = 32 По 35 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,3,Н);
	КонецЦикла;
	Для Н = 17 По 20 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,3,Н);
	КонецЦикла;
	//4
	Для Н = 36 По 39 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,4,Н);
	КонецЦикла;
	Для Н = 55 По 58 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,4,Н);
	КонецЦикла;
	//5
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,5,40);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,5,41);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,5,21);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,5,22);
	//6
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,6,63);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,6,64);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,6,59);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,6,60);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,6,51);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,6,52);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,6,47);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,6,48);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,6,42);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,6,43);
	//7.	66,65,62,61,54,53,50,49,46,45,44
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,7,66);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,7,65);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,7,62);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,7,61);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,7,54);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,7,53);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,7,50);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,7,49);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,7,46);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,7,45);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,7,44);
	//8
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,24,8,23);
			
КонецПроцедуры

Процедура ДобавитьПорядокИгрСетка32(ВсеЗаписи)
	
	//1.	1-16
	//2.	32-39,17-24
	//3.	40-47
	//4.	48-51,25-28
	//5.	83-86,71-74,52-55
	//6.	56-57,29-30
	//7.	91-92,87-88,79-80,75-76,67-68,63-64
	//8.	58-59
	//9.	94,93,90,89,82,80,78,77,70,69,66,65,62,61
	//10.	60
	//11.	31 - финал
	
	//1
	Для Н = 1 По 16 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,1,Н);
	КонецЦикла; 
	//2
	Для Н = 32 По 39 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,2,Н);
	КонецЦикла;
	Для Н = 17 По 24 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,2,Н);
	КонецЦикла;
	//3
	Для Н = 40 По 47 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,3,Н);
	КонецЦикла;
	//4
	Для Н = 48 По 51 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,4,Н);
	КонецЦикла;
	Для Н = 25 По 28 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,4,Н);
	КонецЦикла;
	//5
	Для Н = 83 По 86 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,5,Н);
	КонецЦикла;
	Для Н = 71 По 74 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,5,Н);
	КонецЦикла;
	Для Н = 52 По 55 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,5,Н);
	КонецЦикла;
	//6
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,6,56);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,6,57);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,6,29);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,6,30);
	//7.	91-92,87-88,79-80,75-76,67-68,63-64
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,7,91);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,7,92);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,7,87);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,7,88);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,7,79);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,7,80);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,7,75);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,7,76);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,7,67);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,7,68);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,7,63);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,7,64);
	//8.	58-59
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,8,58);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,8,59);
	//9.	94,93,90,89,82,80,78,77,70,69,66,65,62,61
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,9,94);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,9,93);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,9,90);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,9,89);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,9,82);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,9,81);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,9,78);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,9,77);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,9,70);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,9,69);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,9,66);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,9,65);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,9,62);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,9,61);
	//10.	60
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,10,60);
	//11.	31 - финал
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,32,11,31);
			
КонецПроцедуры

Процедура ДобавитьПорядокИгрСетка48(ВсеЗаписи)
	
	//1.	1-32
	//2.	48-63
	//3.	64-71,33-40
	//4.	127-134
	//5.	72-79
	//6.	80-83,41-44
	//7.	135-138
	//8.	84-87,115-118,103-106,147-150
	//9.	88-89,45-46
	//10.	155-156,151-152,143-144,139-140,119-120,123-124,111-112,107-108,99-100,95-96,90-91
	//11.	158,157,154,153,146,145,152,151,126,125,122,121,114,113, 110,109,102,101,98,97,94,93
	//12.	92
	//13.	47 - финал
	
	//1
	Для Н = 1 По 32 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,1,Н);
	КонецЦикла; 
	//2
	Для Н = 48 По 63 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,2,Н);
	КонецЦикла;
	//3
	Для Н = 64 По 71 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,3,Н);
	КонецЦикла;
	Для Н = 33 По 40 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,3,Н);
	КонецЦикла;
	//4
	Для Н = 127 По 134 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,4,Н);
	КонецЦикла;
	//5
	Для Н = 72 По 79 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,5,Н);
	КонецЦикла;
	//6
	Для Н = 80 По 83 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,6,Н);
	КонецЦикла;
	Для Н = 41 По 44 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,6,Н);
	КонецЦикла;
	//7
	Для Н = 135 По 138 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,7,Н);
	КонецЦикла;
	//8.	84-87,115-118,103-106,147-150
	Для Н = 84 По 87 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,8,Н);
	КонецЦикла;
	Для Н = 115 По 118 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,8,Н);
	КонецЦикла;
	Для Н = 103 По 106 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,8,Н);
	КонецЦикла;
	Для Н = 147 По 150 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,8,Н);
	КонецЦикла;
	
	//9.	88-89,45-46
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,9,88);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,9,89);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,9,45);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,9,46);
	//10.	155-156,151-152,143-144,139-140,119-120,123-124,111-112,107-108,99-100,95-96,90-91
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,10,155);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,10,156);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,10,151);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,10,152);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,10,143);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,10,144);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,10,139);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,10,140);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,10,119);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,10,120);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,10,123);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,10,124);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,10,111);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,10,112);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,10,107);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,10,108);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,10,99);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,10,100);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,10,95);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,10,96);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,10,90);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,10,91);
	
	//11.	158,157,154,153,146,145,152,151,126,125,122,121,114,113, 110,109,102,101,98,97,94,93
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,11,158);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,11,157);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,11,154);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,11,153);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,11,146);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,11,145);
	//ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,11,152);
	//ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,11,151);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,11,126);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,11,125);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,11,122);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,11,121);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,11,114);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,11,113);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,11,110);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,11,109);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,11,102);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,11,101);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,11,98);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,11,97);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,11,94);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,11,93);
	//12.	92
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,12,92);
	//13.	47 - финал
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,48,13,47);
				
КонецПроцедуры

Процедура ДобавитьПорядокИгрСетка64(ВсеЗаписи)
	//
	//1. 1-32
	//2. 64-79,33-48
	//3. 80-95
	//4. 96-103,49-56
	//5. 104-111
	//6. 191-198,159-166
	//7. 57-60, 112-116
	//8. 116-119,211-214,199-202,179-182,167-170,147-150,135-138
	//9. 219-220,215-216,207-208,203-204,187-188,183-184,175-176,171-172,155-156,151-
	//152,143-144,139-140,131-132,127-128,121-120, 61-62
	
	//10.123-122
	//11.222,221,218,217,210,209,206,205,190,189,186,185,178,177,174,173,
	//158,157,154,153,146,145,141,142,134,133,130,129,126,125
	//12.124
	//13.63

	//1
	Для Н = 1 По 32 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,1,Н);
	КонецЦикла; 
	//2
	Для Н = 64 По 79 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,2,Н);
	КонецЦикла;
	Для Н = 33 По 48 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,2,Н);
	КонецЦикла;
	//3
	Для Н = 80 По 95 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,3,Н);
	КонецЦикла;
	//4
	Для Н = 96 По 103 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,4,Н);
	КонецЦикла;
	Для Н = 49 По 56 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,4,Н);
	КонецЦикла;
	//5
	Для Н = 104 По 111 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,5,Н);
	КонецЦикла;
	//6
	Для Н = 191 По 198 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,6,Н);
	КонецЦикла;
	Для Н = 159 По 166 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,6,Н);
	КонецЦикла;
	//7.	 57-60, 112-116
	Для Н = 57 По 60 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,7,Н);
	КонецЦикла;
	Для Н = 112 По 116 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,7,Н);
	КонецЦикла;
	//8. 116-119,211-214,199-202,179-182,167-170,147-150,135-138
	Для Н = 116 По 119 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,8,Н);
	КонецЦикла;
	Для Н = 211 По 214 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,8,Н);
	КонецЦикла;
	Для Н = 199 По 202 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,8,Н);
	КонецЦикла;
	Для Н = 179 По 182 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,8,Н);
	КонецЦикла;
	Для Н = 167 По 170 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,8,Н);
	КонецЦикла;
	Для Н = 147 По 150 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,8,Н);
	КонецЦикла;
	Для Н = 135 По 138 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,8,Н);
	КонецЦикла;
	//9. 219-220,215-216,207-208,203-204,187-188,183-184,175-176,171-172,155-156,151-
	//	152,143-144,139-140,131-132,127-128,121-120, 61-62
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,219);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,220);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,215);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,216);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,207);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,208);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,203);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,204);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,187);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,188);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,183);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,184);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,175);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,176);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,171);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,172);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,155);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,156);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,151);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,152);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,143);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,144);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,139);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,140);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,131);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,132);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,127);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,128);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,121);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,120);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,61);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,9,62);
	//10.	123-122
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,10,123);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,10,122);
	//11.222,221,218,217,210,209,206,205,190,189,186,185,178,177,174,173,
	//	 158,157,154,153,146,145,141,142,134,133,130,129,126,125
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,222);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,221);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,218);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,217);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,210);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,209);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,206);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,205);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,190);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,189);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,186);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,185);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,178);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,177);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,174);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,173);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,158);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,157);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,154);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,153);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,146);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,145);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,141);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,142);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,134);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,133);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,130);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,129);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,126);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,125);
	
	//ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,123);
	//ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,11,122);
	//12.	124
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,12,124);
	//13.	63
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.МинусДва,64,13,63);
			
КонецПроцедуры

// ОЛИМПИЙКА
Процедура ДобавитьПорядокОлимпийка8(ВсеЗаписи)
	
	Для Н = 1 По 7 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Олимпийка,8,1,Н);
	КонецЦикла; 
	
КонецПроцедуры

Процедура ДобавитьПорядокОлимпийка16(ВсеЗаписи)
	
	Для Н = 1 По 15 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Олимпийка,16,1,Н);
	КонецЦикла; 
	
КонецПроцедуры

Процедура ДобавитьПорядокОлимпийка24(ВсеЗаписи)
	
	Для Н = 1 По 23 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Олимпийка,24,1,Н);
	КонецЦикла; 
	
КонецПроцедуры

Процедура ДобавитьПорядокОлимпийка32(ВсеЗаписи)
	
	Для Н = 1 По 31 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Олимпийка,32,1,Н);
	КонецЦикла; 
	
КонецПроцедуры

Процедура ДобавитьПорядокОлимпийка48(ВсеЗаписи)
	
	Для Н = 1 По 47 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Олимпийка,48,1,Н);
	КонецЦикла; 
	
КонецПроцедуры

Процедура ДобавитьПорядокОлимпийка64(ВсеЗаписи)
	
	Для Н = 1 По 63 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Олимпийка,64,1,Н);
	КонецЦикла; 
	
КонецПроцедуры

//ПРОГРЕССИВКА
Процедура ДобавитьПорядокИгрПрогрессивка8(ВсеЗаписи)
		
	//1
	Для Н = 1 По 4 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,8,1,Н);
	КонецЦикла; 
	//2
	Для Н = 8 По 9 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,8,2,Н);
	КонецЦикла;
	//3
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,8,3,5);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,8,3,6);
	//4
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,8,4,12);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,8,4,11);
	//5
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,8,5,10);
	//6
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,8,6,7);
			
КонецПроцедуры

Процедура ДобавитьПорядокИгрПрогрессивка16(ВсеЗаписи)
	
	//1.	1-8
	//2.	16-19,9-12
	//3.	20-23
	//4.	13-14,24-25
	//5.	31-32,35-36
	//6.	26-27
	//7.	38,37,34,33,30,29,28
	//8.	15 - финал
	
	//1
	Для Н = 1 По 8 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,16,1,Н);
	КонецЦикла; 
	//2
	Для Н = 16 По 19 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,16,2,Н);
	КонецЦикла;
	Для Н = 9 По 12 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,16,2,Н);
	КонецЦикла;
	//3
	Для Н = 20 По 23 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,16,3,Н);
	КонецЦикла;
	//4
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,16,4,13);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,16,4,14);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,16,4,24);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,16,4,25);
	//5
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,16,5,31);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,16,5,32);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,16,5,35);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,16,5,36);
	//6
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,16,6,26);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,16,6,27);
	//7
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,16,7,38);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,16,7,37);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,16,7,34);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,16,7,33);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,16,7,30);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,16,7,29);
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,16,7,28);
	//8
	ДобавитьЗаписьВНабор(ВсеЗаписи,Перечисления.РежимыТуровСоревнования.Прогрессивная,16,8,15);
			
КонецПроцедуры

Процедура ДобавитьПорядокИгрПрогрессивка32(ВсеЗаписи)
	
	//1.	1-16
	//2.	32-39,17-24
	//3.	40-47
	//4.	48-51,25-28
	//5.	83-86,71-74,52-55
	//6.	56-57,29-30
	//7.	91-92,87-88,79-80,75-76,67-68,63-64
	//8.	58-59
	//9.	94,93,90,89,82,80,78,77,70,69,66,65,62,61
	//10.	60
	//11.	31 - финал
	РежимТура = Перечисления.РежимыТуровСоревнования.Прогрессивная;	
	//1
	Для Н = 1 По 16 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,1,Н);
	КонецЦикла; 
	//2
	Для Н = 32 По 39 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,2,Н);
	КонецЦикла;
	Для Н = 17 По 24 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,2,Н);
	КонецЦикла;
	//3
	Для Н = 40 По 47 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,3,Н);
	КонецЦикла;
	//4
	Для Н = 48 По 51 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,4,Н);
	КонецЦикла;
	Для Н = 25 По 28 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,4,Н);
	КонецЦикла;
	//5
	//Для Н = 83 По 86 Цикл
	//	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,5,Н);
	//КонецЦикла;
	Для Н = 71 По 74 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,5,Н);
	КонецЦикла;
	Для Н = 52 По 55 Цикл
		ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,5,Н);
	КонецЦикла;
	//6
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,6,56);
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,6,57);
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,6,29);
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,6,30);
	//7.	91-92,87-88,79-80,75-76,67-68,63-64
	//ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,7,91);
	//ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,7,92);
	//ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,7,87);
	//ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,7,88);
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,7,79);
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,7,80);
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,7,75);
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,7,76);
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,7,67);
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,7,68);
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,7,63);
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,7,64);
	//8.	58-59
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,8,58);
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,8,59);
	//9.	94,93,90,89,82,80,78,77,70,69,66,65,62,61
	//ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,9,94);
	//ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,9,93);
	//ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,9,90);
	//ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,9,89);
	//ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,9,82);
	//ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,9,81);
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,9,78);
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,9,77);
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,9,70);
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,9,69);
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,9,66);
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,9,65);
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,9,62);
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,9,61);
	//10.	60
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,10,60);
	//11.	31 - финал
	ДобавитьЗаписьВНабор(ВсеЗаписи,РежимТура,32,11,31);
			
КонецПроцедуры
