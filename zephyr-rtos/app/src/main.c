#include <zephyr/device.h>
#include <zephyr/devicetree.h>
#include <zephyr/kernel.h>

/* 1000 msec = 1 sec */
#define SLEEP_TIME_MS 1000

int main(void)
{
	printk("main: basic sample started \n");

	while (1) {
		printk("main: basic sample loop \n");
		k_msleep(SLEEP_TIME_MS);
	}
}
