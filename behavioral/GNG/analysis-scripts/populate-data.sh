#!/bin/sh
#######################################
### use the parameter file as an    ###
### argument for the script         ###
### (e.g. sh move.sh moveParams.txt)###
#######################################


# Script to move the raw GNG behavioral files from the directories they are in to GNG analysis directory
# KD 2017.06.26

subs=(REV001 REV002 REV003 REV006 REV009 REV010 REV011 REV013 REV016 REV017 REV018 REV019 REV020 REV021 REV022 REV023 REV024 REV026 REV027 REV029 REV031 REV032 REV034 REV035 REV036 REV037 REV038 REV039 REV041 REV043 REV044 REV046 REV047 REV048 REV049 REV050 REV051 REV052 REV053 REV054 REV055 REV056 REV057 REV058 REV059 REV060 REV062 REV065 REV067 REV068 REV069 REV070 REV073 REV074 REV075 REV076 REV077 REV078 REV080 REV082 REV084 REV086 REV088 REV089 REV090 REV091 REV093 REV094 REV095 REV097 REV098 REV100 REV101 REV102 REV104 REV107 REV108 REV109 REV110 REV111 REV114 REV115 REV116 REV117 REV118 REV119 REV120 REV121 REV124 REV126 REV127 REV129 REV130 REV131 REV134 REV135 REV136 REV137 REV138 REV140 REV141 REV142 REV144)
destination="/Users/kristadestasio/Desktop/REV/GNG/data"
sourceDir="/Users/kristadestasio/Desktop/behavioral_data/"
base=(base)
end=(end)

cd $sourceDir/scanning
for i in ${subs[@]}
	do
	if [ -d $i ]
		then
		cd $i
		echo "$i scans"
		for j in ${base}
			do
			if [ -d $j ]
				then
				cd $j
				cd GNG
				echo "pre $i"
				for k in $(ls *.mat)
					do
					cp $k $destination/$k
					echo "copied"
				done
				cd ../..
				for j in ${end}
				do 
					if [ -d $j ]
						then
						cd $j
						cd GNG
						echo "post $i"
						for k in $(ls *.mat)
							do
							cp $k $destination/$k							
							echo "copied"
						done
						cd ../../..
					fi
				done
			fi
		done
	fi
done
cd $destination
mv REV13_REV_GNG4.txt_04-May-2015_10-25.mat REV013_REV_GNG4.txt_04-May-2015_10-25.mat
mv REV13_REV_GNG3.txt_04-May-2015_10-33.mat REV013_REV_GNG3.txt_04-May-2015_10-33.mat
mv 32_REV_GNG3.txt_10-Jul-2015_13-40.mat REV032_REV_GNG3.txt_10-Jul-2015_13-40.mat
mv 32_REV_GNG4.txt_10-Jul-2015_13-47.mat REV032_REV_GNG4.txt_10-Jul-2015_13-47.mat
mv 102_REV_GNG2.txt_19-Jan-2016_18-02.mat REV102_REV_GNG2.txt_19-Jan-2016_18-02.mat
mv 102_REV_GNG1.txt_19-Jan-2016_17-53.mat REV102_REV_GNG1.txt_19-Jan-2016_17-53.mat
for file in $(ls *.mat)
	do
		new=$(echo "$file" | sed -E 's/_REV//')
		mv $file $new
done
for file in $(ls *.mat)
	do
		new=$(echo "$file" | sed -E 's/.{22}\.mat/.mat/')
		mv $file $new
done



