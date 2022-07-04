Функция ПолучитьМодель(Контекст) Экспорт
	МодельОбъекта = Новый Структура;
	Если ТипЗнч(Контекст) = Тип("ФормаКлиентскогоПриложения") Тогда
		МодельОбъекта.Вставить("ПутьКДаннымОбъекта", Контекст.ПутьКДаннымОбъекта);
		МодельОбъекта.Вставить("ПараметрыСостояния", Контекст.ПараметрыСостояния);
		МодельОбъекта.Вставить("ЗначенияПараметров", Контекст.ЗначенияПараметров);
		МодельОбъекта.Вставить("СвязиПараметров", Контекст.СвязиПараметров);
		МодельОбъекта.Вставить("Контекст", Контекст);
		МодельОбъекта.Вставить("Объект", Контекст[Контекст.ПутьКДаннымОбъекта]);
		МодельОбъекта.Вставить("Модуль", Контекст.МодульМодели);
		МодельОбъекта.Вставить("ЭлементыФормы", Контекст.ЭлементыФормы);
		МодельОбъекта.Вставить("ПараметрыЭлементов", Контекст.ПараметрыЭлементов);
		МодельОбъекта.Вставить("ЭтоКонтекстФормы", Истина);
		Возврат МодельОбъекта;
	КонецЕсли;
	ДополнительныеСвойства = Контекст.ДополнительныеСвойства;
	МодельОбъекта.Вставить("ПутьКДаннымОбъекта", "");
	МодельОбъекта.Вставить("ПараметрыСостояния", ДополнительныеСвойства.ПараметрыСостояния);
	МодельОбъекта.Вставить("ЗначенияПараметров", ДополнительныеСвойства.ЗначенияПараметров);
	МодельОбъекта.Вставить("СвязиПараметров", ДополнительныеСвойства.СвязиПараметров);
	МодельОбъекта.Вставить("Контекст", Контекст);
	МодельОбъекта.Вставить("Объект", Контекст);
	МодельОбъекта.Вставить("Модуль", ДополнительныеСвойства.МодульМодели);
	МодельОбъекта.Вставить("ЭтоКонтекстФормы", Ложь);
	Возврат МодельОбъекта;
КонецФункции

Функция СоздатьРасчетныйПараметр(МодельОбъекта, Параметр, Знач ИдентификаторСтроки = Неопределено) Экспорт
	Если ЗначениеЗаполнено(Параметр.ПараметрТаблица) Тогда
		Если ИдентификаторСтроки = Неопределено Тогда
			ИдентификаторСтроки = ПолучитьТекущийИдентификаторСтроки(МодельОбъекта, Параметр.ПараметрТаблица);
		КонецЕсли;
		Идентификатор = СтрШаблон("%1[%2]", Параметр.Имя, ИдентификаторСтроки);
	Иначе
		Идентификатор = Параметр.Имя;
	КонецЕсли;
	Возврат Новый Структура("Параметр, ИдентификаторСтроки, Идентификатор", Параметр, ИдентификаторСтроки, Идентификатор);
КонецФункции

// ПолучитьПараметрИзИдентификатора
// 
// Параметры:
//  МодельОбъекта - Структура
//  Идентификатор - Строка - Идентификатор Расчетного Параметра. Реквизит Шапки: Параметр, Реквизит Строки Таблицы: Параметр[ИдентификаторСтроки]
// 
// Возвращаемое Значение:
//  Структура - Получить Параметр Из Идентификатора:
// * Параметр - Строка -
// * ИдентификаторСтроки - Неопределено, Число -
// * Идентификатор - Строка -
Функция ПолучитьПараметрИзИдентификатора(МодельОбъекта, Идентификатор) Экспорт
	Состав = СтрРазделить(Идентификатор, "[]");
	Если Состав.ВГраница() = 0 Тогда
		Возврат СоздатьРасчетныйПараметр(МодельОбъекта, Идентификатор);
	Иначе
		Возврат СоздатьРасчетныйПараметр(МодельОбъекта, Состав[0], Состав[1]);
	КонецЕсли;
