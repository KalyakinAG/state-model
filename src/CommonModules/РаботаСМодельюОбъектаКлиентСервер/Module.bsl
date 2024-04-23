//@skip-check module-unused-local-variable
//@skip-check server-execution-safe-mode
#Область ПрограммныйИнтерфейс

Функция ПолучитьМодель(Контекст) Экспорт
	МодельОбъекта = Новый Структура;
	Если ТипЗнч(Контекст) = Тип("ФормаКлиентскогоПриложения") Тогда
		МодельОбъекта.Вставить("ПутьКДаннымОбъекта", Контекст.ПутьКДаннымОбъекта);
		МодельОбъекта.Вставить("ПараметрыСостояния", Контекст.ПараметрыСостояния);
		МодельОбъекта.Вставить("ЗначенияПараметров", Контекст.ЗначенияПараметров);
		МодельОбъекта.Вставить("Связи", Контекст.Связи);
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
	МодельОбъекта.Вставить("Связи", ДополнительныеСвойства.Связи);
	МодельОбъекта.Вставить("Контекст", Контекст);
	МодельОбъекта.Вставить("Объект", Контекст);
	МодельОбъекта.Вставить("Модуль", ДополнительныеСвойства.МодульМодели);
	МодельОбъекта.Вставить("ЭтоКонтекстФормы", Ложь);
	Возврат МодельОбъекта;
КонецФункции

Функция СоздатьРасчетныйПараметр(МодельОбъекта, Параметр, Знач ИдентификаторСтроки = Неопределено) Экспорт
	Если ЗначениеЗаполнено(Параметр.ПараметрТаблица) Тогда
		Если ИдентификаторСтроки = Неопределено Тогда
			ИдентификаторСтроки = ПолучитьЗначениеПараметра(МодельОбъекта, Параметр.ПараметрТаблица.ПараметрТекущаяСтрока);
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
		Возврат СоздатьРасчетныйПараметр(МодельОбъекта, МодельОбъекта.ПараметрыСостояния[Идентификатор]);
	Иначе
		Возврат СоздатьРасчетныйПараметр(МодельОбъекта, МодельОбъекта.ПараметрыСостояния[Состав[0]], Число(Состав[1]));
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
	ПутьКДаннымОбъекта = Лев(ПутьКДанным, СтрНайти(ПутьКДанным, ".", НаправлениеПоиска.СКонца)-1);
	Если ЗначениеЗаполнено(ПутьКДаннымОбъекта) Тогда
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
			Если МодельОбъекта.ЭтоКонтекстФормы Тогда
				Возврат ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Контекст, ПутьКДаннымТаблицы).НайтиПоИдентификатору(РасчетныйПараметр.ИдентификаторСтроки);
			Иначе
				Возврат ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Контекст, ПутьКДаннымТаблицы)[РасчетныйПараметр.ИдентификаторСтроки];
			КонецЕсли;
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

//@skip-check module-unused-local-variable
Функция ПолучитьЗначение(МодельОбъекта, РасчетныйПараметр) Экспорт
	Перем ИмяРеквизита;// Данная Переменная Определяется В Функции ПолучитьРеквизитФормыПоПути
	Перем Значение, СтандартнаяОбработка, Отказ;
	Контекст = МодельОбъекта.Контекст;
	Если РасчетныйПараметр.Параметр.Вычисляемый Тогда
		//@skip-check module-unused-local-variable
		Параметры = ПолучитьВходящиеПараметры(МодельОбъекта, РасчетныйПараметр);
		Попытка
			Значение = Вычислить(РасчетныйПараметр.Параметр.Выражение);
		Исключение
			ВызватьИсключение СтрШаблон("Ошибка вычисления параметра %1: %2", РасчетныйПараметр.Параметр.Имя, РасчетныйПараметр.Параметр.Выражение);
		КонецПопытки;
		Возврат Значение;
	КонецЕсли;
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

Функция УстановитьЗначение(МодельОбъекта, РасчетныйПараметр, Значение) Экспорт
	Перем ИмяРеквизита;// Данная Переменная Определяется В Функции ПолучитьРеквизитФормыПоПути
	Возврат УстановитьЗначениеПоСсылке(ОбъектПараметра(МодельОбъекта, РасчетныйПараметр, ИмяРеквизита)[ИмяРеквизита], Значение, РасчетныйПараметр);
КонецФункции

Функция УстановитьЗначениеПараметра(МодельОбъекта, Параметр, Значение, ИдентификаторСтроки = Неопределено) Экспорт
	Возврат УстановитьЗначение(МодельОбъекта, Новый Структура("Параметр, ИдентификаторСтроки", Параметр, ИдентификаторСтроки), Значение);
