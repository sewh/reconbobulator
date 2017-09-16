Reconbobulator
===============

Reconbobulator is a little script to automate some of the "greeting" scans I do of hosts when I first meet them in the OSCP. It works on Kali Linux. It does;

* A comprehensive nmap scan with SMB scripts enabled;
* A UDP scan using unicornscan to enumerate UDP services; 
* An enum4linux scan just to be safe;
* SNMP checks for three common community strings (public, private, manager).

# To Install

* `git clone https://github.com/sewh/reconbobulator.git && cd reconbobulator`
* `bundle install`
* `ruby reconbob.rb`

# Caveats

* It's a horrible script. First go at Ruby after being a Pythonista for a while so it's far from idomatic;
* It is tied into my workflow. Might make things more moduler and selective soon. May even add a wizard!