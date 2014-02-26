#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#define _MAX_COMPARE_TIME 1

int totalCompare = 0;
int totalCollision = 0;
int maxCompare =0;
int mtotalCompare = 10000;
int mtotalCollision = 1000;
int mmaxCompare = 1000;
int numOfLog = 0;
int numOfEvent = 0;
int numOfError = 0;
int prime[60] = {
139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223,
227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307,
311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397,
401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487,
/*491, 499, 503, 509, 521, 523, 541, 547, 557, 563, 569, 571, 577, 587, 593,*/
/*599, 601, 607, 613, 617, 619, 631, 641, 643, 647, 653, 659, 661, 673, 677,*/
/*683, 691, 701, 709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 787,*/};

struct Log_entry
{
	char *code;
	int noR;
	char *message;
};
struct Log_static
{
	char code[30];
	int noR;
	char message[300];
};
struct Log_static log_error_unhashed[200];
struct Log_static log_event_unhashed[200];
struct Log_static log_error_unhashed_DE[200];
struct Log_static log_event_unhashed_DE[200];
struct Log_static log_error_unhashed_EN[200];
struct Log_static log_event_unhashed_EN[200];
struct Log_entry *log_error_hashed;
struct Log_entry *log_event_hashed;
struct Log_entry *log_error_hashed_DE;
struct Log_entry *log_event_hashed_DE;
struct Log_entry *log_error_hashed_EN;
struct Log_entry *log_event_hashed_EN;

unsigned int hashInsertError(char* str, unsigned int len, int x, int y, int z) 
{
	unsigned int hash = 0; 
	unsigned int i = 0;
	int compare = 0;

	for (i = 0; i < len; str++, i++)
	{ 
		hash = hash * x + (*str); 
	}
	i = hash % prime[z];

	if (log_error_hashed[i].code != NULL)
		totalCollision++;

	while (log_error_hashed[i].code != NULL)
	{
		compare ++;
		i += y;
		if ( i>= prime[z])
			i %= prime[z];
	}
	totalCompare += compare;
	if (compare >= maxCompare)
		maxCompare = compare;
	return i;
}

unsigned int hashInsertEvent(char* str, unsigned int len, int x, int y, int z) 
{
	unsigned int hash = 0; 
	unsigned int i = 0;
	int compare = 0;

	for(i = 0; i < len; str++, i++) 
	{ 
		hash = hash * x + (*str); 
	}
	i = hash % prime[z];

	if (log_event_hashed[i].code != NULL)
		totalCollision++;

	while (log_event_hashed[i].code != NULL)
	{
		compare ++;
		i += y;
		if ( i>= prime[z])
			i %= prime[z];
	}
	totalCompare += compare;
	if (compare >= maxCompare)
		maxCompare = compare;
	return i;
}