КонецФункции

Функция ПолучитьЗависимыеПараметры(МодельОбъекта, РасчетныйПараметр) Экспорт
	ЗависимыеПараметры = Новый Массив;
	Для Каждого ИдентификаторСвязи Из РасчетныйПараметр.Параметр.ИсходящиеСвязи Цикл
		Зависимость = МодельОбъекта.Связи[ИдентификаторСвязи];
		ПараметрСостояния = Зависимость.ПараметрСостояния;
		Если ЗначениеЗаполнено(ПараметрСостояния.ПараметрТаблица) Тогда
			//  Это Элементы Коллекции
			ПараметрТаблица = ПараметрСостояния.ПараметрТаблица;
			Таблица = ПолучитьЗначениеПараметра(МодельОбъекта, ПараметрТаблица);
			Если ЗначениеЗаполнено(ПараметрТаблица.ПараметрОтборСтрок) Тогда
				ОтборСтрок = ПолучитьЗначениеПараметра(МодельОбъекта, ПараметрТаблица.ПараметрОтборСтрок);
				НайденныеСтроки = Таблица.НайтиСтроки(ОтборСтрок);
				Если МодельОбъекта.ЭтоКонтекстФормы Тогда
					Для Каждого СтрокаТаблицы Из НайденныеСтроки Цикл
						ИдентификаторСтроки = СтрокаТаблицы.ПолучитьИдентификатор();
						ЗависимыеПараметры.Добавить(СоздатьРасчетныйПараметр(МодельОбъекта, ПараметрСостояния, ИдентификаторСтроки));
					КонецЦикла;
				Иначе
					Для Каждого СтрокаТаблицы Из НайденныеСтроки Цикл
						ИдентификаторСтроки = Таблица.Индекс(СтрокаТаблицы);
						ЗависимыеПараметры.Добавить(СоздатьРасчетныйПараметр(МодельОбъекта, ПараметрСостояния, ИдентификаторСтроки));
					КонецЦикла;
				КонецЕсли;
			ИначеЕсли ЗначениеЗаполнено(РасчетныйПараметр.Параметр.ПараметрТаблица) И РасчетныйПараметр.Параметр.ПараметрТаблица.Имя = ПараметрСостояния.ПараметрТаблица.Имя Тогда
				ЗависимыеПараметры.Добавить(СоздатьРасчетныйПараметр(МодельОбъекта, ПараметрСостояния, РасчетныйПараметр.ИдентификаторСтроки));
			Иначе
				Если МодельОбъекта.ЭтоКонтекстФормы Тогда
					Для Каждого ЭлементКоллекции Из Таблица Цикл
						ЗависимыеПараметры.Добавить(СоздатьРасчетныйПараметр(МодельОбъекта, ПараметрСостояния, ЭлементКоллекции.ПолучитьИдентификатор()));
					КонецЦикла;
				Иначе
					Для ИдентификаторСтроки = 0 По Таблица.Количество() - 1 Цикл
						ЗависимыеПараметры.Добавить(СоздатьРасчетныйПараметр(МодельОбъекта, ПараметрСостояния, ИдентификаторСтроки));
					КонецЦикла;
				КонецЕсли;
			КонецЕсли;
		Иначе
			ЗависимыеПараметры.Добавить(СоздатьРасчетныйПараметр(МодельОбъекта, ПараметрСостояния));					
		КонецЕсли;
	КонецЦикла;
	Возврат ЗависимыеПараметры;
КонецФункции

Функция ЗначениеСвойстваПараметра(МодельОбъекта, Параметр, ИдентификаторСтроки = Неопределено, ИмяСвойства) Экспорт
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

