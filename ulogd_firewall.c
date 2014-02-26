/* ulog_test, $Revision: 5293 $
 *
 * small testing program for libipulog, part of the netfilter ULOG target
 * for the linux 2.4 netfilter subsystem.
 *
 * (C) 2000-2005 by Harald Welte <laforge@gnumonks.org>
 *
 * this code is released under the terms of GNU GPL
 *
 * $Id: ulog_test.c 5293 2005-03-11 11:47:53Z laforge $
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <netinet/in.h>
#include <unistd.h>
#include "libipulog.h"
//#include "umng_syslogd.h"
#include "umng_syslog.h"
#include "libArcComApi.h"
#include <pthread.h>
//#include "libArcOpenComOs.h"

#define MYBUFSIZ 4096
unsigned char text[MYBUFSIZ];
unsigned char srcmac[5];
int idSendMailProfile=-1;

unsigned char PCE[] ={0,0,0,0,0,0,0,0,0,0};
int szPCEArray = sizeof(PCE)/sizeof(unsigned char);

pthread_mutex_t mutex;
#define MAX_LOG_TRACKING_ENTRY 16
typedef struct MyStruct
{
	int hit;
	char prefix[ULOG_PREFIX_LEN];
	pthread_t threadID;
}MyStruct_t;
MyStruct_t myArray[MAX_LOG_TRACKING_ENTRY];
#define INITIAL_SLEEP_VALUE 60
#define SLEEP_MULTIPLIER 4
#define MAX_SLEEP_VALUE 43200/*half a day*/

doLogTimer(int index)
{
	int sleepTime = INITIAL_SLEEP_VALUE;
	int end = 0;

	printf("[%s] start [%d][%s][%d]\n", __func__, index,myArray[index].prefix ,myArray[index].hit);
	while (1)
	{
		pthread_mutex_lock(&mutex);
		if (myArray[index].hit)
		{
			SetSystemLogDT(LOG_TYPE_PROTO_EVENT, "FW101", myArray[index].prefix);
			myArray[index].hit = 0;
			if (sleepTime < MAX_SLEEP_VALUE)
				sleepTime = sleepTime * SLEEP_MULTIPLIER;
		}
		else
		{
			memset(&myArray[index], 0, sizeof(myArray[index]));
			end = 1;
		}
		pthread_mutex_unlock(&mutex);
		if (end)
			pthread_exit(NULL);
		sleep(sleepTime);
	}
}

