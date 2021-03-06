#!/usr/bin/env bats

PCAP="user.pcap"
CFG="snort.lua"
OPTION="-U -H -q"

@test "user codec - packet decoding" {
    $snorty_path/bin/snort -r $PCAP -c $CFG $OPTION -L dump -d --lua 'output = {wide_hex_dump = true}' > snort.out
    diff expected snort.out
}
@test "network ip layer test" {
    $snorty_path/bin/snort -r teredo.pcap -c $CFG $OPTION -A csv -k none --lua 'network = {max_ip_layers = 1}'> snort.out
    diff expected2 snort.out
}

teardown()
{
    rm -f snort.out
}