Процедура РассчитатьПараметрыКонтекста(МодельОбъекта) Экспорт
	РасчетныеПараметры = Новый Массив;
	Для Каждого ЭлементПараметра Из МодельОбъекта.ПараметрыСостояния Цикл
		ПараметрСостояния = ЭлементПараметра.Значение;
		Если НЕ ПараметрСостояния.Контекстный ИЛИ ПараметрСостояния.Вычисляемый Тогда
			Продолжить;
		КонецЕсли;
		Если ЗначениеЗаполнено(ПараметрСостояния.ПараметрТаблица) Тогда
			Таблица = ПолучитьЗначениеПараметра(МодельОбъекта, ПараметрСостояния.ПараметрТаблица);
			#Если Клиент Тогда
				Если Строка(Таблица) = "ДанныеФормыДерево" Тогда
					
				Иначе  
					Для Каждого ЭлементСтроки Из Таблица Цикл
						ИдентификаторСтроки = ?(МодельОбъекта.ЭтоКонтекстФормы, ЭлементСтроки.ПолучитьИдентификатор(), Таблица.Индекс(ЭлементСтроки));
						РасчетныйПараметр = СоздатьРасчетныйПараметр(МодельОбъекта, ПараметрСостояния, ИдентификаторСтроки);
						РасчетныеПараметры.Добавить(РасчетныйПараметр);
					КонецЦикла;
				КонецЕсли;
			#Иначе
				Если ТипЗнч(Таблица) = Тип("ДеревоЗначений") ИЛИ ТипЗнч(Таблица) = Тип("ДанныеФормыДерево") Тогда
					
				Иначе  
					Для Каждого ЭлементСтроки Из Таблица Цикл
						ИдентификаторСтроки = ?(МодельОбъекта.ЭтоКонтекстФормы, ЭлементСтроки.ПолучитьИдентификатор(), Таблица.Индекс(ЭлементСтроки));
						РасчетныйПараметр = СоздатьРасчетныйПараметр(МодельОбъекта, ПараметрСостояния, ИдентификаторСтроки);
						РасчетныеПараметры.Добавить(РасчетныйПараметр);
					КонецЦикла;
				КонецЕсли;
			#КонецЕсли
				
			Продолжить;
		КонецЕсли;
		РасчетныйПараметр = СоздатьРасчетныйПараметр(МодельОбъекта, ПараметрСостояния);
		РасчетныеПараметры.Добавить(РасчетныйПараметр);
	КонецЦикла;
	Если НЕ ЗначениеЗаполнено(РасчетныеПараметры) Тогда
		Возврат;
	КонецЕсли;
	РаботаСМассивом.Сортировать(РасчетныеПараметры, "Сравнить(А.Параметр.Порядок, Б.Параметр.Порядок)");
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
			//  Проверка значения
			Если РасчетныйПараметр.Параметр.ПроверкаЗначения Тогда
				ПараметрыСПустымЗначением = Неопределено;
				Параметры = ПолучитьВходящиеПараметры(МодельОбъекта, РасчетныйПараметр, ПараметрыСПустымЗначением);
				ИмяРеквизита = Неопределено;//  Используется для получения псевдонима ссылки
				Если ОбработчикЗаполнения(МодельОбъекта, РасчетныйПараметр, ОбъектПараметра(МодельОбъекта, РасчетныйПараметр, ИмяРеквизита)[ИмяРеквизита], Параметры) Тогда
					ИзмененныеПараметры.Добавить(РасчетныйПараметр);
					Продолжить;
				КонецЕсли;
			КонецЕсли;
			//
			Если ПризнакИспользования(МодельОбъекта, РасчетныйПараметр) Тогда
				ОбработчикПриИзменении(МодельОбъекта, РасчетныйПараметр, ИзмененныеПараметры);
			КонецЕсли;
		ИначеЕсли ПризнакИспользования(МодельОбъекта, РасчетныйПараметр) Тогда
			Если РасчетныйПараметр.Параметр.Вычисляемый Тогда
				ИзмененныеПараметры.Добавить(РасчетныйПараметр);
			Иначе
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
			КонецЕсли;
		Иначе // параметр не используется, очистка значения
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

Процедура ПриИзмененииПараметра(МодельОбъекта, РасчетныйПараметрИлиИмя, ИдентификаторСтроки = Неопределено, ИзмененныеПараметры) Экспорт
	Если ИзмененныеПараметры = Неопределено Тогда
		ИзмененныеПараметры = Новый Массив;
	КонецЕсли;
	Если ТипЗнч(РасчетныйПараметрИлиИмя) = Тип("Строка") Тогда
		ПараметрСостояния = МодельОбъекта.ПараметрыСостояния[РасчетныйПараметрИлиИмя];
		Если ПараметрСостояния = Неопределено Тогда
			Возврат;
		КонецЕсли;
		РасчетныйПараметр = СоздатьРасчетныйПараметр(МодельОбъекта, ПараметрСостояния, ИдентификаторСтроки);
	Иначе
		РасчетныйПараметр = РасчетныйПараметрИлиИмя;
	КонецЕсли;
	ИзмененныеПараметры.Добавить(РасчетныйПараметр);
КонецПроцедуры

