/datum/edu/elementary
	name = "��������� �����������"
	desc = "����������� ��������� ����� ����������� � ���"
	degree = EDU_ELEMENTARY

	edu_points = 4
	extra_edu_points = 0

/datum/edu/secondary
	name = "������� �����������"
	desc = "����������� ������� ����� ����������� � ���"
	reqs = list(/datum/edu/elementary)
	degree = EDU_SECONDARY

	preset_skills = list(SKILL_COMPUTER = SKILL_BASIC, SKILL_SCIENCE = SKILL_BASIC, SKILL_COOKING = SKILL_BASIC)

	edu_points = 8
	extra_edu_points = 0

/datum/edu/space_course
	name = "����� ���������� ����������"
	desc = "�����, ���������������� ��������� � ������ � �������� �������"
	reqs = list(/datum/edu/secondary)

	profs = list(/datum/job/stowaway, /datum/job/merchant, /datum/job/assistant)

	preset_skills = list(SKILL_EVA = SKILL_BASIC)

	edu_points = 8
	extra_edu_points = 0
	min_age = list(SPECIES_HUMAN = 18)