КонецФункции

Функция ПутьКДанным(МодельОбъекта, Параметр) Экспорт
	Если НЕ Параметр.Контекстный Тогда
		Возврат ?(МодельОбъекта.ПутьКДаннымОбъекта = "", "", МодельОбъекта.ПутьКДаннымОбъекта + ".") + Параметр.ПутьКДанным;
	Иначе
		Возврат Параметр.ПутьКДанным;
	КонецЕсли;
КонецФункции

// Аналог ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути, Отличие В Том, Что Здесь Выделяется
// Исходящая Переменная ИмяРеквизита. Это Необходимо Для Получения Ссылки На Значение.
// 
// Параметры:
//  Контекст - ОбъектМетаданных
//  ПутьКДанным - Строка -Путь К Данным
//  ИмяРеквизита - Строка - Имя Реквизита
// 
// Возвращаемое Значение:
//  Произвольный - Получить Реквизит По Пути
Функция ПолучитьРеквизитПоПути(Контекст, ПутьКДанным, ИмяРеквизита = "") Экспорт
	ПутьКДаннымОбъекта = Лев(путьКДанным, СтрНайти(путьКДанным, ".", НаправлениеПоиска.СКонца)-1);
	Если ЗначениеЗаполнено(путьКДаннымОбъекта) Тогда
		ИмяРеквизита = ОбщийКлиентСервер.ОкончаниеСтрокиПослеРазделителя(путьКДанным);
		Возврат ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Контекст, ПутьКДаннымОбъекта);
	Иначе
		ИмяРеквизита = ПутьКДанным;
		Возврат Контекст;
	КонецЕсли;
КонецФункции

Функция ОбъектПараметра(МодельОбъекта, РасчетныйПараметр, ИмяРеквизита = "") Экспорт
	Перем ИдентификаторСтроки;
	ПараметрСостояния = РасчетныйПараметр.Параметр;
	Если ЗначениеЗаполнено(ПараметрСостояния.ПутьКДанным) Тогда
		Контекст = МодельОбъекта.Контекст;
		Если ЗначениеЗаполнено(ПараметрСостояния.ПараметрТаблица) Тогда
			Если НЕ РасчетныйПараметр.Свойство("ИдентификаторСтроки", ИдентификаторСтроки) Тогда
				ВызватьИсключение "Не Определен Индекс Строки";
			КонецЕсли;
			ПутьКДаннымТаблицы = ПутьКДанным(МодельОбъекта, ПараметрСостояния.ПараметрТаблица);
			ИмяРеквизита = ОбщийКлиентСервер.ОкончаниеСтрокиПослеРазделителя(ПараметрСостояния.ПутьКДанным);
			Возврат ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Контекст, ПутьКДаннымТаблицы)[РасчетныйПараметр.ИдентификаторСтроки];
		Иначе
			Возврат ПолучитьРеквизитПоПути(Контекст, ПутьКДанным(МодельОбъекта, РасчетныйПараметр.Параметр), ИмяРеквизита);
		КонецЕсли;
	Иначе//  Это Виртуальный Параметр
		Если ЗначениеЗаполнено(ПараметрСостояния.ПараметрТаблица) Тогда
			ВызватьИсключение СтрШаблон("Не Определено Значение Параметра %1. Табличные Виртуальные Параметры Не Поддерживаются!", ПараметрСостояния.Имя);
		Иначе //@skip-warning
			ИмяРеквизита = "значение";
			Возврат МодельОбъекта.ЗначенияПараметров[ПараметрСостояния.ИндексЗначения];
		КонецЕсли;	
	КонецЕсли;
КонецФункции

