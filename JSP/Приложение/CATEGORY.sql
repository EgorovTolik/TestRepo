-- ������ ������������ Devart dbForge Studio for Oracle, ������ 3.1.190.1
-- �������� �������� ��������: http://www.devart.com/ru/dbforge/oracle/studio
-- ���� �������: 26.05.2012 20:37:57
-- ������ �������: Oracle Database 10g Express Edition Release 10.2.0.1.0 - Production
-- ������ �������: 

SET SQLBLANKLINES ON;
SET DEFINE OFF;
ALTER SESSION SET NLS_DATE_FORMAT = 'MM/DD/SYYYY HH24:MI:SS';
ALTER SESSION SET NLS_TIMESTAMP_TZ_FORMAT = 'MM/DD/SYYYY HH24:MI:SS.FF TZH:TZM';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'MM/DD/SYYYY HH24:MI:SS.FF';
ALTER SESSION SET NLS_NUMERIC_CHARACTERS = '.,';
ALTER SESSION SET NLS_NCHAR_CONV_EXCP = FALSE;
ALTER SESSION SET TIME_ZONE = '+07:00';


INSERT INTO ROOT.CATEGORY(ID, NAME) VALUES
(205, '������������ �������');
INSERT INTO ROOT.CATEGORY(ID, NAME) VALUES
(220, '������� �����');
INSERT INTO ROOT.CATEGORY(ID, NAME) VALUES
(230, '������� ��� ��������');
INSERT INTO ROOT.CATEGORY(ID, NAME) VALUES
(241, '������� �������');
INSERT INTO ROOT.CATEGORY(ID, NAME) VALUES
(250, '������� � ������������');
INSERT INTO ROOT.CATEGORY(ID, NAME) VALUES
(275, '���� � ���� �������');
INSERT INTO ROOT.CATEGORY(ID, NAME) VALUES
(225, '������� �������');