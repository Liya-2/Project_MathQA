
for FILETYPE in train dev test
do

cat dataset/MathQA/$FILETYPE.json |\
awk -F ':' '{if (index($1, "Problem")>0 || index($1,"options")>0 || index($1,"correct")>0) print $2}' |\
awk '{if (NR%3==0) {print b"\t"$0; b=""} else b=b"\t"$0}' | \
sed 's/ [a-e] )/\t/g'| \
sed 's/ , /,/g' | sed 's/ \./\./g' \
> train.tsv
#sed 's/"//g' | sed 's/ [a-e] )/\t/g'| sed 's/\t\t/\t/g'| 

python pp.py > tmp

cat tmp | awk -F '\t' '{if($NF-1<=NF-2) print $0}' > $FILETYPE.tsv

done

cat dev.tsv >> train.tsv
rm dev.tsv
rm tmp