Функция ПолучитьЗначение(МодельОбъекта, РасчетныйПараметр) Экспорт
	Перем ИмяРеквизита;// Данная Переменная Определяется В Функции ПолучитьРеквизитФормыПоПути
	Возврат ОбъектПараметра(МодельОбъекта, РасчетныйПараметр, ИмяРеквизита)[ИмяРеквизита];
КонецФункции

Функция ПолучитьЗначениеПараметра(МодельОбъекта, Параметр, ИдентификаторСтроки = Неопределено) Экспорт
	Если ЗначениеЗаполнено(Параметр.ПараметрТаблица) Тогда
		Если ИдентификаторСтроки = Неопределено Тогда
			ВызватьИсключение СтрШаблон("Не Определен Индекс Строки Для Значения Параметра %1", Параметр.Имя);
		КонецЕсли;
		Возврат ПолучитьЗначение(МодельОбъекта, Новый Структура("Параметр, ИдентификаторСтроки", Параметр, ИдентификаторСтроки));
	Иначе
		Возврат ПолучитьЗначение(МодельОбъекта, Новый Структура("Параметр", Параметр));
	КонецЕсли;
КонецФункции

Функция УстановитьЗначениеПоСсылке(СсылкаНаЗначение, Значение, РасчетныйПараметр = Неопределено)
	ИсходноеЗначение = СсылкаНаЗначение;
	Если ОбщийКлиентСервер.УстановитьЗначение(СсылкаНаЗначение, Значение, Истина, Истина) Тогда
		Если РасчетныйПараметр <> Неопределено Тогда
			РасчетныйПараметр.Вставить("ИсходноеЗначение", ИсходноеЗначение);
			РасчетныйПараметр.Вставить("Значение", Значение);
		КонецЕсли;
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;
КонецФункции

Функция УстановитьЗначение(МодельОбъекта, РасчетныйПараметр, Значение) Экспорт
	Перем ИмяРеквизита;// Данная Переменная Определяется В Функции ПолучитьРеквизитФормыПоПути
	Возврат УстановитьЗначениеПоСсылке(ОбъектПараметра(МодельОбъекта, РасчетныйПараметр, ИмяРеквизита)[ИмяРеквизита], Значение, РасчетныйПараметр);
КонецФункции

Функция УстановитьЗначениеПараметра(МодельОбъекта, Параметр, Значение, ИдентификаторСтроки = Неопределено) Экспорт
	Возврат УстановитьЗначение(МодельОбъекта, Новый Структура("Параметр, ИдентификаторСтроки", Параметр, ИдентификаторСтроки), Значение);
КонецФункции

Функция ПолучитьЗависимыеПараметры(МодельОбъекта, РасчетныйПараметр) Экспорт
	ЗависимыеПараметры = Новый Массив;
	Для Каждого ИдентификаторСвязи Из РасчетныйПараметр.Параметр.ЗависимыеПараметры Цикл
		Связь = МодельОбъекта.СвязиПараметров[ИдентификаторСвязи];
		ПараметрСостояния = Связь.ПараметрСостояния;
		Если ЗначениеЗаполнено(ПараметрСостояния.ПараметрТаблица) Тогда
			//  Это Элементы Коллекции
			ПараметрТаблица = ПараметрСостояния.ПараметрТаблица;
			Таблица = ПолучитьЗначениеПараметра(МодельОбъекта, ПараметрТаблица);
			Если ЗначениеЗаполнено(ПараметрТаблица.ПараметрОтборСтрок) Тогда
				ОтборСтрок = ПолучитьЗначениеПараметра(МодельОбъекта, ПараметрТаблица.ПараметрОтборСтрок);
				НайденныеСтроки = Таблица.НайтиСтроки(отборСтрок);
				Для Каждого СтрокаТаблицы Из НайденныеСтроки Цикл
					ИдентификаторСтроки = Таблица.Индекс(строкаТаблицы);
					ЗависимыеПараметры.Добавить(СоздатьРасчетныйПараметр(МодельОбъекта, ПараметрСостояния, ИдентификаторСтроки));
				КонецЦикла;
			Иначе
				Для ИдентификаторСтроки = 0 По Таблица.Количество() - 1 Цикл
					ЗависимыеПараметры.Добавить(СоздатьРасчетныйПараметр(МодельОбъекта, ПараметрСостояния, ИдентификаторСтроки));					
				КонецЦикла;
			КонецЕсли;
		Иначе
			ЗависимыеПараметры.Добавить(СоздатьРасчетныйПараметр(МодельОбъекта, ПараметрСостояния));					
		КонецЕсли;
	КонецЦикла;
	Возврат ЗависимыеПараметры;
