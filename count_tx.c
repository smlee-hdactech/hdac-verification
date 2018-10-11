#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <json-c/json.h>

#define MAX_SIZE 3048576

int count;

char *json_parse(char *str, char *key);
void tx_count(char *txs);
int height_count(void);

int main(void)
{
	FILE *fop;
	char getblock_cmd[1024];
	char getblock_txt[MAX_SIZE];
	char *txs;
	int height;
	int i;
	
	height = height_count();

	count = 0;

	for (i = 0; i < height + 1; i++) {
		memset(getblock_cmd, 0x00, sizeof(getblock_cmd));
		snprintf(getblock_cmd, sizeof(getblock_cmd), "/home/aiadmin/binary/hdac-cli ff getblock %d", i);

		fop = popen(getblock_cmd, "r");

		memset(getblock_txt, 0x00, sizeof(getblock_cmd));
		fread(getblock_txt, 1, MAX_SIZE, fop);

		txs = json_parse(getblock_txt, "tx");
		tx_count(txs);
				
		pclose(fop);
	}

	printf("height [%d]\n", height);
	printf("make tx [%d]\n", (count - height));
	printf("total tx [%d]\n", count);
	
	return 0;
}

int height_count(void)
{
        FILE *fop;
        char cmd[1024];
        char text[MAX_SIZE];
	char *temp;
        int height = 0;

        memset(cmd, 0x00, sizeof(cmd));
        snprintf(cmd, sizeof(cmd), "/home/aiadmin/binary/hdac-cli ff getinfo");

        fop = popen(cmd, "r");
        memset(text, 0x00, sizeof(text));

        fread(text, 1, MAX_SIZE, fop);

        temp = json_parse(text, "blocks");
	height = atoi(temp);

        pclose(fop);

        return height;
}

char *json_parse(char *str, char *key)
{
        static char text[MAX_SIZE];
        const char *group = NULL;

        json_object * jobj = NULL;
        json_object * dval = NULL;

        jobj = json_tokener_parse(str);

        json_object_object_get_ex(jobj, key, &dval);
        group = json_object_get_string(dval);

        memset(text, 0x00, sizeof(text));
        snprintf(text, sizeof(text), "%s", group);

	return text;
}

void tx_count(char *txs)
{
        char text[MAX_SIZE];

        memset(text, 0x00, sizeof(text));
        snprintf(text, sizeof(text), "%s", txs);

        char *token = NULL;
        char *sep = ",";

        token = strtok(text, sep);

        while (token != NULL) {

		count++;

                token = strtok(NULL, sep);
        }

}
