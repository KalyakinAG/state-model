Процедура ПриАктивизацииСтроки(Контекст, Элемент) Экспорт
	МодельОбъекта = РаботаСМодельюОбъектаКлиентСервер.ПолучитьМодель(Контекст);
	РасчетныйПараметр = РаботаСМодельюФормыКлиентСервер.ПолучитьРасчетныйПараметрЭлементаФормы(Контекст, Элемент.Имя);
	РаботаСМодельюОбъектаКлиентСервер.УстановитьЗначениеПараметра(МодельОбъекта, РасчетныйПараметр.Параметр.ПараметрТекущаяСтрока, Элемент.ТекущаяСтрока);
КонецПроцедуры

Процедура ПроверитьЗаполнениеПараметровВыбора(Контекст, Элемент, СтандартнаяОбработка) Экспорт
	МодельОбъекта = РаботаСМодельюОбъектаКлиентСервер.ПолучитьМодель(Контекст);
	ЭлементФормы = МодельОбъекта.ЭлементыФормы[Элемент.Имя];
	Если НЕ ЗначениеЗаполнено(ЭлементФормы) Тогда
		Возврат;
	КонецЕсли;
	Для Каждого ИдентификаторСвязи Из ЭлементФормы.Параметр.Параметры Цикл
		Связь = МодельОбъекта.СвязиПараметров[ИдентификаторСвязи];
		Если Связь.Слабая Тогда
			Продолжить;
		КонецЕсли;
		Если ЗначениеЗаполнено(Связь.Параметр) Тогда
			Параметр = Связь.Параметр;
			Если ЗначениеЗаполнено(Параметр.ПараметрТаблица) Тогда
				ТекущаяСтрока = РаботаСМодельюОбъектаКлиентСервер.ПолучитьЗначениеПараметра(МодельОбъекта, Параметр.ПараметрТаблица.ПараметрТекущаяСтрока);
				Если ЗначениеЗаполнено(Связь.ПараметрИспользование)
					И (НЕ РаботаСМодельюОбъектаКлиентСервер.ЗначениеСвойстваПараметра(МодельОбъекта, Связь.ПараметрИспользование, ТекущаяСтрока, "Использование")
					ИЛИ НЕ РаботаСМодельюОбъектаКлиентСервер.ПолучитьЗначениеПараметра(МодельОбъекта, Связь.ПараметрИспользование, ТекущаяСтрока))  Тогда
					Продолжить;
				КонецЕсли;
				Если НЕ РаботаСМодельюОбъектаКлиентСервер.ЗначениеСвойстваПараметра(МодельОбъекта, Параметр, ТекущаяСтрока, "ПроверкаЗаполнения") Тогда
					Продолжить;
				КонецЕсли;
				ЗначениеПараметра = РаботаСМодельюОбъектаКлиентСервер.ПолучитьЗначениеПараметра(МодельОбъекта, Параметр, ТекущаяСтрока);
			Иначе
				Если ЗначениеЗаполнено(Связь.ПараметрИспользование)
					И (НЕ РаботаСМодельюОбъектаКлиентСервер.ЗначениеСвойстваПараметра(МодельОбъекта, Связь.ПараметрИспользование, , "Использование")
					ИЛИ НЕ РаботаСМодельюОбъектаКлиентСервер.ПолучитьЗначениеПараметра(МодельОбъекта, Связь.ПараметрИспользование))  Тогда
					Продолжить;
				КонецЕсли;
				Если НЕ РаботаСМодельюОбъектаКлиентСервер.ЗначениеСвойстваПараметра(МодельОбъекта, Параметр, , "Использование")
					ИЛИ НЕ РаботаСМодельюОбъектаКлиентСервер.ЗначениеСвойстваПараметра(МодельОбъекта, Параметр, , "ПроверкаЗаполнения") Тогда
					Продолжить;
				КонецЕсли;
				ЗначениеПараметра = РаботаСМодельюОбъектаКлиентСервер.ПолучитьЗначениеПараметра(МодельОбъекта, Параметр);
			КонецЕсли;
			Если НЕ ЗначениеЗаполнено(ЗначениеПараметра) Тогда
				ТекстСообщения	= "Не заполнено значение "+Параметр.Имя;
				Если ЗначениеЗаполнено(Параметр.ПараметрТаблица) Тогда
					ИмяРеквизита = ОбщийКлиентСервер.ОкончаниеСтрокиПослеРазделителя(Параметр.ПутьКДанным, ".");
					Поле = СтрШаблон("%1[%2].%3", РаботаСМодельюОбъектаКлиентСервер.ПутьКДанным(МодельОбъекта, Параметр.ПараметрТаблица), Формат(ТекущаяСтрока, "ЧН=0; ЧГ=;"), ИмяРеквизита);
				Иначе
					Поле = РаботаСМодельюОбъектаКлиентСервер.ПутьКДанным(МодельОбъекта, Параметр);
				КонецЕсли;
				СтандартнаяОбработка = Ложь;
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , Поле);
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

