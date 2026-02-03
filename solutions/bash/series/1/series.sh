#!/usr/bin/env bash

s=$1
n=${#s}
len=$2
if((n==0))
then 
    echo "series cannot be empty"
fi
if((len>n))
then
    echo "slice length cannot be greater than series length"
    exit 1
fi
if((len==0))
then
    echo "slice length cannot be zero"
    exit 1
fi
if((len<0))
then
    echo "slice length cannot be negative"
    exit 1
fi

ans=()
for((i=0;i<=n-len;i++))
do
    ans[i]=${s:i:len}
done
echo ${ans[@]}