КонецФункции

Функция ПолучитьТекущийИдентификаторСтроки(МодельОбъекта, ПараметрТаблица) Экспорт
	Таблица = РаботаСМодельюОбъектаКлиентСервер.ПолучитьЗначениеПараметра(МодельОбъекта, ПараметрТаблица);
	ТекущаяСтрока = РаботаСМодельюОбъектаКлиентСервер.ПолучитьЗначениеПараметра(МодельОбъекта, ПараметрТаблица.ПараметрТекущаяСтрока);
	Если ТекущаяСтрока = Неопределено Тогда
		ВызватьИсключение СтрШаблон("Для Таблицы %1 Не Определена Текущая Строка %2", ПараметрТаблица.Имя, ПараметрТаблица.ПараметрТекущаяСтрока.Имя);
	КонецЕсли;
	Возврат Таблица.Индекс(Таблица.НайтиПоИдентификатору(ТекущаяСтрока));
КонецФункции

//@skip-check module-unused-method
Функция ПолучитьВходящиеПараметры(МодельОбъекта, РасчетныйПараметр, ПараметрыСПустымЗначением)
	ПараметрыСПустымЗначением = Новый Массив;
	ПараметрыВыбора = Новый Структура;
	ПараметрСостояния = РасчетныйПараметр.Параметр;
	ИдентификаторСтроки = РасчетныйПараметр.ИдентификаторСтроки;
	Для Каждого ИдентификаторСвязи Из ПараметрСостояния.Параметры Цикл
		Связь = МодельОбъекта.СвязиПараметров[ИдентификаторСвязи];
		ИспользованиеСвязи = НЕ ЗначениеЗаполнено(Связь.ПараметрИспользование) ИЛИ ПризнакИспользованияПараметра(МодельОбъекта, Связь.ПараметрИспользование, ИдентификаторСтроки);
		Если НЕ ИспользованиеСвязи Тогда
			Продолжить;
		КонецЕсли;   
		Параметр = Связь.Параметр;
		Если ЗначениеЗаполнено(Связь.ПараметрИспользование) И НЕ ПолучитьЗначениеПараметра(МодельОбъекта, Связь.ПараметрИспользование) Тогда
			Продолжить;
		КонецЕсли;
		Если НЕ ЗначениеЗаполнено(Параметр) Тогда
			ЗначениеПараметра = Связь.Значение;
		ИначеЕсли НЕ ПризнакИспользованияПараметра(МодельОбъекта, Параметр, ИдентификаторСтроки) Тогда
			Продолжить;
		Иначе
			ЗначениеПараметра = ПолучитьЗначениеПараметра(МодельОбъекта, Связь.Параметр, ИдентификаторСтроки);
			Если НЕ ЗначениеЗаполнено(ЗначениеПараметра) И ЗначениеСвойстваПараметра(МодельОбъекта, Связь.Параметр, ИдентификаторСтроки, "ПроверкаЗаполнения")
				И (Связь.ПроверкаЗаполнения = Неопределено ИЛИ Связь.ПроверкаЗаполнения) Тогда
				ПараметрыСПустымЗначением.Добавить(СоздатьРасчетныйПараметр(МодельОбъекта, Параметр, ИдентификаторСтроки));
			КонецЕсли;
		КонецЕсли;
		ОбщийКлиентСервер.ДобавитьЗначениеВСтруктуруПараметров(ПараметрыВыбора, ЗначениеПараметра, Связь.ПутьКДанным);
	КонецЦикла;
	Возврат ПараметрыВыбора;
