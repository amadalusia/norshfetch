#!/usr/bin/env bash

RED="\e[31m"
BLUE="\e[34m"
YELLOW="\e[33m"
WHITE="\e[37m"
NC='\e[0m'

NAME="$(whoami)@$(uname -n)"
OS=$(awk -F= '$1 == "NAME" {gsub(/"/, "", $2); print $2}' /etc/os-release)
KERNEL=$(uname -r)
SYSTEM=$(cat /sys/devices/virtual/dmi/id/product_name)
SHELL=$(basename $SHELL)
UPTIME="$(uptime | awk '{print $3}' | sed 's/,//')"
MEMORY="$(free -m | awk 'NR==2{print $3 "M / " $2 "M"}')"

print_info() {
    echo -ne "\n"
    echo -ne "$1████$2██$3███$2██$1████████████$NC | $NAME\n"
    echo -ne "$1████$2██$3███$2██$1████████████$NC | OS:   $OS\n"
    echo -ne "$2██████$3███$2██████████████$NC | KRNL: $KERNEL\n"
    echo -ne "$3███████████████████████$NC | SYS:  $SYSTEM\n"
    echo -ne "$2██████$3███$2██████████████$NC | SH:   $SHELL\n"
    echo -ne "$1████$2██$3███$2██$1████████████$NC | UP:   $UPTIME\n"
    echo -ne "$1████$2██$3███$2██$1████████████$NC | MEM:  $MEMORY\n"
    echo -ne "\n"
}

print_if_error() {
    echo -e "\n--norway will use the norweigan flag"
    echo -e "--sweden will use the swedish flag"
    echo -e "--denmark will use the danish flag"
    echo -e "--finland will use the finnish flag"
    echo -e "--iceland will use the icelandic flag"
    echo -e "--faroe will use the faroese flag\n"
}

if [ "$#" -eq 0 ]; then
    echo -e "\n"
    echo -e "$RED""error: please provide an argument.$NC\n"

    print_if_error
    exit 1
fi

case "$1" in
    "--norway")
	print_info "$RED" "$WHITE" "$BLUE"
	;;
    "--sweden")
	print_info "$BLUE" "$BLUE" "$YELLOW"
	;;
    "--denmark")
	print_info "$RED" "$RED" "$WHITE"
	;;
    "--finland")
	print_info "$WHITE" "$WHITE" "$BLUE"
	;;
    "--iceland")
	print_info "$BLUE" "$WHITE" "$RED"
	;;
    "--faroe")
	print_info "$WHITE" "$BLUE" "$RED"
	;;
    "--help")
	print_if_error
	;;
    *)
	echo -e "\n$RED""error: unknown argument.$NC"
	print_if_error
	;;
esac
