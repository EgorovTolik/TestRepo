-- Скрипт сгенерирован Devart dbForge Studio for Oracle, Версия 3.1.190.1
-- Домашняя страница продукта: http://www.devart.com/ru/dbforge/oracle/studio
-- Дата скрипта: 26.05.2012 20:37:57
-- Версия сервера: Oracle Database 10g Express Edition Release 10.2.0.1.0 - Production
-- Версия клиента: 

SET SQLBLANKLINES ON;
SET DEFINE OFF;
ALTER SESSION SET NLS_DATE_FORMAT = 'MM/DD/SYYYY HH24:MI:SS';
ALTER SESSION SET NLS_TIMESTAMP_TZ_FORMAT = 'MM/DD/SYYYY HH24:MI:SS.FF TZH:TZM';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'MM/DD/SYYYY HH24:MI:SS.FF';
ALTER SESSION SET NLS_NUMERIC_CHARACTERS = '.,';
ALTER SESSION SET NLS_NCHAR_CONV_EXCP = FALSE;
ALTER SESSION SET TIME_ZONE = '+07:00';


INSERT INTO ROOT.CATEGORY(ID, NAME) VALUES
(205, 'Компьютерные журналы');
INSERT INTO ROOT.CATEGORY(ID, NAME) VALUES
(220, 'Большой Спорт');
INSERT INTO ROOT.CATEGORY(ID, NAME) VALUES
(230, 'Журналы для взрослых');
INSERT INTO ROOT.CATEGORY(ID, NAME) VALUES
(241, 'Игровые журналы');
INSERT INTO ROOT.CATEGORY(ID, NAME) VALUES
(250, 'Журналы о путешествиях');
INSERT INTO ROOT.CATEGORY(ID, NAME) VALUES
(275, 'Авто и мото журналы');
INSERT INTO ROOT.CATEGORY(ID, NAME) VALUES
(225, 'Женские журналы');