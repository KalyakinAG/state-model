
Процедура УстановитьПараметрыСвязиПоляФормы(Элемент, Знач СвязиПараметровВыбора=Неопределено, Знач ПараметрыВыбора=Неопределено) Экспорт
	ПустойМассив			= Новый ФиксированныйМассив(Новый Массив);
	СвязиПараметровВыбора	= ?(СвязиПараметровВыбора = Неопределено, ПустойМассив, Новый ФиксированныйМассив(СвязиПараметровВыбора));
	ПараметрыВыбора			= ?(ПараметрыВыбора       = Неопределено, ПустойМассив, Новый ФиксированныйМассив(ПараметрыВыбора));
	ПараметрыИдентичны		= (ОбщийКлиентСервер.МассивыИдентичны(Элемент.СвязиПараметровВыбора, СвязиПараметровВыбора)
								И	ОбщийКлиентСервер.МассивыИдентичны(Элемент.ПараметрыВыбора, ПараметрыВыбора));
	Если Не ПараметрыИдентичны Тогда
		Элемент.СвязиПараметровВыбора	= СвязиПараметровВыбора;
		Элемент.ПараметрыВыбора			= ПараметрыВыбора;
	КонецЕсли;
КонецПроцедуры

Процедура НастроитьПараметрыВыбора(Контекст) Экспорт
	МодельОбъекта = РаботаСМодельюОбъектаКлиентСервер.ПолучитьМодель(Контекст);
	Для Каждого ЭлементКоллекции Из МодельОбъекта.ЭлементыФормы Цикл
		СвязиПараметровВыбора = Новый Массив;
		ПараметрыВыбора = Новый Массив;
		ЭлементФормы = ЭлементКоллекции.Значение;
		Если ЭлементФормы.Имя = "ЭтаФорма" Тогда
			Продолжить;
		КонецЕсли;
		Элемент = МодельОбъекта.Контекст.Элементы[ЭлементФормы.Имя];
		Если НЕ ТипЗнч(Элемент) = Тип("ПолеФормы") ИЛИ НЕ Элемент.Вид = ВидПоляФормы.ПолеВвода Тогда
			Продолжить;
		КонецЕсли;
		Для Каждого ИдентификаторСвязи Из ЭлементФормы.Параметр.Параметры Цикл
			Связь = МодельОбъекта.СвязиПараметров[ИдентификаторСвязи];
			Если ЗначениеЗаполнено(Связь.ПараметрИспользование) И НЕ РаботаСМодельюОбъектаКлиентСервер.ПолучитьЗначениеПараметра(МодельОбъекта, Связь.ПараметрИспользование) Тогда
				Продолжить;
			КонецЕсли;
			Параметр = Связь.Параметр;
			Если НЕ РаботаСМодельюОбъектаКлиентСервер.ЗначениеСвойстваПараметра(МодельОбъекта, Параметр, , "Использование") Тогда
				Продолжить;
			КонецЕсли;
			Если НЕ ЗначениеЗаполнено(Параметр) Тогда
				ПараметрыВыбора.Добавить(Новый ПараметрВыбора(Связь.ПутьКДанным, Связь.Значение));
			ИначеЕсли ЗначениеЗаполнено(Параметр.ПутьКДанным) Тогда
				//  Это СвязьПараметровВыбора
				Если ЗначениеЗаполнено(Параметр.ПараметрТаблица) Тогда
					//  Это связь со строкой таблицы элемента
					ПутьКДанным = Параметр.ПутьКДанным;
					ИмяРеквизита = ОбщийКлиентСервер.ОкончаниеСтрокиПослеРазделителя(ПутьКДанным);
					ПутьКДанным = "Элементы." + Параметр.ПараметрТаблица.Имя + ".ТекущиеДанные." + ИмяРеквизита;
				Иначе
					//  Это связь с реквизитом формы или объекта
					ПутьКДанным = Связь.ПутьКДанным;
				КонецЕсли;
				СвязиПараметровВыбора.Добавить(Новый СвязьПараметраВыбора(ПутьКДанным, РаботаСМодельюОбъектаКлиентСервер.ПутьКДанным(МодельОбъекта, Параметр), РежимИзмененияСвязанногоЗначения.НеИзменять));
			Иначе
				//  Это ПараметрыВыбора
				Значение = РаботаСМодельюОбъектаКлиентСервер.ПолучитьЗначениеПараметра(МодельОбъекта, Параметр);
				ПараметрыВыбора.Добавить(Новый ПараметрВыбора(Связь.ПутьКДанным, Значение));
			КонецЕсли;
		КонецЦикла;
		УстановитьПараметрыСвязиПоляФормы(Элемент, СвязиПараметровВыбора, ПараметрыВыбора);
	КонецЦикла;
КонецПроцедуры