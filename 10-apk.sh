#!/bin/bash

BAKSMALI="java -jar baksmali-2.2.1.jar"
CFR="java -jar cfr_0_123.jar"
APKTOOL="java -jar apktool_2.3.0.jar"
ENJARIFY="./enjarify/enjarify.sh"

OUT="./apks"

for APP in "imsservice"
do
	echo ${APP}
	NAME=${APP}
	APP_TYPE="app"

	if [ ! -d ${OUT}/app-res/${APP} ]; then
		${APKTOOL} d --no-src ${OUT}/${APP}.apk -o ${OUT}/app-res/${APP} > /dev/null
	fi

	if [ ! -d ${OUT}/app-smali/${NAME} ]; then
		mkdir -p ${OUT}/app-smali/${NAME}
		${BAKSMALI} disassemble ${OUT}/${APP}.apk -o ${OUT}/app-smali/${NAME}
	fi

	if [ ! -d ${OUT}/app-java/${NAME} ]; then
		mkdir -p ${OUT}/app-jar/
		${ENJARIFY} ${OUT}/${APP}.apk -o ${OUT}/app-jar/${NAME}.jar && \
			${CFR} ${OUT}/app-jar/${NAME}.jar --outputdir ${OUT}/app-java/${NAME} --silent true --caseinsensitivefs true
	fi

done