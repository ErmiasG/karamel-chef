#!/bin/bash

check()
{
    row=$(gcloud compute instances list | grep $job)
    PRIVATE_IP=$(echo $row | awk '{ print $4 }')
    PUBLIC_IP=$(echo $row | awk '{ print $5 }')
    echo -e "$job \t PUBLIC_IP: $PUBLIC_IP \t PRIVATE_IP: $PRIVATE_IP"
}

. config.sh
echo "Region: ${REGION}"

if [ $# -lt 1 ] ; then
    job="cpu${REGION/-/}"
    check
    job="gpu${REGION/-/}"
    check
    job="clu${REGION/-/}"
    check
else    
    if [ "$1" == "-h" ] ; then
	echo "Usage: $0 [benchmark]"
	exit 1
    fi
  reg="${REGION/-/}"    
  echo  "Head: "
  ben="ben${reg}"    
  gcloud compute instances list  | grep "$ben" | awk '{ print $4, $5 }'
  echo  "Compute: "
  gcloud compute instances list | grep -E "cp[0-9]{1,3}${reg}" | awk '{ print $4, $5 }'
  echo "GPU: "
  gcloud compute instances list | grep -E "gp[0-9]{1,3}${reg}" | awk '{ print $4, $5 }'
fi
