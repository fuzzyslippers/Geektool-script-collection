#!/usr/bin/env bash
function help() {
	echo "conditions.sh [-z ZIPCODE]"
	echo "USAGE:"
	echo "	z: Puts the zipcode entered in the URL."
	echo "ABOUT:"
	echo "	This script gets the weather conditions for a specified zipcode."
	echo "	Author: Nick Ippoliti"
	echo "	MD5 hash is in conditions.md5"
	echo "	Oh, and the zipcode of Beverly Hills is 90210."
}
ZIPCODE=
while getopts "z:" opt 
do
	case $opt in
		z) 
			ZIPCODE="$OPTARG";;
		[?]) eval help;;
	esac
done
URL="http://www.wunderground.com/cgi-bin/findweather/getForecast?query="$ZIPCODE
curl --silent -o weather.html "$URL"
grep '<span class="nobr"><span class="b">.*</span>&nbsp;&#176;F</span>' weather.html| awk 'NR==1 {print}' | sed ' s@<span class="nobr"><span class="b">@@' | sed ' s@</span>&nbsp;&#176;F</span>@@' | awk '{print $0," F"}'
rm -rf weather.html
exit