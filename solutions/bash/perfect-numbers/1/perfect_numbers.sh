#!/usr/bin/env bash

n=$1
if((n<=0))
then
    echo "Classification is only possible for natural numbers."
    exit 1
fi
if((n==1))
then
    echo "deficient"
    exit 0
fi
sum=1
for((i=2;i*i<=n;i++))
do
    if((n%i==0))
    then
        ((sum+=i))
        if((i*i!=n))
        then
            ((sum+=n/i))
        fi
    fi
done
if((sum==n))
then
    echo "perfect"
elif((sum>n))
then
    echo "abundant"
else
    echo "deficient"
fi