Функция Заполнить(Контекст, Шаблон) Экспорт
	Перем ИзмененныеПараметры;
	Перем ИдентификаторСтроки;
	ИзмененныеПараметры = Новый Массив;
	МодельОбъекта = ПолучитьМодель(Контекст);
	ЭтоКонтекстФормы = МодельОбъекта.ЭтоКонтекстФормы;
	Для Каждого ЭлементШаблона Из Шаблон Цикл
		Параметр = МодельОбъекта.ПараметрыСостояния[ЭлементШаблона.Ключ];
		Если НЕ ЗначениеЗаполнено(Параметр) Тогда
			ВызватьИсключение СтрШаблон("Параметр %1 неопределен", ЭлементШаблона.Ключ);
		КонецЕсли;
		Если Параметр.ЭтоТаблица Тогда
			Если НЕ ЗначениеЗаполнено(ЭлементШаблона.Значение) Тогда
				Продолжить;
			КонецЕсли;
			ЭтоПерваяСтрока = Истина;
			РежимЗаполнения = Ложь;
			Таблица = ПолучитьЗначениеПараметра(МодельОбъекта, Параметр);
			Для Каждого ЭлементСтроки Из ЭлементШаблона.Значение Цикл
				ЭлементСтроки.Свойство("ИдентификаторСтроки", ИдентификаторСтроки);
				Если ЭтоПерваяСтрока Тогда
					ЭтоПерваяСтрока = Ложь;
					Если ИдентификаторСтроки = Неопределено Тогда
						РежимЗаполнения = Истина;
						Таблица.Очистить();						
					КонецЕсли;
				КонецЕсли;
				Если РежимЗаполнения Тогда
					ЭлементСтрокиТаблицы = Таблица.Добавить();
					ИдентификаторСтроки = ?(ЭтоКонтекстФормы, ЭлементСтрокиТаблицы.ПолучитьИдентификатор(), Таблица.Индекс(ЭлементСтрокиТаблицы));
				Иначе  
					ЭлементСтрокиТаблицы = ?(ЭтоКонтекстФормы, Таблица.НайтиПоИдентификатору(ИдентификаторСтроки), Таблица[ИдентификаторСтроки]);
				КонецЕсли;
				Для Каждого ЭлементПоля Из ЭлементСтроки Цикл
					Если ЭлементПоля.Ключ = "ИдентификаторСтроки" Тогда
						Продолжить;
					КонецЕсли;
					Если НЕ ОбщийКлиентСервер.УстановитьЗначение(ЭлементСтрокиТаблицы[ЭлементПоля.Ключ], ЭлементПоля.Значение) Тогда
						Продолжить;
					КонецЕсли;
					ИмяПараметра = ЭлементШаблона.Ключ + "." + ЭлементПоля.Ключ;
					ПриИзмененииПараметра(МодельОбъекта, ИмяПараметра, ИдентификаторСтроки, ИзмененныеПараметры);
				КонецЦикла;
			КонецЦикла;
		Иначе
			Если УстановитьЗначениеПараметра(МодельОбъекта, Параметр, ЭлементШаблона.Значение, ИзмененныеПараметры) Тогда
				ПриИзмененииПараметра(МодельОбъекта, ЭлементШаблона.Ключ, , ИзмененныеПараметры);
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	Возврат ИзмененныеПараметры;
КонецФункции

Процедура ЗаполнитьИРассчитать(ЭтотОбъект, Шаблон) Экспорт
	ИзмененныеПараметры = Заполнить(ЭтотОбъект, Шаблон);
	Рассчитать(ЭтотОбъект, ИзмененныеПараметры);
КонецПроцедуры

Функция ПолучитьТекущийИдентификаторСтроки(МодельОбъекта, ПараметрТаблица) Экспорт
	Таблица = ПолучитьЗначениеПараметра(МодельОбъекта, ПараметрТаблица);
	ТекущаяСтрока = ПолучитьЗначениеПараметра(МодельОбъекта, ПараметрТаблица.ПараметрТекущаяСтрока);
	Если ТекущаяСтрока = Неопределено Тогда
		ВызватьИсключение СтрШаблон("Для Таблицы %1 Не Определена Текущая Строка %2", ПараметрТаблица.Имя, ПараметрТаблица.ПараметрТекущаяСтрока.Имя);
	КонецЕсли;
	Возврат Таблица.Индекс(Таблица.НайтиПоИдентификатору(ТекущаяСтрока));
КонецФункции

Функция ПризнакИспользованияПараметра(МодельОбъекта, Параметр, ИдентификаторСтроки = Неопределено) Экспорт
	Возврат ЗначениеСвойстваПараметра(МодельОбъекта, Параметр, ИдентификаторСтроки, "Использование");
