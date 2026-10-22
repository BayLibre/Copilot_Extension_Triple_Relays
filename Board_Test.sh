#!/bin/sh

# Make sure to have only one Copilot connected to the test computer
GPIO_CHIP=$(realpath /dev/copilot/by-id/*/gpiochip)

SetChannelState()
{
	local Channel_GPIO=$1

	printf "Turning the channel ${Channel_GPIO} ON for 2 seconds, then turning off...\n"

	sudo gpioset -c $GPIO_CHIP -t 2s,0 ${Channel_GPIO}=1
	sleep 2s
}

printf "Relay extension board setup :\n"
printf "+ Put a jumper on the J3 header between pins 5 and 6 (to select the GPIO 1 for the channel 1),\n"
printf "+ Put a jumper on the J6 header between pins 3 and 4 (to select the GPIO 2 for the channel 2),\n"
printf "+ Put a jumper on the J8 header between pins 1 and 2 (to select the GPIO 3 for the channel 3),\n"
printf "+ Plug the extension board on top of a Copilot.\n"
printf "You can now connect the Copilot motherboard \"PC\" USB-C cable (the one that goes to the test computer).\n\n"

# Make sure that a Copilot is detected
if [ -z "$GPIO_CHIP" ]
then
	printf "Error : the Copilot board is not detected, aborting.\n"
	exit 1
fi

printf "Press Enter to run the test."
read Answer

SetChannelState 1
SetChannelState 2
SetChannelState 3

printf "\nThe test is finished, remove the Copilot motherboard power, then remove the relays extension board.\n"