КонецФункции

#Если Сервер Тогда
Функция ПолучитьЗначениеСсылочногоТипа(СсылкаНаЗначение, Параметры, ЗаполнятьПоУмолчанию, Отказ)
	Возврат РаботаСМодельюОбъекта.ПолучитьЗначениеСсылочногоТипа(СсылкаНаЗначение, Параметры, ЗаполнятьПоУмолчанию, Отказ);
КонецФункции
#КонецЕсли

Функция ОбработчикЗаполнения(МодельОбъекта, РасчетныйПараметр, СсылкаНаЗначение, Параметры)
	Значение = СсылкаНаЗначение;
	ПараметрСостояния = РасчетныйПараметр.Параметр;
	Отказ = Ложь;
#Если Клиент Тогда		
	Если ЗначениеЗаполнено(ПараметрСостояния.Выражение) Тогда
		Значение = Вычислить(ПараметрСостояния.Выражение);
	КонецЕсли;
#Иначе		
	Если ЗначениеЗаполнено(ПараметрСостояния.Выражение) Тогда
		Значение = Вычислить(ПараметрСостояния.Выражение);
	ИначеЕсли ОбщегоНазначения.ЭтоСсылка(ТипЗнч(СсылкаНаЗначение)) Тогда
		ЗаполнятьПоУмолчанию = ЗначениеСвойства(МодельОбъекта, РасчетныйПараметр, "ЗаполнениеПоУмолчанию"); 
		Значение = ПолучитьЗначениеСсылочногоТипа(СсылкаНаЗначение, Параметры, ЗаполнятьПоУмолчанию, Отказ); 
	КонецЕсли;
#КонецЕсли
	Если Отказ Тогда
		Возврат Ложь;
	КонецЕсли;
	РасчетныйПараметр.Вставить("ИсходноеЗначение", СсылкаНаЗначение);
	РасчетныйПараметр.Вставить("Значение", Значение);
	Возврат ОбщийКлиентСервер.УстановитьЗначение(СсылкаНаЗначение, Значение, Истина, Истина);
КонецФункции

Функция ОбработчикПриИзменении(МодельОбъекта, РасчетныйПараметр, ИзмененныеПараметры)
	ПараметрСостояния = РасчетныйПараметр.Параметр;
	ОбработчикПриИзменении = ПараметрСостояния.ОбработчикПриИзменении;
	Если НЕ ЗначениеЗаполнено(ОбработчикПриИзменении) Тогда
		Возврат Неопределено;
	КонецЕсли;
	Возврат Вычислить(ОбработчикПриИзменении);
КонецФункции

Функция ЗначениеСвойстваПараметра(МодельОбъекта, Параметр, ИдентификаторСтроки, ИмяСвойства) Экспорт
	ПараметрСвойства = Параметр["Параметр" + ИмяСвойства];
	Если ЗначениеЗаполнено(ПараметрСвойства) Тогда
		Возврат ПолучитьЗначениеПараметра(МодельОбъекта, ПараметрСвойства, ИдентификаторСтроки);
	КонецЕсли;
	Если ИмяСвойства = "Использование" Тогда
		Возврат Истина;
	КонецЕсли;
	Возврат Параметр[ИмяСвойства];
КонецФункции

Функция ЗначениеСвойства(МодельОбъекта, РасчетныйПараметр, ИмяСвойства) Экспорт
	Возврат ЗначениеСвойстваПараметра(МодельОбъекта, РасчетныйПараметр.Параметр, РасчетныйПараметр.ИдентификаторСтроки, ИмяСвойства) ;
КонецФункции

Функция ПризнакИспользования(МодельОбъекта, РасчетныйПараметр) Экспорт
	Возврат ЗначениеСвойства(МодельОбъекта, РасчетныйПараметр, "Использование");
