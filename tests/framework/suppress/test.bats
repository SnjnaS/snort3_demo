#!/usr/bin/env bats

PCAP="dhcp.pcap"
CFG="snort.lua"
OPTION="-q -A csv -k none -U -H"

@test "Suppress - Validate Threshold" {
    $snorty_path/bin/snort -r $PCAP -c $CFG $OPTION > snort.out
    diff expected snort.out
}

teardown()
{
    rm -f snort.out
}

