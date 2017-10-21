#!/bin/bash

BAKSMALI="java -jar baksmali-2.1.3.jar"
CFR="java -jar cfr_0_118.jar"
APKTOOL="java -jar apktool_2.2.0.jar"
ENJARIFY="./enjarify/enjarify.sh"

OUT="./apks"

for APP in "Chrome_Beta-com.chrome.beta-62.0.3202.29-320202901"
do
	echo ${APP}
	NAME=${APP}
	APP_TYPE="app"

	if [ ! -d ${OUT}/app-res/${APP} ]; then
		${APKTOOL} d --no-src ${OUT}/${APP}.apk -o ${OUT}/app-res/${APP} > /dev/null
	fi

	if [ ! -d ${OUT}/app-smali/${NAME} ]; then
		mkdir ${OUT}/app-smali/${NAME}
		${BAKSMALI} ${OUT}/${APP}.apk -o ${OUT}/app-smali/${NAME}
	fi

	if [ ! -d ${OUT}/app-java/${NAME} ]; then
		mkdir -p ${OUT}/app-jar/
		${ENJARIFY} ${OUT}/${APP}.apk -o ${OUT}/app-jar/${NAME}.jar && \
			${CFR} ${OUT}/app-jar/${NAME}.jar --outputdir ${OUT}/app-java/${NAME} --silent true --caseinsensitivefs true
	fi

done