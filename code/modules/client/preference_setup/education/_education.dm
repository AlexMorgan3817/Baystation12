// ��������� ������� - ������ �����������
#define EDU_ELEMENTARY		"��������� �����������"
#define EDU_SECONDARY		"��������� �����������"

// ��������� ������� - ���������������� �����������
#define EDU_VOCATIONAL		"���������������� �����������"

// ��������� ������� - ������� ������� ����������������� �����������
#define EDU_BACHELOR		"��������"
#define EDU_MASTER			"�������"
#define EDU_DOCTOR			"������"
#define EDU_HAB_DOCTOR		"���������������� ������"

// ���� - ������ �����������
#define EDU_PRIMARY			"��������� �����������"
#define EDU_COMMON 			"����� �����������"
#define EDU_MEDIUM 			"������� ����� �����������"

// ���� - ���������������� �����������
#define EDU_COMMON_PROF		"��������� ���������������� �����������"
#define EDU_MEDIUM_PROF		"������� ���������������� �����������"

// ���� - ������� ������� ����������������� �����������
#define EDU_SPECIALIST		"����������"
#define EDU_CANDIDATE		"�������� ����"
#define EDU_DOCTOR_F		"������ ����"

/datum/education
	var/name = "education"
	var/list/datum/edu/basic = list()
	var/list/datum/edu/extra = list()

	// ���� �����������. ���� ��� �����������
	var/edu_points = 25
	var/extra_edu_points = 25

	// ���������� ������������ ��������.
	var/edu_point = 0
	var/extra_edu_poing = 0

/datum/edu
	var/name = "blank"
	var/desc = "������ �����������"
	var/full_desc = ""

	var/edu_points = 0
	var/extra_edu_points = 0

	var/list/min_age = list(SPECIES_HUMAN = 7)		// ����������� ������� ��������

	var/list/profs = list()							// ����������� ���������
	var/list/preset_skills = list()					// ������������� ������

	var/list/datum/edu/prev = list()				// ����������� ���������� ��������� �����������. ����� ������ �� ��� ����� ������� ���.
	var/list/datum/edu/reqs = list()				// ����������� ��������� �����������. ��� ����� ���.
	var/degree										// ���������� ������� �����������. ��� ��������� �����.
	var/qualification								// ������������. ��� ����.

/datum/edu/proc/compatible(var/datum/education/target)
	var/tmp/list/overall = target.basic | target.extra

	if(!overall.len)
		return 0

	for(var/temp in prev)
		if(overall.Find(temp))
			return 1

	for(var/temp in reqs)
		if(!overall.Find(temp))
			return 0

	return 1