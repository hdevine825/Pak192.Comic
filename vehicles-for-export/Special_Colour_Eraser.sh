#!/bin/bash

#set -e

farbset_rot=('#511111' '#661111' '#811111' '#991111' '#B11111' '#CC1111' '#E11111' '#FF1111')
farbset_dunkelrot=('#211111' '#331111' '#511111' '#661111' '#811111'  '#991111' '#B11111' '#CC1111')
farbset_blau=('#0f0f7e' '#14148e' '#1818a6' '#1e1ec0' '#2323ce' '#2a2ada' '#3131ed' '#3f3fff')
farbset_dunkelblau=('#040445' '#0d0d6f' '#0f0f7e' '#14148e' '#1818a6' '#1e1ec0' '#2323ce' '#2a2ada')
farbset_gruen=('#115111' '#116611' '#118111' '#119911' '#11B111' '#11CC11' '#11E111' '#11FF11')
farbset_dunkelgruen=('#112111' '#113311' '#115111' '#116611' '#118111' '#119911' '#11B111' '#11CC11')
farbset_tuerkies=('#115151' '#116666' '#118181' '#119999' '#11B1B1' '#11CCCC' '#11E1E1' '#11FFFF')
farbset_gelb=('#515111' '#666611' '#818111' '#999911' '#B1B111' '#CCCC11' '#E1E111' '#FFFF11')
farbset_knallgelb=('#756f1b' '#867f20' '#9e9523' '#b3a825' '#ccc029' '#ded024' '#eede18' '#fdeb0a')

#farbset_SF1('#244B67' '#395E7C' '#4c7191' '#6084a7' '#7497bd' '#88abd3' '#9cbee9' '#B0D2FF')
#farbset_SF2=('#7B5803' '#8E6F04' '#A18605' '#B49D07' '#C6B408' '#D9CB0A' '#ECE20B' '#FFF90D')


convertpng() {

	local oldimage=$1

	#echo $oldimage
	#convert $oldimage -transparent '#e7ffff' -transparent '#000000' -transparent '#001eff' $oldimage
	convert $oldimage -channel A -threshold 150 $oldimage
	convert $oldimage -transparent '#e7ffff' -transparent '#001eff' $oldimage
	#convert Test.png -transparent '#000000' Test.png

	#Converting first player colour
	convert $oldimage -fill ${2} -opaque '#244B67' -fill ${3} -opaque '#395E7C' -fill ${4} -opaque '#4c7191' -fill ${5} -opaque '#6084a7' -fill ${6} -opaque '#7497bd' -fill ${7} -opaque '#88abd3' -fill ${8} -opaque '#9cbee9' -fill ${9} -opaque '#B0D2FF' $oldimage
	
	#Converting second player colour
	convert $oldimage -fill ${10} -opaque '#7B5803' -fill ${11} -opaque '#8E6F04' -fill ${12} -opaque '#A18605' -fill ${13} -opaque '#B49D07' -fill ${14} -opaque '#C6B408' -fill ${15} -opaque '#D9CB0A' -fill ${16} -opaque '#ECE20B' -fill ${17} -opaque '#FFF90D' $oldimage
}

decide_colours() {

	local oldimage=$1

	if [[ $oldimage =~ "EW_IV" ]] ; then
		convertpng $oldimage ${farbset_rot[@]} ${farbset_dunkelgruen[@]}
	elif [[ $oldimage =~ "U-Bahn_Hamburg" || $oldimage =~ "_DB" ]] ; then
		convertpng $oldimage ${farbset_rot[@]} ${farbset_knallgelb[@]}
	elif [[ $oldimage =~ "CD_"  || $oldimage =~ "U-Bahn_Munchen" || $oldimage =~ "4010" || $oldimage =~ "4020" || $oldimage =~ "LNVG" || $oldimage =~ "Electric_2019_Desiro_ML_ODEG" ]] ; then
		convertpng $oldimage ${farbset_blau[@]} ${farbset_knallgelb[@]}
	elif [[ $oldimage =~ "Railjet" ]] ; then
		convertpng $oldimage ${farbset_rot[@]} ${farbset_dunkelrot[@]}
	elif [[ $oldimage =~ "BWegt" || $oldimage =~ "U-Bahn_Berlin"  || $oldimage =~ "SSB" || $oldimage =~ "E-BV" ]] ; then
		convertpng $oldimage ${farbset_knallgelb[@]} ${farbset_blau[@]}
	elif [[ $oldimage =~ "DSB" ]] ; then
		convertpng $oldimage ${farbset_rot[@]} ${farbset_dunkelblau[@]}
	elif [[ $oldimage =~ "E231-500" || $oldimage =~ "E235-0" || $oldimage =~ "Ustra" || $oldimage =~ "Nordbahn" ]] ; then
		convertpng $oldimage ${farbset_gruen[@]} ${farbset_gruen[@]}
	elif [[ $oldimage =~ "Stadtbahn_Frankfurt_U4" || $oldimage =~ "Stadtbahn_Frankfurt_U5" || $oldimage =~ "Electric_2004_Flirt" || $oldimage =~ "Electric_2014_Flirt3" || $oldimage =~ "NahSH" || $oldimage =~ "nahsh" ]] ; then
		convertpng $oldimage ${farbset_tuerkies[@]} ${farbset_gelb[@]}
	else
		convertpng $oldimage ${farbset_rot[@]} ${farbset_blau[@]}
	fi
}

readallfiles() {
	local directionary=$1
	IFS='
	'
	if [ ${#directionary[@]} -gt 0 ] ; then

	  	for png in $directionary ; do

	  		if [ -f "$png" ] ; then
				echo "-- Performing Work At: $png "
				decide_colours $png
			fi
		done
	fi
}

echo "==== Special Colour Eraser ===="
readallfiles '../ToBeExported/image/*.png'
readallfiles '../ToBeExported/tram_image/*.png'
readallfiles '../ToBeExported/**/image/*.png'
readallfiles '../ToBeExported/**/tram_image/*.png'
echo "==== done ===="
# pause