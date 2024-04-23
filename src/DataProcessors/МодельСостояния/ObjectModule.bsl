//@skip-check server-execution-safe-mode
//@skip-check object-module-export-variable

#Область ОписаниеПеременных

Перем Схема Экспорт;
Перем СтекСостояний;
Перем ПараметрСостояния Экспорт;
Перем Связь Экспорт;
Перем ЭлементФормы Экспорт;
Перем Свойство Экспорт;
Перем ПараметрЭлемента Экспорт;
Перем НаКлиентеПоУмолчанию;

#КонецОбласти

#Область ПрограммныйИнтерфейс

Функция ТипБулево() Экспорт
	ПараметрСостояния.Тип = Новый ОписаниеТипов(ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Тип("Булево")));
	ПараметрСостояния.ПроверкаЗаполнения = Ложь;
	Возврат ЭтотОбъект;
КонецФункции

Функция УстановитьСхему(Контекст, ПутьКДаннымОбъекта = "Объект", МодульМодели = "Контекст") Экспорт
	Схема = РаботаСМодельюСостояния.СхемаМодели(Контекст, ПутьКДаннымОбъекта, МодульМодели);
	Если МодульМодели = "Контекст" И ТипЗнч(Контекст) = Тип("ФормаКлиентскогоПриложения") Тогда
		НаКлиентеПоУмолчанию = Истина;
	Иначе		
		НаКлиентеПоУмолчанию = Ложь;
	КонецЕсли;
	Возврат ЭтотОбъект;
КонецФункции

Функция ПолучитьСхему() Экспорт
	Возврат Схема;	
КонецФункции

Функция ПроверкаЗначения(Значение = Истина) Экспорт
	ПараметрСостояния.ПроверкаЗначения = Значение;
	Возврат ЭтотОбъект;
КонецФункции

Функция НаКлиенте(Значение = Истина) Экспорт
	НаКлиентеПоУмолчанию = Значение;
	Если ЗначениеЗаполнено(ПараметрЭлемента) Тогда
		ПараметрЭлемента.Параметр.НаКлиенте = Значение;
		Возврат ЭтотОбъект;
	КонецЕсли;
	Если ЗначениеЗаполнено(ЭлементФормы) Тогда
		ЭлементФормы.НаКлиенте = Значение;
		Возврат ЭтотОбъект;
	КонецЕсли;
	ПараметрСостояния.НаКлиенте = Значение;
	Возврат ЭтотОбъект;
КонецФункции

Функция НаСервере(Значение = Истина) Экспорт
	Возврат НаКлиенте(НЕ Значение);
КонецФункции


// Начальное Состояние Описания. Далее Описываются Связанные Параметры. Описание Завершается Оператором Выражение:
// 	МодельСостояния.ПараметрСостояния()
// 		.Параметр()
// 		.Выражение()
// 	;
// 
// Параметры:
//  ПутьКДанным - Строка - Путь К Данным В Объекте
//  Имя - Строка - Имя Параметра
//  Контекстный - Булево
// 
// Возвращаемое Значение:
//  ОбработкаОбъект.МодельСостояния - Параметр Состояния
Функция ПараметрСостояния(ПутьКДанным = "", Имя = "", Контекстный = Неопределено) Экспорт
	СброситьСостояние();
	ПараметрСостояния = РаботаСМодельюСостояния.ПараметрСостояния(Схема, ПутьКДанным, Имя, Контекстный);
	ПараметрСостояния.НаКлиенте = НаКлиентеПоУмолчанию;
	Возврат ЭтотОбъект;
КонецФункции

Функция Слабая() Экспорт
	Связь.Слабая = Истина;
	Возврат ЭтотОбъект;
КонецФункции

Функция Ключ(Ключ) Экспорт
	ПараметрСостояния.Ключ = Ключ;
	Возврат ЭтотОбъект;
КонецФункции