Процедура НастроитьСвойство(Форма, Элемент, Свойство, Значение)
	Если Свойство = "ТекущаяСтраница" Тогда
		Если НЕ ЗначениеЗаполнено(Значение) Тогда
			Возврат;
		КонецЕсли;
		ОбщийКлиентСервер.УстановитьЗначение(Элемент[Свойство], Форма.Элементы[Значение]);
	ИначеЕсли Свойство = "СписокВыбора" Тогда
		Элемент.СписокВыбора.Очистить();
		Для каждого ЭлементСписка Из Значение Цикл
			Элемент.СписокВыбора.Добавить(ЭлементСписка.Значение, ЭлементСписка.Представление);
		КонецЦикла;
	ИначеЕсли Свойство = "ОграничениеТипа" Тогда
		Если Значение = Неопределено Тогда
			Элемент.ОграничениеТипа = Новый ОписаниеТипов("Неопределено");
		Иначе
			Элемент.ОграничениеТипа = Значение;
		КонецЕсли;
	ИначеЕсли Свойство = "ТекущийЭлемент" Тогда
		Форма.ТекущийЭлемент = Форма.Элементы[Значение];
	ИначеЕсли Свойство = "Свернута" Тогда
		Если Значение Тогда
			Элемент.Скрыть();
		Иначе
			Элемент.Показать();
		КонецЕсли;
	Иначе
		ОбщийКлиентСервер.УстановитьЗначение(Элемент[Свойство], Значение, Истина, Истина);
	КонецЕсли;
КонецПроцедуры

Процедура НастроитьЭлемент(Форма, Элемент, Свойства)
	Для Каждого ЭлементСвойства Из Свойства Цикл
		НастроитьСвойство(Форма, Элемент, ЭлементСвойства.Ключ, ЭлементСвойства.Значение);
	КонецЦикла;
КонецПроцедуры

Функция СоздатьСостояниеРасчета()
	Состояние = Новый Структура;
	Состояние.Вставить("ЭлементыФормы", Новый Массив);
	Состояние.Вставить("ЭлементыСвязей", Новый Массив);
	Состояние.Вставить("СвойстваЭлементов", Новый Массив);
	Состояние.Вставить("СловарьЭлементов", Новый Соответствие);
	Состояние.Вставить("Статус", Ложь);
	Возврат Состояние;
КонецФункции