КонецФункции

Функция ПризнакИспользованияПараметра(МодельОбъекта, Параметр, ИдентификаторСтроки = Неопределено) Экспорт
	Возврат ЗначениеСвойстваПараметра(МодельОбъекта, Параметр, ИдентификаторСтроки, "Использование");
КонецФункции

Функция УстановитьПустоеЗначение(МодельОбъекта, РасчетныйПараметр, СсылкаНаЗначение)
	ОбщийКлиентСервер.УстановитьЗначение(СсылкаНаЗначение, Неопределено);
	Возврат НЕ ЗначениеЗаполнено(СсылкаНаЗначение);
КонецФункции

Функция СоздатьСостояниеРасчета()
	Состояние = Новый Структура;
	Состояние.Вставить("Очередь", Новый Массив);
	Состояние.Вставить("СловарьПараметрыВОчереди", Новый Соответствие);
	Состояние.Вставить("СловарьРассчитанныеПараметры", Новый Соответствие);
	Состояние.Вставить("РассчитанныеПараметры", Новый Массив);
	Состояние.Вставить("Статус", Ложь);
	Возврат Состояние;
КонецФункции

Функция ДобавитьПараметрВОчередь(СостояниеРасчета, РасчетныйПараметр)
	СловарьПараметрыВОчереди = СостояниеРасчета.СловарьПараметрыВОчереди;
	Если СловарьПараметрыВОчереди[РасчетныйПараметр.Идентификатор] = Истина Тогда
		Возврат Ложь;
	КонецЕсли;
	СловарьПараметрыВОчереди[РасчетныйПараметр.Идентификатор] = Истина;
	РаботаСМассивом.ПоложитьВОчередьСПриоритетом(СостояниеРасчета.Очередь, РасчетныйПараметр, "Сравнить(А.Параметр.Порядок, Б.Параметр.Порядок)");
	Возврат Истина;	
КонецФункции

Процедура ДобавитьПараметрВРассчитанные(СостояниеРасчета, РасчетныйПараметр)
	СостояниеРасчета.СловарьРассчитанныеПараметры[РасчетныйПараметр.Идентификатор] = Истина;
	СостояниеРасчета.РассчитанныеПараметры.Добавить(РасчетныйПараметр); 	
КонецПроцедуры

Процедура УдалитьПараметрИзРассчитанных(СостояниеРасчета, РасчетныйПараметр)
	СостояниеРасчета.СловарьРассчитанныеПараметры[РасчетныйПараметр.Идентификатор] = Неопределено;
КонецПроцедуры

Функция ПараметрРассчитан(СостояниеРасчета, РасчетныйПараметр)
	Возврат СостояниеРасчета.СловарьРассчитанныеПараметры[РасчетныйПараметр.Идентификатор] = Истина;
КонецФункции

Процедура ОчиститьЗначение(МодельОбъекта, РасчетныйПараметр)
	Тип = РасчетныйПараметр.Параметр.Тип;
	Если Тип = Неопределено Тогда
		УстановитьЗначение(МодельОбъекта, РасчетныйПараметр, Неопределено);
		Возврат;
	КонецЕсли;
	УстановитьЗначение(МодельОбъекта, РасчетныйПараметр, Тип.ПривестиЗначение(Неопределено));	
КонецПроцедуры