// Создает Связь Параметра С Параметром Состояния, Со Свойством Параметра Состояния,
// С Элементом Формы, Со Свойством Элемента Формы.
// Связь С Параметром Состояния Или С Его Свойством Задается Рекурсивно Через Определение Параметра Состояния.
//	МодельСостояния.ПараметрСостояния()
//		.Параметр()
//			.Использование()
//				.Параметр()
//				.Выражение()
//		.Выражение()
//	; 
//	МодельСостояния.ЭлементФормы()
//		.Свойство("Видимость")
//			.Параметр()
//			.Выражение()
//		.Параметр()
//		.ФункцияСостояния()
//	; 
// Параметры:
//  ПутьКДанным - Строка - Путь К Данным Для Использования В Выражении
//  Имя - Строка - Имя Параметра
//  ПроверкаЗаполнения - Булево
// 
// Возвращаемое Значение:
//  ОбработкаОбъект.МодельСостояния
Функция Параметр(ПутьКДанным, Имя = "", ПроверкаЗаполнения = Неопределено) Экспорт
	ИмяПараметра = ОбщийКлиентСервер.ЕстьПустоеЗначение(Имя, ПутьКДанным);
	Параметр = РаботаСМодельюСостояния.ПараметрСостояния(Схема, ИмяПараметра);
	//Параметр.НаКлиенте = НаКлиентеПоУмолчанию;
	Если ЗначениеЗаполнено(ЭлементФормы) И НЕ ЗначениеЗаполнено(Свойство) Тогда
		ПараметрЭлемента = РаботаСМодельюСостояния.СоздатьПараметрЭлемента(Схема, ЭлементФормы, Параметр, , ПутьКДанным);
		Возврат ЭтотОбъект;
	КонецЕсли;
	Связь = РаботаСМодельюСостояния.СоздатьСвязь(Схема, ПараметрСостояния, Параметр, ПутьКДанным, , ПроверкаЗаполнения);
	Если ПроверкаЗаполнения = Неопределено Тогда
		Если (ЗначениеЗаполнено(ЭлементФормы) ИЛИ ЗначениеЗаполнено(Свойство)) Тогда
			Связь.ПроверкаЗаполнения = Ложь;
		Иначе
			Связь.ПроверкаЗаполнения = ПараметрСостояния.ПроверкаЗаполнения;
		КонецЕсли;
	КонецЕсли;
	Возврат ЭтотОбъект;
КонецФункции

