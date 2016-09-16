#!/bin/bash

. _tools

rm -rf ${OUT}

for DIR in dex jar java smali
do
	mkdir -p ${OUT}/framework-${DIR}
	mkdir -p ${OUT}/app-${DIR}
done

for ARCH in arm arm64
do
	${OAT2DEX} boot ${SYSTEM}/framework/${ARCH}/boot.oat
	#${OAT2DEX} -o ${OUT}/framework-boot-${ARCH}/ boot ${SYSTEM}/framework/${ARCH}/boot.oat
	
	for FILE in ${SYSTEM}/framework/oat/${ARCH}/*
	do
		echo $FILE
		${OAT2DEX} -o ${OUT}/framework-dex/ $FILE ${SYSTEM}/framework/${ARCH}/dex/
		#${OAT2DEX} -o ${OUT}/framework-dex/ $FILE ${OUT}/framework-boot-${ARCH}/
	done
done

cp -r ${SYSTEM}/framework/oat/arm*/*.dex ${OUT}/framework-dex
