#!/bin/bash

. _tools

rm -rf ${OUT}

for DIR in dex jar java smali
do
	mkdir -p ${OUT}/framework-${DIR}
	mkdir -p ${OUT}/app-${DIR}
done

for ARCH in arm64 #arm
do
	for FILE in ${SYSTEM}/framework/oat/${ARCH}/*.odex ${SYSTEM}/framework/${ARCH}/*.oat
	do
		echo $FILE
		${BAKSMALI} deodex --bootclasspath ${SYSTEM}/framework/${ARCH}/boot.oat $FILE -o ${OUT}/framework-smali/`basename ${FILE%.*}`
		${SMALI} assemble ${OUT}/framework-smali/`basename ${FILE%.*}` -o ${OUT}/framework-dex/`basename ${FILE%.*}`.dex
	done

done
