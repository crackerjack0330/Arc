/******************************/
/** This little program compare .glbcfg
	with glbcfg.dft at boot stage 99 to
	check if any modification been made.
	Author: Jason Wang 20140116    **/
/******************************/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define BLOCKSIZE 8 /*this is for searching window size*/
#define MAX_DIFFERENCES 64/*we only care about first few changes*/
#define MAX_LINE_LENGTH 192

typedef struct myStruct
{
	char string[MAX_LINE_LENGTH + 1];
	int length;
}myStruct_t;

typedef struct myIgnore
{
	char *string;
	int length;
}myIgnore_t;

myStruct_t array1[BLOCKSIZE];
myStruct_t array2[BLOCKSIZE];
char diffArray1[MAX_DIFFERENCES][MAX_LINE_LENGTH + 1];
char diffArray2[MAX_DIFFERENCES][MAX_LINE_LENGTH + 1];

int diffIndex1 = 0;
int diffIndex2 = 0;

/*this table contains pararmeters would change while booting*/
myIgnore_t ignoreTable[] = 
{
	{"domainname", 0},
	{"ip6_old_pfxlen", 0},
	{"ip6_ula_gid", 0},
	{"ip6_dns_primary", 0},
	{"ip6_dns_secondary", 0},
	{"ip6_delegate_prefix", 0},
	{"ip6_delegate_pfxlen", 0},
	{"password", 0},
	{"reboot", 0},
	{"host_name", 0},
	{"vlan7_dns1", 0},
	{"vlan7_dns2", 0},
	{"vlan8_dns1", 0},
	{"vlan8_dns2", 0},
	{"AP_SSID", 0},
	{"AP_SSID_2", 0},
	{"ssnpskASCIIkey", 0},
	{"fw_ver", 0},
};

int doBlockSearch(FILE *fp1, FILE *fp2)
{
	int i;
	int x, y, x1, y1;
	int read1, read2;
	int length1 = MAX_LINE_LENGTH, length2 = MAX_LINE_LENGTH;
	char *line1, *line2;
	int hit = 0;

	//printf("[%s][%d][%d]\n", __func__, fp1, fp2);
	line1 = (char *)malloc(MAX_LINE_LENGTH + 1);
	line2 = (char *)malloc(MAX_LINE_LENGTH + 1);

	for (i = 1; i < BLOCKSIZE; i++)
	{
		read1 = getline(&line1, &length1, fp1);
		read2 = getline(&line2, &length2, fp2);

		/*line start with # and @ is meanless for configuration*/
		while (line1[0] == '#' || line1[0] == '@')
		{
			read1 = getline(&line1, &length1, fp1);
			if (read1 == -1)
				break;
		}
		while (line2[0] == '#' || line2[0] == '@')
		{
			read2 = getline(&line2, &length2, fp2);
			if (read2 == -1)
				break;
		}
		*(line1 + read1 - 1) = '\0';
		*(line2 + read2 - 1) = '\0';
		strcpy(array1[i].string, line1);
		strcpy(array2[i].string, line2);
		array1[i].length = read1;
		array2[i].length = read2;

		//printf("[%s][%d][%d][%d][%s][%s]\n", __func__, i, read1, read2, line1, line2);
		for (x = 0; x <= i; x++)
		{
			for (y = 0; y <= i; y++)
			{
				if (strcmp(array1[x].string, array2[y].string) == 0)
				{
					hit = 1;
					break;
				}
			}
			if (hit)
				break;
		}
		if (hit)
			break;
	}

	//printf("[%s][%d][%d][%d]\n", __func__, hit, x, y);

	if (hit) /*do rewind*/
	{
		x1 = x;
		y1 = y;
		while (x1 < i)
		{
			fseek(fp1, (0 - array1[x1 + 1].length), SEEK_CUR);
			x1++;
		}
		while (y1 < i)
		{
			fseek(fp2, (0 - array2[y1 + 1].length), SEEK_CUR);
			y1++;
		}
	}

	for (i = 0; i < x; i++)
	{
		if (diffIndex1 < MAX_DIFFERENCES)
			strcpy(diffArray1[diffIndex1++], array1[i].string);
	}

	for (i = 0; i < y; i++)
	{
		if (diffIndex2 < MAX_DIFFERENCES)
			strcpy(diffArray2[diffIndex2++], array2[i].string);
	}	

	free(line1);
	free(line2);


	return 0;
}

