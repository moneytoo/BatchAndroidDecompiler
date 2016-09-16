#!/bin/bash

. _tools

${APKTOOL} if ${SYSTEM}/framework/framework-res.apk
${APKTOOL} if ${SYSTEM}/framework/twframework-res.apk

for APP in SystemUI SecSettings2
do
	echo ${APP}
	APP_TYPE="app"
	if [ -d "${SYSTEM}/priv-app/${APP}/" ]; then
		APP_TYPE="priv-app"
	fi
	${APKTOOL} d --no-src ${SYSTEM}/${APP_TYPE}/${APP}/${APP}.apk -o ${OUT}/app-res/${APP} > /dev/null
	
	${OAT2DEX} -o ${OUT}/app-dex/ ${SYSTEM}/${APP_TYPE}/${APP}/oat/arm64/${APP}.odex ${SYSTEM}/framework/arm64/dex/
done
