#!/bin/bash
#
#energia.sh - Retorna o status de energia e bateria.
#
#  Blog: rafaeliguatemy.blogspot.com
#  Autor: Rafael Iguatemy dos Santos <rafael.dsantos@bol.com.br>
#  Manutencao: Rafael Iguatemy dos Santos
#
#------------------------------------------------------------------------
#  Esse programa mostra o status de energia, mostrado no shell.
#
#  Exemplo:
#    $ ./energia.sh 
#    
#------------------------------------------------------------------------
#Versao 1.0 2009-07-22 Rafael Iguatemy
#      -Versao inicial
#Versao 1.1 2009-07-24 Rafael Iguatemy
#      -Colocacao da barra de progresso
# Licenca: GPL
#
#-------------------------------------------------------------------------

MSG_HLP="
Uso : $(basename "$0") [OPCOES]

Opcoes:
-    -h    --> Mostra a tela de ajuda 
-    -g    --> Mostra a interface do programa
-    -V    --> Mostra a versao do programa"


#Variavel da bateria
bateria="BAT1" 

#Valor atual em mAh da bateria
VALOR_REAL=$(egrep '^rem' /proc/acpi/battery/$bateria/state | cut -d : -f 2 | tr mAh ' ')  



#Valor Total da Bateria em (mAh)
VALOR_TOTAL=$(egrep '^las' /proc/acpi/battery/$bateria/info | cut -d : -f 2 | tr mAh ' ') 


#Calculo de Porcentagem de carga
PORCENTAGEM=$(((VALOR_REAL*100)/VALOR_TOTAL)) #Calculo da Porcentagem


#Variavel de teste de carga

CARREGA="$(egrep '^char' /proc/acpi/battery/$bateria/state | cut -d : -f 2)"
while getopts ":hVgm" opcao
   do
     case "$opcao" in
       g)	(printf "%0.0f" $PORCENTAGEM; sleep 1 ) | dialog --title 'Nivel de Energia' --gauge "\nEstado da bateria :$CARREGA \nNivel de energia : "  8 60 80 
       exit 0;;

       V) echo -n $(basename "$0")
          echo
	  echo
          grep '^#Versao' "$0" | tail -1 | cut -d : -f 1 | tr -d \#
	  echo
	  exit 0 ;;

       h) echo "$MSG_HLP"
          exit 0 ;;

       \?) echo "Opcao invalida:" $OPTARG
         exit 1 ;;
       :) echo "Faltou argumento para : " $OPTARG
           echo 1
	   ;;
    esac
    shift
   done 