char getFirstFreePCE(){
	char idx=0;

	for(idx=0; idx<szPCEArray; idx++){
		if(PCE[idx] == 0){
			break;
		}
	}
	if(idx>=szPCEArray)
		idx = -1;

	return idx;
}
char getPCEToken(){
	char idx = getFirstFreePCE();
	PCE[idx] = 1;
}
char freePCEToken(char idx){
	PCE[idx] = 0;
}
void setFloodthread(unsigned char protocol, char* strSrcMac, char* strDstMac, char* strSrcIP, char* strDstIP, int time)
{
	FILE *pf;
//	char idx;
//	idx = getPCEToken();
	char shellCmd[255];
	char *protoStr;
	switch(protocol){
		case IPPROTO_TCP:
			protoStr = "TCP";
			break;
		case IPPROTO_UDP:
			protoStr = "UDP";
			break;
		case IPPROTO_ICMP:
			protoStr = "ICMP";
			break;
		default:
			protoStr = "UDP";
	}
	//echo "add IPv4 ${proctol} ${srcIP}:${srcPort}" > /proc/eth/stop_flooding_packet
	//osPrintfConsole("add IPv4 %s %s:%d\n", protoStr, strSrcIP, 0);
	pf = fopen("/proc/eth/stop_flooding_packet","w");
	if (pf == NULL)
		printf("[%s:%d]write on /proc/eth/stop_flooding_packet fail\n", __FUNCTION__, __LINE__);
	else
	{
		fprintf(pf,"add IPv4 %s %s:%d\n", protoStr, strSrcIP, 0);
		fclose(pf);
	}
}
/* prints some logging about a single packet */
void handle_packet(ulog_packet_msg_t *pkt)
{
	unsigned char *p;
	int i;
	char *ipaddr;
	char shellCmd[255];
	int idx=0;
	char strSrcMac[13], strDstMac[13];
	char *strSrcIP, *strDstIP;
	char strSrcIPv4[16], strDstIPv4[16];
	int writeTo = -1;
	int find = 0;
	int length;

	strSrcIP = strSrcIPv4;
	strDstIP = strDstIPv4;
	shellCmd[0] = "\0";
	strSrcMac[0] = "\0";
	strDstMac[0] = "\0";

	if (strlen(pkt->prefix)){
//		printf("%s",pkt->prefix);
		strncpy(text, pkt->prefix, strlen(pkt->prefix)+1);
//		printf("%s(mac_len:%d)\n",pkt->prefix, pkt->mac_len);
		if((pkt->ipSrc != 0)||(pkt->ipDst != 0)){
			strncat (text,"src ip=", strlen("src ip="));
			ipaddr = inet_ntoa(*(struct in_addr*)&(pkt->ipSrc));
			strcpy(strSrcIP, ipaddr);
			strncat (text,ipaddr, strlen(ipaddr));
//			printf("src:%s ", ipaddr);
			strncat (text," dst ip=", strlen(" dst ip="));
			ipaddr = inet_ntoa(*(struct in_addr*)&(pkt->ipDst));
			strcpy(strDstIP, ipaddr);
			strncat (text,ipaddr, strlen(ipaddr));
//			printf("dst:%s\n", ipaddr);
		}
		else if (pkt->mac_len){
//			printf("src mac=");
			length = pkt->mac_len/2-1;
			strncat (text,"src mac=", strlen("src mac="));
			p = pkt->mac;
			for (i = 0; i < length; i++, p++){
					sprintf(srcmac, "%02x%c", *p, i==length-1 ? ' ':':');
				strncat (text, srcmac, strlen(srcmac));
					strncat (strSrcMac, srcmac, strlen(srcmac));
//				printf("%02x%c", *p, i==pkt->mac_len-1 ? ' ':':');
			}
			strncat (text," ", strlen(" "));
			strncat (text,"dst mac=", strlen("dst mac="));
			for (i = 0; i < length; i++, p++){
					sprintf(srcmac, "%02x%c", *p, i==length-1 ? ' ':':');
					strncat (text, srcmac, strlen(srcmac));
					strncat (strDstMac, srcmac, strlen(srcmac));
//				printf("%02x%c", *p, i==pkt->mac_len-1 ? ' ':':');
			}

		}



		strncat (text,"\n", strlen("\n"));

		{
			setFloodthread(pkt->protocol
							,(pkt->mac_len)?strSrcMac:"\"\""
							,(pkt->mac_len)?strDstMac:"\"\""
							,(pkt->ipSrc != 0)?strSrcIP:"\"\""
							,(pkt->ipDst != 0)?strDstIP:"\"\""
							,30
				 );

		}

		printf("[%s] table scan start\n", __func__);
		pthread_mutex_lock(&mutex);
		for (i = 0; i < MAX_LOG_TRACKING_ENTRY; i++) /*If MAX_LOG_TRACKING_ENTRY becomes big, might think another solution*/
		{
			if (myArray[i].prefix[0] == '\0')/*record the empty entry for later strcpy*/
			{
				writeTo = i;
				continue;
			}
			else
			{
				if (strcmp(myArray[i].prefix, pkt->prefix) == 0)/*this one is already in table, just mark it up*/
				{
					printf("[%s] hit: %d\n", __func__, i);
					myArray[i].hit = 1;
					find = 1;
					break;
				}
			}
		}
		if (find == 0)
		{
			if (writeTo < 0)
				;/*table is full, ignore this log event*/
			else
			{
				strcpy(myArray[writeTo].prefix, pkt->prefix);
				myArray[writeTo].hit = 1;
				printf("[%s] thread->doLogTimer\n", __func__);
				if (pthread_create(&myArray[writeTo].threadID, NULL, (void *)doLogTimer, writeTo) != 0)
				{
					memset(&myArray[writeTo], 0, sizeof(myArray[writeTo]));
					ipulog_perror("ulogd_firewall: pthread_create fail");
				}
			}
		}
		pthread_mutex_unlock(&mutex);

	}
}

mainThread(char *group)
{
	struct ipulog_handle *h;
	unsigned char* buf;
	ulog_packet_msg_t *upkt;
	int i;
	int len;

	/* allocate a receive buffer */
	buf = (unsigned char *) malloc(MYBUFSIZ);

	printf("[%s] start\n", __func__);
	/* create ipulog handle */
	h = ipulog_create_handle(ipulog_group2gmask(atoi(group)), 150000);
	if (!h)
	{
		/* if some error occurrs, print it to stderr */
		ipulog_perror(NULL);
		exit(1);
	}
	printf("[%s] ipulog_create_handle\n", __func__);
	/* Write the text on the command line to the socket.  */
	/* loop receiving packets and handling them over to handle_packet */
	while (1)
	{
		printf("[%s] ipulog_read\n", __func__);
		len = ipulog_read(h, buf, MYBUFSIZ, 1);
		printf("[%s] ipulog_read done\n", __func__);
		if(len > 0)
		{
			while (upkt = ipulog_get_packet(h, buf, len))
			{
				handle_packet(upkt);
			}
		}
		else
		{
			ipulog_perror("ulogd_firewall: short read");
			exit(1);
		}
	}

	/* just to give it a cleaner look */
	ipulog_destroy_handle(h);
}

int main(int argc, char *argv[])
{
	pthread_t logTimer, mainT;
	int ret;

	pthread_mutex_init(&mutex, NULL);
	if (argc != 2)
	{
		fprintf(stderr, "Usage: %s group\n", argv[0]);
		exit(1);
	}

	ret = pthread_create(&mainT, NULL, (void *)mainThread, argv[1]);
	if (ret != 0)
		return 1;

	pthread_join(mainT, NULL);
	return 0;
}
