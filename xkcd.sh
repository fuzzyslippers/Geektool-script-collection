#!/usr/bin/env bash
#Get the HTML
get(){
	GETPAGE=$(curl --silent http://www.xkcd.com -o web.html)
	$GETPAGE
	#Find the URL
	grep '<img src="http://imgs.xkcd.com/comics/.*" title=".*" alt=".*" /><br/>' ./web.html >> temp1
	cat ./temp1 | awk '{print $2}' >> temp2
	cat ./temp2 | sed ' s@src="@@' | sed ' s@"@@' | awk 'NR==1 {print}' >> temp3
	#Save the picture
	PIC=$(cat temp3)
	wget --quiet $PIC -O xkcd.png
	#Remove temporary files
	rm -rf web.html
	rm -rf temp1
	rm -rf temp2
	rm -rf temp3
	rm -rf date
	echo "Saved as xkcd.png in" ~ 
}
dateCheck(){
	DATE=`date | awk '{print $1}'`
	if [ "$DATE" = "Tue" ]; then
		echo "No new comics."
	elif [ "$DATE" = "Sun" ]; then
		echo "No new comics."
	elif [ "$DATE" = "Thu" ]; then
		echo "No new comics."
	elif [ "$DATE" = "Fri" ]; then
		echo "No new comics."
	elif [ "$DATE" = "Sat" ]; then
		echo "No new comics."		
	fi 
	eval get
}
eval dateCheck