Процедура РассчитатьПараметрыКонтекста(МодельОбъекта) Экспорт
	РасчетныеПараметры = Новый Массив;
	Для Каждого ЭлементПараметра Из МодельОбъекта.ПараметрыСостояния Цикл
		ПараметрСостояния = ЭлементПараметра.Значение;
		Если НЕ ПараметрСостояния.Контекстный Тогда
			Продолжить;
		КонецЕсли;
		РасчетныйПараметр = СоздатьРасчетныйПараметр(МодельОбъекта, ПараметрСостояния);
		РасчетныеПараметры.Добавить(РасчетныйПараметр);
	КонецЦикла;
	РаботаСМассивом.Сортировать(РасчетныеПараметры, "Сравнить(Б.Параметр.Порядок, А.Параметр.Порядок)");
	Для Каждого РасчетныйПараметр Из РасчетныеПараметры Цикл 
		ПараметрыСПустымЗначением = Неопределено;
		Параметры = ПолучитьВходящиеПараметры(МодельОбъекта, РасчетныйПараметр, ПараметрыСПустымЗначением);
		Если ЗначениеЗаполнено(ПараметрыСПустымЗначением) Тогда
			ОчиститьЗначение(МодельОбъекта, РасчетныйПараметр);
			Продолжить;
		КонецЕсли;
		ИмяРеквизита = Неопределено;// Данная Переменная Определяется В Функции ПолучитьРеквизитФормыПоПути
		ОбработчикЗаполнения(МодельОбъекта, РасчетныйПараметр, ОбъектПараметра(МодельОбъекта, РасчетныйПараметр, ИмяРеквизита)[ИмяРеквизита], Параметры);
	КонецЦикла;
КонецПроцедуры

