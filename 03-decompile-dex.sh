#!/bin/bash

. _tools

function wait_parallel {
	sleep 1
	while [ `jobs | wc -l` -ge "${THREADS}" ]
	do
		sleep 1
	done
}

function process_app {
	local FULLNAME="${1}"
	local NAME=`basename ${1} .dex`
	local TYPE="${2}"

	echo ${NAME}

	if [ ! -d ${OUT}/${TYPE}-smali/${NAME} ]; then
		${BAKSMALI} ${FULLNAME} -o ${OUT}/${TYPE}-smali/${NAME}
	fi

	if [ ! -d ${OUT}/${TYPE}-java/${NAME} ]; then
		${ENJARIFY} ${FULLNAME} -o ${OUT}/${TYPE}-jar/${NAME}.jar && \
			${CFR} ${OUT}/${TYPE}-jar/${NAME}.jar --outputdir ${OUT}/${TYPE}-java/${NAME} --silent true #--caseinsensitivefs true
	fi
}

for DIR in app framework
do
	for FILE in ${OUT}/${DIR}-dex/*.dex
	do
		echo ${FILE}
		#wait_parallel
		process_app ${FILE} ${DIR} # &
	done
done