int main()
{
	FILE *fp1, *fp2;
	int read1, read2;
	int length1 = MAX_LINE_LENGTH, length2 = MAX_LINE_LENGTH;
	char *line1, *line2;
	int numOfIgnore = 0;
	int i, j, diffTemp1, diffTemp2;
	//char cmd[128];

	/*init ignore table, fill in length to speed up*/
	numOfIgnore = sizeof(ignoreTable)/sizeof(myIgnore_t);
	for (i = 0; i < numOfIgnore; i++)
		ignoreTable[i].length = strlen(ignoreTable[i].string);

	//printf("ignoreTable init done[%d]\n", numOfIgnore);

	system("/usr/sbin/arc_osix_ctrl LockSemaphore OSIXCCFG");/*race lock cause ccfg_cli might using these files*/
	fp1 = fopen("/tmp/etc/config/glbcfg.dft", "r");
	fp2 = fopen("/tmp/etc/config/.glbcfg", "r");

	//printf("fp1:%d, fp2:%d\n", fp1, fp2);
	line1 = (char *)malloc(MAX_LINE_LENGTH + 1);
	line2 = (char *)malloc(MAX_LINE_LENGTH + 1);

	while (1)
	{
		read1 = getline(&line1, &length1, fp1);
		read2 = getline(&line2, &length2, fp2);

		if ((read1 == -1) && (read2 == -1))
			break;

		while (line1[0] == '#' || line1[0] == '@')
		{
			read1 = getline(&line1, &length1, fp1);
			if (read1 == -1)
				break;
		}

		while (line2[0] == '#' || line2[0] == '@')
		{
			read2 = getline(&line2, &length2, fp2);
			if (read2 == -1)
				break;
		}

		if (strcmp(line1, line2) == 0)
			continue;
		else
		{
			*(line1 + read1 - 1) = '\0';
			*(line2 + read2 - 1) = '\0';
			//printf("[%s][%d][%d][%s][%s]\n", __func__, read1, read2, line1, line2);

			strcpy(array1[0].string, line1);
			strcpy(array2[0].string, line2);
			array1[0].length = read1;
			array2[0].length = read2;
			doBlockSearch(fp1, fp2);
		}
	}

	fclose(fp1);
	fclose(fp2);

	system("/usr/sbin/arc_osix_ctrl UnLockSemaphore OSIXCCFG");

	//for (i = 0; i < diffIndex1; i++)
		//printf("Diff1[%d][%s]\n", i, diffArray1[i]);

	//for (i = 0; i < diffIndex2; i++)
		//printf("Diff2[%d][%s]\n", i, diffArray2[i]);

	diffTemp1 = diffIndex1;
	diffTemp2 = diffIndex2;

	for (i = 0; i < diffIndex1; i++)
	{
		for (j = 0; j < numOfIgnore; j++)
		{
			if (strncmp(ignoreTable[j].string, diffArray1[i], ignoreTable[j].length) == 0)
			{
				//printf("diffArray1[%d][%d][%d]\n", i, j, diffTemp1);
				diffArray1[i][0] = '\0';
				diffTemp1--;
			}
		}
	}

	for (i = 0; i < diffIndex2; i++)
	{
		for (j = 0; j < numOfIgnore; j++)
		{
			if (strncmp(ignoreTable[j].string, diffArray2[i], ignoreTable[j].length) == 0)
			{
				//printf("diffArray2[%d][%d][%d]\n", i, j, diffTemp2);
				diffArray2[i][0] = '\0';
				diffTemp2--;
			}
		}
	}


	//printf("Diff1[%d], Diff2[%d]\n", diffTemp1, diffTemp2);
	//sprintf(cmd, "echo 'Diff1[%d], Diff2[%d]' > /tmp/defaultStatus", diffTemp1, diffTemp2);
	if (diffTemp1 == 0 && diffTemp2 == 0)
		system("echo 1 > /tmp/defaultStatus");
	else
		system("echo 0 > /tmp/defaultStatus");

	//for (i = 0; i < diffIndex1; i++)
		//printf("Diff1[%d][%s]\n", i, diffArray1[i]);

	//for (i = 0; i < diffIndex2; i++)
		//printf("Diff2[%d][%s]\n", i, diffArray2[i]);


	free(line1);
	free(line2);

	return 0;
}