Функция ОбновитьФорму(Контекст, РассчитанныеПараметры = Неопределено) Экспорт
	МодельОбъекта = РаботаСМодельюОбъектаКлиентСервер.ПолучитьМодель(Контекст);
	#Если Клиент Тогда
		РасчетВКонтекстеКлиента = Истина;
	#Иначе
		РасчетВКонтекстеКлиента = Ложь;
	#КонецЕсли
	
	//  Инициализация
	ИзмененныеПараметры = Новый Массив;
	Если ТипЗнч(РассчитанныеПараметры) = Тип("Структура") Тогда
		СостояниеРасчета = РассчитанныеПараметры;
	Иначе
		СостояниеРасчета = СоздатьСостояниеРасчета();
		Если РассчитанныеПараметры = Неопределено Тогда
			Для Каждого ЭлементПараметра Из МодельОбъекта.ПараметрыСостояния Цикл
				ИзмененныеПараметры.Добавить(ЭлементПараметра.Значение);
			КонецЦикла;
		ИначеЕсли ТипЗнч(РассчитанныеПараметры) = Тип("Строка") Тогда
			Для Каждого Параметр Из ОбщийКлиентСервер.Массив(РассчитанныеПараметры) Цикл
				ИзмененныеПараметры.Добавить(РаботаСМодельюОбъектаКлиентСервер.ПолучитьПараметрИзИдентификатора(МодельОбъекта, Параметр).Параметр);
			КонецЦикла;
		Иначе
			Для Каждого РасчетныйПараметр Из РассчитанныеПараметры Цикл
				ИзмененныеПараметры.Добавить(РасчетныйПараметр.Параметр);
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;
		
	ЭлементыФормы = СостояниеРасчета.ЭлементыФормы;
	СвойстваЭлементов = СостояниеРасчета.СвойстваЭлементов;
	ЭлементыСвязей = СостояниеРасчета.ЭлементыСвязей;				
	СловарьЭлементов = СостояниеРасчета.СловарьЭлементов;
	
	Для Каждого Параметр Из ИзмененныеПараметры Цикл
		Для Каждого ИдентификаторПараметраЭлемента Из Параметр.ЗависимыеЭлементы Цикл
			ПараметрЭлемента = МодельОбъекта.ПараметрыЭлементов[ИдентификаторПараметраЭлемента];
			Если ЗначениеЗаполнено(ПараметрЭлемента.Свойство) Тогда
				СвойстваЭлементов.Добавить(ПараметрЭлемента);
				Продолжить;
			КонецЕсли;
			ЭлементФормы = ПараметрЭлемента.Элемент;
			Если СловарьЭлементов[ЭлементФормы.Имя] = Истина Тогда
				Продолжить;
			КонецЕсли;
			Если РасчетВКонтекстеКлиента И НЕ ЭлементФормы.НаКлиенте Тогда
				РасчетВКонтекстеКлиента = Ложь;
			КонецЕсли;
			СловарьЭлементов[ЭлементФормы.Имя] = Истина;
			ЭлементыФормы.Добавить(ЭлементФормы);
		КонецЦикла;
		ОбщегоНазначенияКлиентСервер.ДополнитьМассив(ЭлементыСвязей, Параметр.ЭлементыСвязей, Истина);
	КонецЦикла;
	
	#Если Клиент Тогда
		Если НЕ РасчетВКонтекстеКлиента ИЛИ ЗначениеЗаполнено(ЭлементыСвязей) Тогда
			Возврат СостояниеРасчета;
		КонецЕсли;
	#КонецЕсли
	
	Форма = МодельОбъекта.Контекст;
	Элементы = Форма.Элементы;
	Для Каждого ПараметрСвойства Из СвойстваЭлементов Цикл
		ИмяЭлемента = ПараметрСвойства.Элемент.Имя;
		ИмяСвойства = ПараметрСвойства.Свойство;
		Если ИмяЭлемента = "ЭтаФорма" Тогда
			Элемент = Форма;
		Иначе
			Элемент = Элементы[ИмяЭлемента];
		КонецЕсли;
		ЗначениеПараметра = РаботаСМодельюОбъектаКлиентСервер.ПолучитьЗначениеПараметра(МодельОбъекта, ПараметрСвойства.Параметр);
		НастроитьСвойство(Форма, Элемент, ИмяСвойства, ЗначениеПараметра);
	КонецЦикла;
	
	Если ЗначениеЗаполнено(ЭлементыФормы) Тогда
		РаботаСМассивом.СортироватьПо(ЭлементыФормы, "Порядок");
		Для Каждого ЭлементФормы Из ЭлементыФормы Цикл
			Если НЕ ЗначениеЗаполнено(ЭлементФормы.ФункцияСостояния) Тогда
				Продолжить;
			КонецЕсли;
			Если ЭлементФормы.Имя = "ЭтаФорма" Тогда
				Элемент = Форма;
			Иначе
				Элемент = Элементы[ИмяЭлемента];
			КонецЕсли;
			Параметры = Новый Структура;
			Для Каждого ИдентификаторПараметраЭлемента Из ЭлементФормы.Параметры Цикл
				ПараметрЭлемента = МодельОбъекта.ПараметрыЭлементов[ИдентификаторПараметраЭлемента];
				ЗначениеПараметра = РаботаСМодельюОбъектаКлиентСервер.ПолучитьЗначениеПараметра(МодельОбъекта, ПараметрЭлемента.Параметр);
				ОбщийКлиентСервер.ДобавитьЗначениеВСтруктуруПараметров(Параметры, ЗначениеПараметра, ПараметрЭлемента.ПутьКДанным);
			КонецЦикла;
			Свойства = Новый Структура;
			Результат = Вычислить(ЭлементФормы.ФункцияСостояния);
			Если Результат = Ложь Тогда
				Продолжить;
			КонецЕсли;
			НастроитьЭлемент(Форма, Элемент, Свойства);
		КонецЦикла;
	КонецЕсли;

	#Если Сервер Тогда
		Для Каждого ИмяЭлемента Из ЭлементыСвязей Цикл
			ЭлементФормы = МодельОбъекта.ЭлементыФормы[ИмяЭлемента];
			РаботаСМодельюФормы.НастроитьПараметрыВыбораЭлементаФормы(МодельОбъекта, ЭлементФормы);
		КонецЦикла;
	#КонецЕсли
	
	СостояниеРасчета.Статус = Истина;
	Возврат СостояниеРасчета;	
КонецФункции

Функция ПолучитьРасчетныйПараметрЭлементаФормы(Контекст, ИмяЭлемента) Экспорт
	Перем ИдентификаторСтроки;
	МодельОбъекта = РаботаСМодельюОбъектаКлиентСервер.ПолучитьМодель(Контекст);
	ЭлементФормы = МодельОбъекта.ЭлементыФормы[ИмяЭлемента];
	Если ЭлементФормы = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	ПараметрСостояния = ЭлементФормы.Параметр;
	Если ЗначениеЗаполнено(ПараметрСостояния.ПараметрТаблица) Тогда
		ИдентификаторСтроки = РаботаСМодельюОбъектаКлиентСервер.ПолучитьТекущийИдентификаторСтроки(МодельОбъекта, ПараметрСостояния.ПараметрТаблица);
	КонецЕсли;
	Возврат РаботаСМодельюОбъектаКлиентСервер.СоздатьРасчетныйПараметр(МодельОбъекта, ПараметрСостояния, ИдентификаторСтроки);
КонецФункции
