#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <time.h>
#include <stdlib.h>

int main(void)
{
	char cmd[1024];
	char *addresses[3] = {
		"H7UpWjxRWNgkTt81kwaZsHf2dMzfUhBzcD",
		"HBhcTDgkfviAD4eUXBFKD1qq2mmkVuwveC",
		"HURMdBiEtTVghMqniu5bYPYW436HoUDg1P"
	};

	int i;
	int k;


	for (k = 0; k < 20000; k++) {
		for (i = 0; i < 3; i++) {
			memset(cmd, 0x00, sizeof(cmd));
			snprintf(cmd, sizeof(cmd), "/home/ubuntu/fix_core/hdac-cli ttx sendfrom HBRaopfYWSgp7A4H1ePbra4L3KeJPD6kGw %s 3", addresses[i]);
			system(cmd);
		}
	}

	return 0;
}

