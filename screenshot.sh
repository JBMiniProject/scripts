#!/bin/bash

# names and extensions
export FN=`date +%F_%H%M%S%N`
export EXT="fb0"
export CODEC="png"
export RES=$1

# input/output files and folder name
export SINPUT=$FN"."$EXT
export SOUTPUT=$FN"_"$RES"."$CODEC
export SCSH="screenshots"

if [ ! "$RES" ];
    then
    echo "
Error: You forgot to add usage parameter...
  Usage: . screenshot.sh device resolution

  Example: .screenshot.sh 320x480";
else
    if [ ! -d "$SCSH" ];
        then
        mkdir $SCSH
        export CRTDIR="ok"
    else
        export CRTDIR=""
    fi

    adb pull /dev/graphics/fb0 $SINPUT
    ffmpeg -vframes 1 -vcodec rawvideo -f rawvideo -pix_fmt rgb565 -s $RES -i $SINPUT -f image2 -vcodec $CODEC $SCSH"/"$SOUTPUT

    rm $SINPUT
    clear

    if [ $CRTDIR ];
        then
        echo "The folder: $SCSH sucessfully created!"
    fi

    if [ -e $SCSH"/"$SOUTPUT ]
        then
        echo "The screenshot name $SOUTPUT"
    else
        echo "Error: Screenshot doesn't created!!!"
    fi
fi
