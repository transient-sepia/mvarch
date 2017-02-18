#!/usr/bin/env bash
#
# version 0.1
# / pin. /
#

# location of archivelogs with mask
FROM="/u99/app/oracle/admin/orcl/arch/*.arc"
# where to move files
DIR="/u02/arch"
# number of files to move
NUM=20

# main
COUNTER=1
for F in ${FROM}; do
  if [[ ${COUNTER} -le ${NUM} ]]; then
    if [[ ! -d ${DIR} ]]; then
      mkdir -p ${DIR}
      if [[ $? != 0 ]]; then
        printf "Failed to create directory ${DIR}.\n"
        exit 1
      else
        printf "Directory ${DIR} was created.\n"
      fi
    else
      mv ${F} ${DIR}
      LINK=$(basename ${F})
      ln -s ${DIR}/${LINK} ${F}
      let COUNTER+=1
    fi
  fi
done
let COUNTER-=1
printf "Done. Moved ${COUNTER} files. Don't forget to remove them from ${DIR} afterwards.\n"

# exit
exit 0
