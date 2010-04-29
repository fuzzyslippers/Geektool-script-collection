#!/usr/bin/env bash
ZIPCODE=
while getopts "z:" opt 
do
	case $opt in
		z) 
			ZIPCODE="$OPTARG"
			;;
	esac
done
URL="http://www.wunderground.com/cgi-bin/findweather/getForecast?query="$ZIPCODE
curl --silent -o weather.html "$URL"
grep '<span class="nobr"><span class="b">.*</span>&nbsp;&#176;F</span>' weather.html| awk 'NR==1 {print}' | sed ' s@<span class="nobr"><span class="b">@@' | sed ' s@</span>&nbsp;&#176;F</span>@@' | awk '{print $0," F"}'
exit