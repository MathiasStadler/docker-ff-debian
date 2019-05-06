XAUTH=/tmp/.docker.xauth
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | sudo xauth -f $XAUTH nmerge -
sudo chmod 777 $XAUTH
X11PORT=`echo $DISPLAY | sed 's/^[^:]*:\([^\.]\+\).*/\1/'`
TCPPORT=`expr 6000 + $X11PORT`
DISPLAY=`echo $DISPLAY | sed 's/^[^:]*\(.*\)/localhost\1/'`
#DISPLAY=`echo $DISPLAY | sed 's/^[^:]*\(.*\)/10.0.2.2\1/'`
#DISPLAY=`echo $DISPLAY | sed 's/^[^:]*\(.*\)/172.17.0.1\1/'`
echo $DISPLAY
xauth list
sudo docker run -ti --rm -e DISPLAY=$DISPLAY -v $XAUTH:$XAUTH \
   -e XAUTHORITY=$XAUTH ff/debian:v1