// Оператор Выражение Завершает Описание Параметра Состояния, Свойства Параметра Состояния, Свойста Элемента.
// Все Эти Параметры Определяются Параметром Состояния Текущего Стека Состояния.
// 
// Параметры:
//  ТекстВыражения - Строка - Текст Выражения
//  НаКлиенте - Булево -
// 
// Возвращаемое Значение:
//  ОбработкаОбъект.МодельСостояния - Выражение
Функция Выражение(ТекстВыражения = "*") Экспорт
	Если ТекстВыражения = "*" Тогда
		ПараметрСостояния.Выражение = СтрШаблон("%1.ЗначениеПараметра%2(Параметры, Значение, СтандартнаяОбработка, Отказ)", Схема.Модуль, СтрЗаменить(ПараметрСостояния.Имя, ".", ""));
	Иначе
		ПараметрСостояния.Выражение = СтрЗаменить(ТекстВыражения, "'", """");
	КонецЕсли;
	ВосстановитьСостояние();
	Возврат ЭтотОбъект;
КонецФункции

Функция ПриИзменении(СтрокаВызоваФункции = "*") Экспорт
	Если СтрокаВызоваФункции = "*" Тогда
		ПараметрСостояния.ОбработчикПриИзменении = СтрШаблон("%1.ПриИзмененииПараметра%2(МодельОбъекта, РасчетныйПараметр, ИзмененныеПараметры)", Схема.Модуль, СтрЗаменить(ПараметрСостояния.Имя, ".", ""));
	Иначе
		ПараметрСостояния.ОбработчикПриИзменении = СтрЗаменить(СтрокаВызоваФункции, "'", """");
	КонецЕсли; 
	Возврат ЭтотОбъект;
КонецФункции

Функция ПараметрПризнака(ИмяПризнака, ИмяПараметра = "") Экспорт
	Перем ПараметрЗадан;
	ИмяПараметраСвойства = ?(ЗначениеЗаполнено(ИмяПараметра), ИмяПараметра, ОбщийКлиентСервер.ИмяПоУникальномуИдентификатору());
	ПараметрИспользование = Схема.ПараметрыСостояния[ИмяПараметраСвойства];
	Если ЗначениеЗаполнено(ПараметрИспользование) Тогда
		ПараметрЗадан = Истина;
	Иначе
		ПараметрЗадан = Ложь;
		ПараметрИспользование = РаботаСМодельюСостояния.ПараметрСостояния(Схема, ИмяПараметраСвойства, , , "Булево");
		ПараметрИспользование.НаКлиенте = НаКлиентеПоУмолчанию;
	КонецЕсли;
	Если ЗначениеЗаполнено(Связь) Тогда
		//  Параметр применяется к связи
		Связь.ПараметрИспользование = ПараметрИспользование;
		Если ПараметрИспользование.ИсходящиеСвязи.Найти(Связь.Идентификатор) = Неопределено Тогда
			ПараметрИспользование.ИсходящиеСвязи.Добавить(Связь.Идентификатор);
		КонецЕсли;
		ОбщегоНазначенияКлиентСервер.ДополнитьМассив(ПараметрИспользование.ЭлементыСвязей, Связь.ПараметрСостояния.Элементы, Истина);
		//  Переключение на настройку вложенного параметра
		Если ПараметрЗадан Тогда
			Возврат ЭтотОбъект;
		КонецЕсли;			
		СохранитьСостояние();
		ПараметрСостояния = ПараметрИспользование;
		Возврат ЭтотОбъект;
	КонецЕсли;
	Если ЗначениеЗаполнено(ПараметрЭлемента) Тогда
		//  Параметр применяется к параметру к элементу формы
		ПараметрЭлемента.ПараметрИспользование = ПараметрИспользование;
		РаботаСМодельюСостояния.СоздатьСвязь(Схема, ПараметрЭлемента.Параметр, ПараметрИспользование, ИмяПризнака);// Фиктивная связь с параметром признака Использование
		ОбщегоНазначенияКлиентСервер.ДополнитьМассив(ПараметрИспользование.ЭлементыСвязей, ПараметрЭлемента.Параметр.Элементы, Истина);
		//  Переключение на настройку вложенного параметра
		Если ПараметрЗадан Тогда
			Возврат ЭтотОбъект;
		КонецЕсли;			
		СохранитьСостояние();
		ПараметрСостояния = ПараметрИспользование;
		Возврат ЭтотОбъект;
	КонецЕсли;
	//  Параметр применяется к параметру, возможно рекурсивно (ЭлементФормы-ПараметрЭлемента-ПараметрИспользование)
	ПараметрИспользование.ПараметрТаблица = ПараметрСостояния.ПараметрТаблица;
	Если ЗначениеЗаполнено(ПараметрИспользование.ПараметрТаблица) И НЕ ЗначениеЗаполнено(ПараметрИспользование.ПутьКДанным) Тогда
		ПараметрИспользование.Вычисляемый = Истина;
	КонецЕсли;
	ПараметрСостояния.ПараметрИспользование = ПараметрИспользование;
	РаботаСМодельюСостояния.СоздатьСвязь(Схема, ПараметрСостояния, ПараметрИспользование);// Фиктивная связь с параметром признака Использование
	ОбщегоНазначенияКлиентСервер.ДополнитьМассив(ПараметрИспользование.ЭлементыСвязей, ПараметрСостояния.Элементы, Истина);
	//  Переключение на настройку вложенного параметра
	Если ПараметрЗадан Тогда
		Возврат ЭтотОбъект;
	КонецЕсли;			
	СохранитьСостояние();
	ПараметрСостояния = ПараметрИспользование;
	Возврат ЭтотОбъект;
КонецФункции

Функция Использование(ИмяПараметра = "") Экспорт
	ПараметрПризнака("Использование", ИмяПараметра);
	Возврат ЭтотОбъект;
КонецФункции

Функция НеИспользование(ИмяПараметра) Экспорт
	Использование();
	Параметр(ИмяПараметра);
	Выражение(СтрШаблон("НЕ Параметры.%1", ИмяПараметра));
	Возврат ЭтотОбъект;
КонецФункции

Функция ПроверкаЗаполнения(ИмяПараметраИлиЗначение = "") Экспорт
	Если ТипЗнч(ИмяПараметраИлиЗначение) = Тип("Булево") Тогда
		Если ЗначениеЗаполнено(Связь) Тогда
			Связь.ПроверкаЗаполнения = ИмяПараметраИлиЗначение;
			Возврат ЭтотОбъект;
		КонецЕсли;	
		ПараметрСостояния.ПроверкаЗаполнения = ИмяПараметраИлиЗначение;
		Возврат ЭтотОбъект;
	КонецЕсли;		
	ПараметрПризнака("ПроверкаЗаполнения", ИмяПараметраИлиЗначение);
	Возврат ЭтотОбъект;
КонецФункции

Функция НеПроверкаЗаполнения(ИмяПараметра) Экспорт
	ПроверкаЗаполнения();
	Параметр(ИмяПараметра);
	Выражение(СтрШаблон("НЕ Параметры.%1", ИмяПараметра));
	Возврат ЭтотОбъект;
КонецФункции
	
Функция ТекущаяСтрока(Знач ИмяПараметра = "") Экспорт
	Если НЕ ЗначениеЗаполнено(ЭлементФормы) Тогда
		ВызватьИсключение "Не выбран элемент формы для определения параметра  ТекущаяСтрока";
	КонецЕсли;
	Если ИмяПараметра = "" Тогда
		ИмяПараметра = ЭлементФормы.Имя + ".ТекущаяСтрока";
	КонецЕсли;
	ПараметрТекущаяСтрока = Схема.ПараметрыСостояния[ИмяПараметра];
	Если ЗначениеЗаполнено(ПараметрТекущаяСтрока) Тогда
		ЭлементФормы.ПараметрТекущаяСтрока = ПараметрТекущаяСтрока;
	Иначе
		ЭлементФормы.ПараметрТекущаяСтрока = РаботаСМодельюСостояния.ПараметрСостояния(Схема, , ИмяПараметра);
		ЭлементФормы.ПараметрТекущаяСтрока.НаКлиенте = НаКлиентеПоУмолчанию;
	КонецЕсли;
	Возврат ЭтотОбъект;
КонецФункции

Функция ЭлементФормы(ЭлементИлиИмя = "ЭтаФорма") Экспорт
	СброситьСостояние();
	ЭлементФормы = РаботаСМодельюСостояния.ЭлементФормы(Схема, ЭлементИлиИмя); 
	Возврат ЭтотОбъект;
КонецФункции

Функция ФункцияСостояния(СтрокаВызоваФункции = "*") Экспорт
	Если СтрокаВызоваФункции = "*" Тогда
		ЭлементФормы.ФункцияСостояния = СтрШаблон("%1.СвойстваЭлемента%2(Свойства, Параметры)", Схема.Модуль, ЭлементФормы.Имя);
	Иначе
		ЭлементФормы.ФункцияСостояния = СтрЗаменить(СтрокаВызоваФункции, "'", """");
	КонецЕсли;
	ВосстановитьСостояние();
	Возврат ЭтотОбъект;
КонецФункции

// Свойство Элемента Формы, Определяемое Значением Параметра. ИмяПараметраСвойства Свойства Описывается Рекурсивно Как
// ИмяПараметраСвойства Состояния: Определяются Связанные Параметры, Свойства Связей, Выражение. 
//	МодельСостояния.ЭлементФормы()
//		.Свойство("Видимость")
//		...
// 
// Параметры:
//  ИмяСвойства - Строка - Имя Свойства
//  ИмяПараметра - Строка - Имя Параметра
// 
// Возвращаемое Значение:
//  ОбработкаОбъект.МодельСостояния - Свойство
Функция Свойство(ИмяСвойства, ИмяПараметра = "") Экспорт
	Если НЕ ЗначениеЗаполнено(ИмяПараметра) Тогда
		ИмяПараметра = СтрШаблон("%1%2", ЭлементФормы.Имя, ИмяСвойства);
	КонецЕсли;
	СохранитьСостояние("ЭлементФормы");
	Свойство = ИмяСвойства;
	Если ИмяСвойства = "Заголовок" Тогда
		Вычисляемый = Ложь;
	Иначе
		Вычисляемый = Истина;
	КонецЕсли;
	ПараметрСостояния = РаботаСМодельюСостояния.ПараметрСостояния(Схема, ИмяПараметра, , , , Вычисляемый);
	ПараметрСостояния.НаКлиенте = ЭлементФормы.НаКлиенте;
	ПараметрСостояния.ПроверкаЗаполнения = Ложь;
	ПараметрЭлемента = РаботаСМодельюСостояния.СоздатьПараметрЭлемента(Схема, ЭлементФормы, ПараметрСостояния, ИмяСвойства);
	Возврат ЭтотОбъект;
КонецФункции

Функция ОбработчикИнициализацииДанных() Экспорт
	Схема.ОбработчикИнициализацииДанных = СтрШаблон("%1.ИнициализироватьДанные(Схема)", Схема.Модуль);
	Возврат ЭтотОбъект;
КонецФункции

Процедура ПрименитьМодельОбъекта(Схема) Экспорт
	Контекст = Схема.Контекст;
	Если ЗначениеЗаполнено(Схема.ОбработчикИнициализацииДанных) Тогда
		Выполнить(Схема.ОбработчикИнициализацииДанных);
	КонецЕсли;
	//РаботаСМодельюСостояния.ОпределитьТопографическийПорядок(Схема);
	РаботаСМассивом.ОпределитьТопографическийПорядок(Схема.ПараметрыСостояния, "Имя", "ВходящиеСвязи", "Порядок", Схема.Связи, "Параметр");
	РаботаСМодельюОбъектаКлиентСервер.РассчитатьПараметрыКонтекста(Схема);
	РаботаСМодельюСостояния.ПрименитьМодельОбъекта(Схема);
КонецПроцедуры

Процедура ПрименитьМодель() Экспорт
	Контекст = Схема.Контекст;
	Если ТипЗнч(Контекст) = Тип("ФормаКлиентскогоПриложения") Тогда
		РаботаСМодельюСостояния.ДобавитьЭлементыФормы(Схема);//  Здесь будут добавлены параметры из элементов формы
		ПрименитьМодельОбъекта(Схема);
		//@skip-check empty-except-statement
		РаботаСМодельюФормы.НастроитьПараметрыВыбора(Схема);
		Попытка
			РаботаСМодельюСостояния.УстановитьДействие(Контекст, "ПриЧтенииНаСервере", "ПриЧтенииВМоделиФормыНаСервере");
			РаботаСМодельюСостояния.УстановитьДействие(Контекст, "ПослеЗаписиНаСервере", "ПослеЗаписиВМоделиФормыНаСервере");
		Исключение
		КонецПопытки;
	Иначе
		ПрименитьМодельОбъекта(Схема);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция СоздатьСостояние(Состояние = Неопределено, СписокСвойств = Неопределено)
	//@skip-check structure-consructor-too-many-keys
	НовоеСостояние = Новый Структура("ПараметрСостояния, Связь, ЭлементФормы, Свойство, ПараметрЭлемента");
	Если Состояние <> Неопределено Тогда
		ЗаполнитьЗначенияСвойств(НовоеСостояние, Состояние, СписокСвойств);
	КонецЕсли;
	Возврат НовоеСостояние;
КонецФункции

Процедура СохранитьСостояние(НаследуемыеСвойства = "")
	ТекущееСостояние = СоздатьСостояние(ЭтотОбъект);
	РаботаСМассивом.Положить(СтекСостояний, ТекущееСостояние);
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, СоздатьСостояние(ЭтотОбъект, НаследуемыеСвойства));
КонецПроцедуры

Процедура ВосстановитьСостояние()
	Состояние = РаботаСМассивом.Взять(СтекСостояний);
	Если Состояние = Неопределено Тогда
		//ЗаполнитьЗначенияСвойств(ЭтотОбъект, СоздатьСостояние());
		Возврат;
	КонецЕсли;
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, Состояние);
КонецПроцедуры

Процедура СброситьСостояние()
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, СоздатьСостояние());
КонецПроцедуры

#КонецОбласти

#Область Инициализация

СтекСостояний = Новый Массив;
НаКлиентеПоУмолчанию = Ложь;
СброситьСостояние();

#КонецОбласти