int main()
{
	int i = 0, idx = 0, check;
	int collision = 0, min = 200;
	char buf, buf1[30], buf2[4], buf3[300];

	FILE *fp;
	FILE *fp1, *fp2, *fp3, *fp4;
	int x, y, z;
	int x_event, y_event, z_event;
	int x_error, y_error, z_error;
	
	fp1 = fopen("log_error_table_DE.txt", "r");
	fp2 = fopen("log_event_table_DE.txt", "r");
	fp3 = fopen("log_error_table_EN.txt", "r");
	fp4 = fopen("log_event_table_EN.txt", "r");
	if (!fp1)
	{
		printf("Error! Fail to open \"log_error_table_DE.txt\".\n");
		return 1;
	}
	if (!fp2)
	{
		printf("Error! Fail to open \"log_event_table_DE.txt\".\n");
		return 1;
	}
	if (!fp3)
	{
		printf("Error! Fail to open \"log_error_table_EN.txt\".\n");
		return 1;
	}
	if (!fp4)
	{
		printf("Error! Fail to open \"log_event_table_EN.txt\".\n");
		return 1;
	}
	/*************************phase 1**************************/
	/*start parsing log_error_table_DE.txt*/
	/*make sure it follows the pattern: {"code", "message"},*/
	while ((buf = fgetc(fp1)) != EOF)
	{
		if (buf == '{')
		{
			if ((buf = fgetc(fp1)) == '"')
			{
				while ((buf = fgetc(fp1)) != '"')
				{
					buf1[i++] = buf;
				}
				buf1[i] = '\0';
				for (i = 0; i < 3; i++)
					fgetc(fp1);
				i = 0;
				while ((buf = fgetc(fp1)) != '"')
				{
					buf2[i++] = buf;
				}
				buf2[i] = '\0';
				for (i = 0; i < 3; i++)
					fgetc(fp1);
				i = 0;
				while ((buf = fgetc(fp1)) != '"')
				{
					buf3[i++] = buf;
				}
				buf3[i] = '\0';
				i = 0;
				strcpy(log_error_unhashed[numOfError].code, buf1);
				log_error_unhashed[numOfError].noR = atoi(buf2);
				strcpy(log_error_unhashed[numOfError].message, buf3);
				strcpy(log_error_unhashed_DE[numOfError].code, buf1);
				log_error_unhashed_DE[numOfError].noR = atoi(buf2);
				strcpy(log_error_unhashed_DE[numOfError].message, buf3);
				numOfError++;
			}
			else
				continue;
		}
		else
			continue;
	}
	fclose(fp1);
	
	/*start parsing log_event_table_DE.txt*/
	/*make sure it follows the pattern: {"code", "message"},*/
	while ((buf = fgetc(fp2)) != EOF)
	{
		if (buf == '{')
		{
			if ((buf = fgetc(fp2)) == '"')
			{
				while ((buf = fgetc(fp2)) != '"')
				{
					buf1[i++] = buf;
				}
				buf1[i] = '\0';
				for (i = 0; i < 3; i++)
					fgetc(fp2);
				i = 0;
				while ((buf = fgetc(fp2)) != '"')
				{
					buf2[i++] = buf;
				}
				buf2[i] = '\0';
				for (i=0; i < 3; i++)
					fgetc(fp2);
				i = 0;
				while ((buf = fgetc(fp2)) != '"')
				{
					buf3[i++] = buf;
				}
				buf3[i] = '\0';
				i = 0;
				strcpy(log_event_unhashed[numOfEvent].code, buf1);
				log_event_unhashed[numOfEvent].noR = atoi(buf2);
				strcpy(log_event_unhashed[numOfEvent].message, buf3);
				strcpy(log_event_unhashed_DE[numOfEvent].code, buf1);
				log_event_unhashed_DE[numOfEvent].noR = atoi(buf2);
				strcpy(log_event_unhashed_DE[numOfEvent].message, buf3);
				numOfEvent++;
			}
			else
				continue;
		}
		else
			continue;
	}
	fclose(fp2);
	
	/*start parsing log_error_table_EN.txt*/
	/*make sure it follows the pattern: {"code", "message"},*/
	numOfError = 0;
	while ((buf = fgetc(fp3)) != EOF)
	{
		if (buf == '{')
		{
			if ((buf = fgetc(fp3)) == '"')
			{
				while ((buf = fgetc(fp3)) != '"')
				{
					buf1[i++] = buf;
				}
				buf1[i] = '\0';
				for (i = 0; i < 3; i++)
					fgetc(fp3);
				i = 0;
				while ((buf = fgetc(fp3)) != '"')
				{
					buf2[i++] = buf;
				}
				buf2[i] = '\0';
				for (i = 0; i < 3; i++)
					fgetc(fp3);
				i = 0;
				while ((buf = fgetc(fp3)) != '"')
				{
					buf3[i++] = buf;
				}
				buf3[i] = '\0';
				i = 0;
				strcpy(log_error_unhashed_EN[numOfError].code, buf1);
				log_error_unhashed_EN[numOfError].noR = atoi(buf2);
				strcpy(log_error_unhashed_EN[numOfError].message, buf3);
				numOfError++;
			}
			else
				continue;
		}
		else
			continue;
	}
	fclose(fp3);
	
	/*start parsing log_event_table_EN.txt*/
	/*make sure it follows the pattern: {"code", "message"},*/
	numOfEvent = 0;
	while ((buf = fgetc(fp4)) != EOF)
	{
		if (buf == '{')
		{
			if ((buf = fgetc(fp4)) == '"')
			{
				while ((buf = fgetc(fp4)) != '"')
				{
					buf1[i++] = buf;
				}
				buf1[i] = '\0';
				for (i = 0; i < 3; i++)
					fgetc(fp4);
				i = 0;
				while ((buf = fgetc(fp4)) != '"')
				{
					buf2[i++] = buf;
				}
				buf2[i] = '\0';
				for (i = 0; i < 3; i++)
					fgetc(fp4);
				i = 0;
				while ((buf = fgetc(fp4)) != '"')
				{
					buf3[i++] = buf;
				}
				buf3[i] = '\0';
				i = 0;
				strcpy(log_event_unhashed_EN[numOfEvent].code, buf1);
				log_event_unhashed_EN[numOfEvent].noR = atoi(buf2);
				strcpy(log_event_unhashed_EN[numOfEvent].message, buf3);
				numOfEvent++;
			}
			else
				continue;
		}
		else
			continue;
	}
	fclose(fp4);
	
	for (i=0; i<numOfEvent; i++)
		printf("[EVENT]%3d, code=%s, message=%s\n", i, log_event_unhashed[i].code, log_event_unhashed[i].message);
	for (i=0; i<numOfError; i++)
		printf("[ERROR]%3d, code=%s, message=%s\n", i, log_error_unhashed[i].code, log_error_unhashed[i].message);

	/*************************phase 2**************************/	
	/*Optimization*/
	for (z_error = 0; z_error < 60; z_error++)
	{
		log_error_hashed    = (struct Log_entry *)malloc(sizeof(struct Log_entry) * prime[z_error]);
		log_error_hashed_DE = (struct Log_entry *)malloc(sizeof(struct Log_entry) * prime[z_error]);
		log_error_hashed_EN = (struct Log_entry *)malloc(sizeof(struct Log_entry) * prime[z_error]);
		for (x_error = 1; x_error < 800; x_error++)
		{
			for (y_error = 1; y_error < prime[z_error] - 1; y_error++)
			{			
				memset(log_error_hashed, 0, sizeof(struct Log_entry) * prime[z_error]);
				memset(log_error_hashed_DE, 0, sizeof(struct Log_entry) * prime[z_error]);
				memset(log_error_hashed_EN, 0, sizeof(struct Log_entry) * prime[z_error]);
				for (i = 0; i < numOfError; i++)
				{
					/*for(check=0; check<prime[z_error]; check++)
						if(log_error_hashed[check].code != NULL)
							if(!strcmp(log_error_unhashed[i].code, log_error_hashed[check].code))
							{
								printf("Duplicate error code!\n");
								return 1;
							}*/
					idx = hashInsertError(log_error_unhashed[i].code, strlen(log_error_unhashed[i].code), x_error, y_error, z_error);
					log_error_hashed[idx].code       = log_error_unhashed[i].code;
					log_error_hashed[idx].noR        = log_error_unhashed[i].noR;
					log_error_hashed[idx].message    = log_error_unhashed[i].message;
					log_error_hashed_DE[idx].code    = log_error_unhashed_DE[i].code;
					log_error_hashed_DE[idx].noR     = log_error_unhashed_DE[i].noR;
					log_error_hashed_DE[idx].message = log_error_unhashed_DE[i].message;
					log_error_hashed_EN[idx].code    = log_error_unhashed_EN[i].code;
					log_error_hashed_EN[idx].noR     = log_error_unhashed_EN[i].noR;
					log_error_hashed_EN[idx].message = log_error_unhashed_EN[i].message;
					//printf("Time:%d, totalCollision=%d, totalCompare=%d\n", i, totalCollision, totalCompare);
				}
				//printf("X:%d, Y:%d, totalCollision=%d, totalCompare=%d, maxCompare=%d\n", x, y, totalCollision, totalCompare, maxCompare);
				if (totalCompare + totalCollision + maxCompare < mtotalCompare + mtotalCollision + mmaxCompare)
				{
					mtotalCompare = totalCompare;
					mtotalCollision = totalCollision;
					mmaxCompare = maxCompare;
					//printf("X:%d, Y:%d, SIZE:%d, totalCollision=%d, totalCompare=%d, maxCompare=%d\n", x, y, prime[z], totalCollision, totalCompare, maxCompare);
					if (maxCompare == _MAX_COMPARE_TIME)
						goto end1;
				}
				totalCollision = 0;
				totalCompare =0;
				maxCompare = 0;	
			}
		}	
		free(log_error_hashed);
		free(log_error_hashed_DE);
		free(log_error_hashed_EN);
	}
end1:
	printf("[ERROR]X:%d, Y:%d, SIZE:%d, totalCollision=%d, totalCompare=%d, maxCompare=%d\n", x_error, y_error, prime[z_error], totalCollision, totalCompare, maxCompare);
	totalCompare = 0;
	totalCollision = 0;
	maxCompare = 0;
	mtotalCompare = 10000;
	mtotalCollision = 1000;
	mmaxCompare = 1000;	
	for (z_event = 0; z_event < 60; z_event++)
	{
		log_event_hashed    = (struct Log_entry *)malloc(sizeof(struct Log_entry) * prime[z_event]);
		log_event_hashed_DE = (struct Log_entry *)malloc(sizeof(struct Log_entry) * prime[z_event]);
		log_event_hashed_EN = (struct Log_entry *)malloc(sizeof(struct Log_entry) * prime[z_event]);
		for (x_event = 1; x_event < 800; x_event++)
		{
			for (y_event = 1; y_event < prime[z_event] - 1; y_event++)
			{			
				memset(log_event_hashed, 0, sizeof(struct Log_entry) * prime[z_event]);
				memset(log_event_hashed_DE, 0, sizeof(struct Log_entry) * prime[z_event]);
				memset(log_event_hashed_EN, 0, sizeof(struct Log_entry) * prime[z_event]);
				for (i = 0; i < numOfEvent; i++)
				{
					/*for(check=0; check<prime[z_event]; check++)
						if(log_event_hashed[check].code != NULL)
							if(!strcmp(log_event_unhashed[i].code, log_event_hashed[check].code))
							{
								printf("Duplicate event code!\n");
								return 1;
							}*/
					idx = hashInsertEvent(log_event_unhashed[i].code, strlen(log_event_unhashed[i].code), x_event, y_event, z_event);
					log_event_hashed[idx].code       = log_event_unhashed[i].code;
					log_event_hashed[idx].noR        = log_event_unhashed[i].noR;
					log_event_hashed[idx].message    = log_event_unhashed[i].message;
					log_event_hashed_DE[idx].code    = log_event_unhashed_DE[i].code;
					log_event_hashed_DE[idx].noR     = log_event_unhashed_DE[i].noR;
					log_event_hashed_DE[idx].message = log_event_unhashed_DE[i].message;
					log_event_hashed_EN[idx].code    = log_event_unhashed_EN[i].code;
					log_event_hashed_EN[idx].noR     = log_event_unhashed_EN[i].noR;
					log_event_hashed_EN[idx].message = log_event_unhashed_EN[i].message;
					//printf("Time:%d, totalCollision=%d, totalCompare=%d\n", i, totalCollision, totalCompare);
				}
				//printf("X:%d, Y:%d, totalCollision=%d, totalCompare=%d, maxCompare=%d\n", x, y, totalCollision, totalCompare, maxCompare);
				if (totalCompare + totalCollision + maxCompare < mtotalCompare + mtotalCollision + mmaxCompare)
				{
					mtotalCompare = totalCompare;
					mtotalCollision = totalCollision;
					mmaxCompare = maxCompare;
					//printf("X:%d, Y:%d, SIZE:%d, totalCollision=%d, totalCompare=%d, maxCompare=%d\n", x, y, prime[z], totalCollision, totalCompare, maxCompare);
					if (maxCompare == 1)
						goto end2;
				}
				totalCollision = 0;
				totalCompare =0;
				maxCompare = 0;	
			}
		}	
		free(log_event_hashed);
		free(log_event_hashed_DE);
		free(log_event_hashed_EN);
	}
end2:
	printf("[EVENT]X:%d, Y:%d, SIZE:%d, totalCollision=%d, totalCompare=%d, maxCompare=%d\n", x_event, y_event, prime[z_event], totalCollision, totalCompare, maxCompare);
	/*************************phase 3**************************/
	/*generate log_table.h*/
	fp = fopen("log_table.h", "w");
	fprintf(fp, "/***************************************************/\n");
	fprintf(fp, "/************DO NOT MODIFY THIS FILE****************/\n");
	fprintf(fp, "/***********IT SHOULD BE AUTO GENERATED*************/\n");
	fprintf(fp, "/***************************************************/\n");
	fprintf(fp, "#include <string.h>\n");
	fprintf(fp, "#define TABLE_EVENT_SIZE %d\n", prime[z_event]);
	fprintf(fp, "#define TABLE_ERROR_SIZE %d\n", prime[z_error]);
	fprintf(fp, "#define _MAX_COMPARE_TIME %d\n", _MAX_COMPARE_TIME);
	fprintf(fp, "\nstruct Log_entry\n{\n	char *code;\n	int noR;\n	char *message;\n};\n\n");
	
	fprintf(fp, "struct Log_entry log_event_hashed_DE[] =\n{\n");
	for(i = 0; i < prime[z_event]; i++)
		fprintf(fp, "/*%3d*/	{\"%s\", %d, \"%s\"},\n", i, log_event_hashed_DE[i].code, log_event_hashed_DE[i].noR, log_event_hashed_DE[i].message);
	fprintf(fp, "};\n\n");
	
	fprintf(fp, "struct Log_entry log_error_hashed_DE[] =\n{\n");
	for(i = 0; i < prime[z_error]; i++)
		fprintf(fp, "/*%3d*/	{\"%s\", %d, \"%s\"},\n", i, log_error_hashed_DE[i].code, log_error_hashed_DE[i].noR, log_error_hashed_DE[i].message);
	fprintf(fp, "};\n\n");
	
	fprintf(fp, "struct Log_entry log_event_hashed_EN[] =\n{\n");
	for(i = 0; i < prime[z_event]; i++)
		fprintf(fp, "/*%3d*/	{\"%s\", %d, \"%s\"},\n", i, log_event_hashed_EN[i].code, log_event_hashed_EN[i].noR, log_event_hashed_EN[i].message);
	fprintf(fp, "};\n\n");
	
	fprintf(fp, "struct Log_entry log_error_hashed_EN[] =\n{\n");
	for(i = 0; i < prime[z_error]; i++)
		fprintf(fp, "/*%3d*/	{\"%s\", %d, \"%s\"},\n", i, log_error_hashed_EN[i].code, log_error_hashed_EN[i].noR, log_error_hashed_EN[i].message);
	fprintf(fp, "};\n\n");
	
	fprintf(fp, "int hashSearchEventDE(char* str, unsigned int len)\n{\n	unsigned int hash = 0;\n	int i = 0;\n	int t = 0;\n\n	for(i = 0; i < len; str++, i++)\n");
	fprintf(fp, "	{\n		hash = hash * %d + (*str);\n	}\n	i = hash % TABLE_EVENT_SIZE;\n	while (strcmp(log_event_hashed_DE[i].code, str-len) != 0)\n	{\n", x_event);
	fprintf(fp, "		i+=%d;\n		if (i > TABLE_EVENT_SIZE)\n			i %= TABLE_EVENT_SIZE;\n		if (t++ >= _MAX_COMPARE_TIME)\n			return -1;\n	}\n	return i;\n}\n\n", y_event);
	
	fprintf(fp, "int hashSearchErrorDE(char* str, unsigned int len)\n{\n	unsigned int hash = 0;\n	int i = 0;\n	int t = 0;\n\n	for(i = 0; i < len; str++, i++)\n");
	fprintf(fp, "	{\n		hash = hash * %d + (*str);\n	}\n	i = hash % TABLE_ERROR_SIZE;\n	while (strcmp(log_error_hashed_DE[i].code, str-len) != 0)\n	{\n", x_error);
	fprintf(fp, "		i+=%d;\n		if (i > TABLE_ERROR_SIZE)\n			i %= TABLE_ERROR_SIZE;\n		if (t++ >= _MAX_COMPARE_TIME)\n			return -1;\n	}\n	return i;\n}\n\n", y_error);
	
	fprintf(fp, "int hashSearchEventEN(char* str, unsigned int len)\n{\n	unsigned int hash = 0;\n	int i = 0;\n	int t = 0;\n\n	for(i = 0; i < len; str++, i++)\n");
	fprintf(fp, "	{\n		hash = hash * %d + (*str);\n	}\n	i = hash % TABLE_EVENT_SIZE;\n	while (strcmp(log_event_hashed_EN[i].code, str-len) != 0)\n	{\n", x_event);
	fprintf(fp, "		i+=%d;\n		if (i > TABLE_EVENT_SIZE)\n			i %= TABLE_EVENT_SIZE;\n		if (t++ >= _MAX_COMPARE_TIME)\n			return -1;\n	}\n	return i;\n}\n\n", y_event);
	
	fprintf(fp, "int hashSearchErrorEN(char* str, unsigned int len)\n{\n	unsigned int hash = 0;\n	int i = 0;\n	int t = 0;\n\n	for(i = 0; i < len; str++, i++)\n");
	fprintf(fp, "	{\n		hash = hash * %d + (*str);\n	}\n	i = hash % TABLE_ERROR_SIZE;\n	while (strcmp(log_error_hashed_EN[i].code, str-len) != 0)\n	{\n", x_error);
	fprintf(fp, "		i+=%d;\n		if (i > TABLE_ERROR_SIZE)\n			i %= TABLE_ERROR_SIZE;\n		if (t++ >= _MAX_COMPARE_TIME)\n			return -1;\n	}\n	return i;\n}\n\n", y_error);
	
	fclose(fp);
	free(log_error_hashed);
	free(log_event_hashed);
	free(log_error_hashed_DE);
	free(log_event_hashed_DE);
	free(log_error_hashed_EN);
	free(log_event_hashed_EN);
	return 0;
}
