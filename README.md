# Проект "Терминал"

## Цель проекта в разработке терминала с возможностью работы с текстовой информацией.

Терминал должен иметь внешне монолитную структуру из одного блока к которому по ВГА должен подключаться монитор, по ПС\2 - клавиатура, ПоверДжек - питание. Обязательно наличие ПЗУ.

В софтовой части необходим компилятор, ассемблер и несколько программ

## Состав разработчиков:

* Darkness (тг @Letmeto) Идея проекта / Верилог код

## Список частей проекта "Терминал".

1. Универсальное ядро Э32А2 + контроллер памяти
2. Поддержка ввода текста через ПС\2 клавиатуру
3. Вывод видеоизображения 640*480 через ВГА (определить битность выхода)
4. ПЗУ ввиде SD карты (есть под рукой) / SATA диск?
5. Внешнее ОЗУ?
6. Вывод на пищалку (подумать над аудио)
7. Ассемблер
8. ЯСУ (Язык среднего уровня)
9. РТОС
10. Простенькая юарт отладка?