Функция Рассчитать(Контекст, ВходящиеПараметры = Неопределено, СостояниеРасчета = Неопределено) Экспорт
	МодельОбъекта = ПолучитьМодель(Контекст);
	//  Инициализация
	Если ЗначениеЗаполнено(СостояниеРасчета) Тогда
		ИзмененныеПараметры = Новый Массив;
	Иначе
		СостояниеРасчета = СоздатьСостояниеРасчета();
		Если ВходящиеПараметры = Неопределено Тогда
			ИзмененныеПараметры = Новый Массив;
			Для Каждого ЭлементПараметра Из МодельОбъекта.ПараметрыСостояния Цикл
				ПараметрСостояния = ЭлементПараметра.Значение;
				Если НЕ ПараметрСостояния.Контекстный ИЛИ ЗначениеЗаполнено(ПараметрСостояния.ПараметрТаблица) Тогда
					Продолжить;
				КонецЕсли;
				РасчетныйПараметр = СоздатьРасчетныйПараметр(МодельОбъекта, ПараметрСостояния);
				ДобавитьПараметрВОчередь(СостояниеРасчета, РасчетныйПараметр);				
			КонецЦикла;
		ИначеЕсли ТипЗнч(ВходящиеПараметры) = Тип("Строка") Тогда
			ИзмененныеПараметры = ОбщийКлиентСервер.Массив(ВходящиеПараметры);
		Иначе
			ИзмененныеПараметры = РаботаСМассивом.СкопироватьМассив(ВходящиеПараметры);
		КонецЕсли;
	КонецЕсли;
	Очередь = СостояниеРасчета.Очередь;
	//  Цикл расчета
	Пока ЗначениеЗаполнено(ИзмененныеПараметры) ИЛИ ЗначениеЗаполнено(Очередь) Цикл
		//  Формировании очереди
		Для Каждого Параметр Из ИзмененныеПараметры Цикл
			Если НЕ ЗначениеЗаполнено(Параметр) Тогда
				Продолжить;
			КонецЕсли;
			Если ТипЗнч(Параметр) = Тип("Строка") Тогда
				РасчетныйПараметр = ПолучитьПараметрИзИдентификатора(МодельОбъекта, Параметр);
			Иначе
				РасчетныйПараметр = Параметр;
			КонецЕсли;	
			ДобавитьПараметрВОчередь(СостояниеРасчета, РасчетныйПараметр);
			ДобавитьПараметрВРассчитанные(СостояниеРасчета, РасчетныйПараметр);
			ЗависимыеПараметры = ПолучитьЗависимыеПараметры(МодельОбъекта, РасчетныйПараметр);
			Для Каждого ЗависимыйПараметр Из ЗависимыеПараметры Цикл
				ДобавитьПараметрВОчередь(СостояниеРасчета, ЗависимыйПараметр);
				УдалитьПараметрИзРассчитанных(СостояниеРасчета, ЗависимыйПараметр);
			КонецЦикла;
		КонецЦикла;
		//  Расчет
		РасчетныйПараметр = РаботаСМассивом.Последний(Очередь);
		Если РасчетныйПараметр = Неопределено Тогда
			СостояниеРасчета.Статус = Истина;
			Возврат СостояниеРасчета;
		КонецЕсли;
		#Если Клиент Тогда
			Если НЕ РасчетныйПараметр.Параметр.НаКлиенте Тогда
				Возврат СостояниеРасчета;
			КонецЕсли;		
		#КонецЕсли
		ИзмененныеПараметры = Новый Массив;
		Если ПараметрРассчитан(СостояниеРасчета, РасчетныйПараметр) Тогда
			РаботаСМассивом.Взять(Очередь);
			Если ПризнакИспользования(МодельОбъекта, РасчетныйПараметр) Тогда
				ОбработчикПриИзменении(МодельОбъекта, РасчетныйПараметр, ИзмененныеПараметры);
			КонецЕсли;
		ИначеЕсли ПризнакИспользования(МодельОбъекта, РасчетныйПараметр) Тогда
			ПараметрыСПустымЗначением = Неопределено;
			Параметры = ПолучитьВходящиеПараметры(МодельОбъекта, РасчетныйПараметр, ПараметрыСПустымЗначением);
			Если ЗначениеЗаполнено(ПараметрыСПустымЗначением) Тогда
				РаботаСМассивом.Взять(Очередь);
				Продолжить;
			КонецЕсли;
			ИмяРеквизита = Неопределено;//  Используется для получения псевдонима ссылки
			Если ОбработчикЗаполнения(МодельОбъекта, РасчетныйПараметр, ОбъектПараметра(МодельОбъекта, РасчетныйПараметр, ИмяРеквизита)[ИмяРеквизита], Параметры) Тогда
				ИзмененныеПараметры.Добавить(РасчетныйПараметр);
			Иначе
				РаботаСМассивом.Взять(Очередь);
			КонецЕсли;
		Иначе
			РаботаСМассивом.Взять(Очередь);
			ИмяРеквизита = Неопределено;//  Используется для получения псевдонима ссылки
			Если УстановитьПустоеЗначение(МодельОбъекта, РасчетныйПараметр, ОбъектПараметра(МодельОбъекта, РасчетныйПараметр, ИмяРеквизита)[ИмяРеквизита]) Тогда
				ИзмененныеПараметры.Добавить(РасчетныйПараметр);
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	СостояниеРасчета.Статус = Истина;
	Возврат СостояниеРасчета;
КонецФункции

Процедура ПриИзмененииПараметра(МодельОбъекта, РасчетныйПараметрИлиИмя, ИдентификаторСтроки = Неопределено) Экспорт
	Перем ИзмененныеПараметры;
	Если НЕ МодельОбъекта.Свойство("ИзмененныеПараметры", ИзмененныеПараметры) Тогда
		ИзмененныеПараметры = Новый Массив;
		МодельОбъекта.Вставить("ИзмененныеПараметры", ИзмененныеПараметры);
	КонецЕсли;
	Если ТипЗнч(РасчетныйПараметрИлиИмя) = Тип("Строка") Тогда
		ПараметрСостояния = МодельОбъекта.ПараметрыСостояния[РасчетныйПараметрИлиИмя];
		Если ПараметрСостояния = Неопределено Тогда
			Возврат;
		КонецЕсли;
		РасчетныйПараметр = РаботаСМодельюОбъектаКлиентСервер.СоздатьРасчетныйПараметр(МодельОбъекта, ПараметрСостояния, ИдентификаторСтроки);
	Иначе
		РасчетныйПараметр = РасчетныйПараметрИлиИмя;
	КонецЕсли;
	ИзмененныеПараметры.Добавить(РасчетныйПараметр);
КонецПроцедуры