КонецФункции

#КонецОбласти

//@skip-check server-execution-safe-mode
#Область СлужебныеПроцедурыИФункции

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

Функция ПолучитьВходящиеПараметры(МодельОбъекта, РасчетныйПараметр, ПараметрыСПустымЗначением = Неопределено)
	Перем ИдентификаторСтроки;
	ПараметрыСПустымЗначением = Новый Массив;
	ПараметрыВыбора = Новый Структура;
	ПараметрСостояния = РасчетныйПараметр.Параметр;
	РасчетныйПараметр.Свойство("ИдентификаторСтроки", ИдентификаторСтроки);
	Для Каждого ИдентификаторСвязи Из ПараметрСостояния.ВходящиеСвязи Цикл
		Связь = МодельОбъекта.Связи[ИдентификаторСвязи];
		Если НЕ ЗначениеЗаполнено(Связь.ПутьКДанным) Тогда
			Продолжить;
		КонецЕсли;   
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
	Контекст = МодельОбъекта.Контекст;
	СтандартнаяОбработка = Истина;
	Значение = СсылкаНаЗначение;
	ПараметрСостояния = РасчетныйПараметр.Параметр;
	Отказ = Ложь;
	Если ЗначениеЗаполнено(ПараметрСостояния.Выражение) Тогда
		СтандартнаяОбработка = Ложь;
		Попытка
			Значение = Вычислить(ПараметрСостояния.Выражение);
		Исключение
			ВызватьИсключение "Ошибка расчета параметра " + РасчетныйПараметр.Идентификатор + Символы.ПС + ОписаниеОшибки();
		КонецПопытки
	КонецЕсли;
	Если Отказ Тогда
		Возврат Ложь;
	КонецЕсли;
#Если Сервер Тогда		
	Если СтандартнаяОбработка И ОбщегоНазначения.ЭтоСсылка(ТипЗнч(СсылкаНаЗначение)) Тогда
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

//@skip-check module-unused-local-variable
Функция ОбработчикПриИзменении(МодельОбъекта, РасчетныйПараметр, ИзмененныеПараметры)
	Контекст = МодельОбъекта.Контекст;
	ПараметрСостояния = РасчетныйПараметр.Параметр;
	ОбработчикПриИзменении = ПараметрСостояния.ОбработчикПриИзменении;
	Если НЕ ЗначениеЗаполнено(ОбработчикПриИзменении) Тогда
		Возврат Неопределено;
	КонецЕсли;
	Возврат Вычислить(ОбработчикПриИзменении);
КонецФункции

Функция УстановитьПустоеЗначение(МодельОбъекта, РасчетныйПараметр, СсылкаНаЗначение)
	Если ТипЗнч(СсылкаНаЗначение) = Тип("ДанныеФормыКоллекция") Тогда
		СсылкаНаЗначение.Очистить();
		Возврат Истина;
	КонецЕсли;
	Если ТипЗнч(СсылкаНаЗначение) = Тип("ТаблицаЗначений") Тогда
		СсылкаНаЗначение.Очистить();
		Возврат Истина;
	КонецЕсли;
	ОбщийКлиентСервер.УстановитьЗначение(СсылкаНаЗначение, Неопределено);
	Возврат НЕ ЗначениеЗаполнено(СсылкаНаЗначение);
КонецФункции

Функция СоздатьСостояниеРасчета() Экспорт
	Состояние = Новый Структура;
	Состояние.Вставить("Очередь", Новый Массив);
	Состояние.Вставить("СловарьПараметрыВОчереди", Новый Соответствие);
	Состояние.Вставить("СловарьРассчитанныеПараметры", Новый Соответствие);
	Состояние.Вставить("РассчитанныеПараметры", Новый Массив);
	Состояние.Вставить("Статус", Ложь);
	Возврат Состояние;
КонецФункции

Функция ДобавитьПараметрВОчередь(СостояниеРасчета, РасчетныйПараметр) Экспорт
	СловарьПараметрыВОчереди = СостояниеРасчета.СловарьПараметрыВОчереди;
	Если СловарьПараметрыВОчереди[РасчетныйПараметр.Идентификатор] = Истина Тогда
		Возврат Ложь;
	КонецЕсли;
	СловарьПараметрыВОчереди[РасчетныйПараметр.Идентификатор] = Истина;
	РаботаСМассивом.ПоложитьВОчередьСПриоритетом(СостояниеРасчета.Очередь, РасчетныйПараметр, "Сравнить(Б.Параметр.Порядок, А.Параметр.Порядок)");
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

#КонецОбласти
