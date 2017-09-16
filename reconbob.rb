#!/bin/env ruby
require 'pastel'

$p = Pastel.new

def put_banner()
  banner = %Q{

 +-+-+-+-+-+-+-+-+-+
 |r|e|c|o|n|b|o|b|!|   Preparing for maximum reconbobulation.
 +-+-+-+-+-+-+-+-+-+

}
  puts $p.yellow.bold(banner)
end

def issue_warning
  warning = $p.white.bold.on_red("WARNING")
  warning += "  "
  warning += "Things are about to get noisy. Is that cool?"
  warning += " "
  warning += $p.white.bold("Y/n")
  warning += " "
  print warning

  result = gets.chomp.downcase

  if result == 'y'
    return true
  else
    return false
  end
end

def get_host
  puts
  print "Enter a host to scan> "
  host = gets.chomp.downcase

  print "Going to scan #{host}. Correct?"
  print $p.white.bold(" Y/n ")
  theyre_sure = gets.chomp.downcase

  if theyre_sure == 'y'
    return host
  else
    puts "Okay, have another go in a bit!"
    exit 1
  end
end

def puts_info(msg)
  puts $p.blue.bold("[*]") + " " + msg
end

def big_nmap(host)
  filename = Time.new.strftime('%Y-%m-%d_%H-%M-%S_bignmap')
  puts_info("Running big nmap. Saving to #{filename}.{nmap,gnmap,xml}")

  command = "nmap "
  command += "-Pn -A -sV -sU --top-ports=1000 -T5 -vv "
  command += "--script="
  command += "smb-enum-shares.nse,"
  command += "smb-enum-users.nse,"
  command += "smb-enum-groups.nse,"
  command += "smb-enum-domains.nse,"
  command += "smb-enum-shares.nse,"
  command += "smb-enum-processes.nse,"
  command += "smb-enum-sessions.nse,"
  command += "smb-vuln*.nse,"
  command += "smb-os-discovery.nse "
  command += "-oA #{filename} "
  command += host

  puts_info("Going to run #{command}")

  system("sudo " + command)
end

def enum_four_linux(host)
  filename = Time.new.strftime('%Y-%m-%d_%H-%M-%S_enum4linux.txt')
  command = "enum4linux #{host} > #{filename}"
  puts_info("Running #{command}")

  system(command)
end

def run_snmp_check(host)
  ["public", "private", "manager"].each { |community|
    filename = Time.new.strftime("%Y-%m-%d_%H-%M-%S_snmp_#{community}.txt")
    command = "snmp-check -c #{community} #{host} > #{filename}"
    puts_info("Running #{command}")

    system(command)
  }
end

def main
  put_banner
  continue = issue_warning
  unless continue
    puts "Bah, you're no fun! Going quietly..."
    exit 0
  end
  host = get_host

  puts_info("Starting the scan!")
  big_nmap(host)
  enum_four_linux(host)
  run_snmp_check(host)
end

main