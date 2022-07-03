// Применить модель к контексту
// 
// Параметры:
//  Контекст - ОбъектМетаданных
Процедура ПрименитьМодель(Контекст) Экспорт
	Модель = РаботаСМодельюОбъектаКлиентСервер.ПолучитьМодель(Контекст);
	РаботаСМодельюОбъектаКлиентСервер.ОпределитьПорядокПараметров(Модель);
	РаботаСМодельюОбъектаКлиентСервер.Рассчитать(Модель);
	Если ТипЗнч(Контекст) = Тип("ФормаКлиентскогоПриложения") Тогда
		РаботаСМодельюФормы.НастроитьПараметрыВыбора(Контекст);
		РаботаСМодельюФормыКлиентСервер.ОбновитьФорму(Контекст);
	КонецЕсли;
КонецПроцедуры

Функция ПолучитьЗначениеСсылочногоТипа(СсылкаНаЗначение, Параметры, ЗаполнятьПоУмолчанию, Отказ) Экспорт
	Перем Значение;
	Если Параметры.Свойство("Ссылка", Значение) Тогда
		Возврат Значение;
	КонецЕсли;
	Запрос = Новый Запрос;
	ТекстЗапроса = РаботаСДаннымиВыбора.НастроитьЗапросОбработкиПолученияДанныхВыбора(Запрос, СсылкаНаЗначение.Метаданные().ПолноеИмя(),, Параметры, 1);
	СхемаЗапроса = Новый СхемаЗапроса;
	//  Проверка соответствия значения структуре параметров
	Значение = СсылкаНаЗначение;
	Если ЗначениеЗаполнено(СсылкаНаЗначение) Тогда
		СхемаЗапроса.УстановитьТекстЗапроса(ТекстЗапроса);
		ОператорВыбрать = СхемаЗапроса.ПакетЗапросов[СхемаЗапроса.ПакетЗапросов.Количество()-1].Операторы[0];
		ОператорВыбрать.Отбор.Добавить("Источник.Ссылка = &ТекущееЗначение");
		Запрос.Текст = СхемаЗапроса.ПолучитьТекстЗапроса();
		Запрос.УстановитьПараметр("ТекущееЗначение", Значение);
		Если Запрос.Выполнить().Пустой() Тогда
			Значение = Новый (ТипЗнч(Значение));
		КонецЕсли;
	КонецЕсли;
	//  Заполнение пустого или сброшенного значения однозначным значением
	Если ЗаполнятьПоУмолчанию И НЕ ЗначениеЗаполнено(Значение) Тогда
		СхемаЗапроса.УстановитьТекстЗапроса(ТекстЗапроса);
		ОператорВыбрать = СхемаЗапроса.ПакетЗапросов[СхемаЗапроса.ПакетЗапросов.Количество()-1].Операторы[0];
		ОператорВыбрать.КоличествоПолучаемыхЗаписей = 2;
		Запрос.Текст = СхемаЗапроса.ПолучитьТекстЗапроса();
		Выборка = Запрос.Выполнить().Выбрать();
		Если Выборка.Количество() = 1 Тогда
			Выборка.Следующий();
			Значение = Выборка.Ссылка;
		КонецЕсли;
	КонецЕсли;
	Возврат Значение;
КонецФункции
