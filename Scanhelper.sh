#!/bin/bash
shopt -s expand_aliases 2>/dev/null
source /home/<ADD_USER>/.zshrc 2>/dev/null

if [ "$1" == "" ]; then
    echo "Please provide an IP address."
    exit 1
fi

IP="$1"
OUTPUT_FILE="${IP}.txt"

echo -e "Please Standby.....\n"

rustscan -a "$IP" -n --ulimit 70000 -t 7000 -- -A -Pn > "$OUTPUT_FILE"

services=(
    "21:FTP"
    "22:SSH"
    "23:TELNET"
    "25:SMTP"
    "53:DNS"
    "80:HTTP"
    "88:Kerberos"
    "135:RPC"
    "137:SMB"
    "161:SNMP"
    "389:LDAP"
    "443:HTTPS"
    "445:SMB"
    "3389:RDP"
    "5985:WINRM"
)

for service in "${services[@]}"; do
    port="${service%%:*}"
    name="${service#*:}"

    if grep -q "${port}/tcp" "$OUTPUT_FILE"; then
        echo -e "${name} is present"
        
        case "$port" in
            21)
                echo -e "[+] Check for Version exploits\n[+] Check for Anonymous logon\n[+] Have you tried Bruteforcing?\n[+] Comeback when you have creds";;
            22)
                echo -e "[+] Check for Version exploits\n[+] Have you tried Bruteforcing?\n[+] Comeback when you have creds";;
            23)
                echo -e "[+] Check for Version exploits\n[+] Have you tried Bruteforcing?\n[+] Comeback when you have creds";;
            25)
                echo -e "[+] Check for Version exploits\n[+] Have you tried Bruteforcing?\n[+] Might mean pop3/IMAP are also present\n[+] Comeback when you have creds";;
            53)
                echo -e "[+] Have you run dig?\n[+] Do you need to modify host file?";;
            80)
                echo -e "[+] Check for Version exploits\n[+] Have you ffuf'd for files and directories?\n[+] Have you reviewed the source code?\n[+] Have you check for injectable fields?\n[+] Have you ran nitko?\n[+] Have you manually reviewed the page?\n[+] Are there fields to bruteforce or inject?\n[+] Does a host need added?";;
            88)
                echo -e "[+] Have/can you run Kerbute\n[+] ASREP Roast?\n[+] Comeback when you have creds to try to kerberos";;
            135)
                echo -e "[+] Check for Null login\n[+] Comeback when you have creds";;
            137)
                echo -e "[+] Check for Null login\n[+] If null login is present have you run enumerated for users and shares\n[+] Have you tried Bruteforcing?\n[+] Comeback when you have creds and repeat";;
            161)
                echo -e "[+] Check for Version exploits\n[+] Have you tried SNMPwalk/onesityone?\n[+] Have you added mibs?";;
            389)
                echo -e "[+] Check for null login access\n[+] Have you tried ldapsearch?\n[+] Comeback when you have creds";;
            443)
                echo -e "[+] Is this the same as HTTP port?\n[+] Check for Version exploits\n[+] Have you ffuf'd for files and directories?\n[+] Have you reviewed the source code?\n[+] Have you check for injectable fields?\n[+] Have you ran nitko?\n[+] Have you manually reviewed the page?\n[+] Are there fields to bruteforce or inject?\n[+] Does a host need added?";;
            445)
                echo -e "[+] Check for Null login\n[+] If null login is present have you run enumerated for users and shares\n[+] Have you tried Bruteforcing?\n[+] Comeback when you have creds and repeat";;
            3389)
                echo -e "[+] Check for a name\n[+] Come back when you have creds";;
            5985)
                echo -e "[+] Come back when you have creds";;
            *)
                echo "Unknown port: ${port}";;
        esac
    fi
done

echo -e "\nHappy Hacking, Don't forget to check the raw output as well"
