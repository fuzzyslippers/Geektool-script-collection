function help() {
	echo "conditions.sh [-z ZIPCODE]"
	echo "USAGE:"
	echo "	z: Puts the zipcode entered in the URL."
	echo "ABOUT:"
	echo "	This script gets the weather conditions for a specified zipcode."
	echo "	Author: Nick Ippoliti"
	echo "	MD5 hash is in conditions.md5"
}
clear;
while getopts "z:h" arg; do
	case "$arg" in
		z) ZIPCODE="$OPTARG";;
		h) eval help;;
		[?]) eval help;;
	esac
done
curl --silent "http://www.wunderground.com/cgi-bin/findweather/getForecast?query="$ZIPCODE -o temp1
grep '<div class="b" style="font-size: 14px;">.*</div>' temp1 | sed 's@<div class="b" style="font-size: 14px;">@@'|sed 's@</div>@@' |sed 's@		@@'
rm -rf temp1