/datum/edu_set
	var/name = "blank"
	var/desc = "��������������� �����"
	var/list/basic = list()
	var/list/datum/edu/extra = list()

/datum/edu_set/standart
	name = "����������� ��������������� �����"
	desc = "��������������� ����� � 12 �������� ������ ����������� �� ���������� ������������ ����������� ���� + ����� �� ������ � �������"

	basic = list(/datum/edu/elementary, /datum/edu/secondary)
	extra = list(/datum/edu/space_course)