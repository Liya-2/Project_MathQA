
for FILETYPE in train dev test
do

cat dataset/MathQA/$FILETYPE.json | \
#remove commas from within numbers 
sed 's/\([0-9]\),\([0-9]\)/\1\2/g' | \
awk -F ':' '{if (index($1, "Problem")>0 || index($1,"options")>0 || index($1,"correct")>0) print $2}' |\
awk '{if (NR%3==0) {print b"\t"$0; b=""} else b=b"\t"$0}' | \
sed 's/[a|b|c|d|e] )/ /g'| \
sed 's/ , /,/g' | sed 's/ \./\./g' | sed 's/^\t//g' \
> $FILETYPE.tsv

python pp.py $FILETYPE.tsv > tmp
cat tmp | awk -F '\t' '{if($NF-1<=NF-2 && NF<=7) print $0}' > $FILETYPE.tsv

done

cat dev.tsv >> train.tsv
rm dev.tsv
rm tmp

#reorder the column ordering
for FILETYPE in train test
do
cat $FILETYPE.tsv | awk -F '\t' '{printf("%s\t%s",$1, $NF); for(i=2;i<NF;i++) printf("\t%s",$i); printf("\n");}' > tmp
mv tmp $FILETYPE.tsv 

done

