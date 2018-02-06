
# Splitting effector file up into pairwise comparisons
for n in `seq 1 65` ; do
first=$(echo $n)
for i in `seq 2 65` ; do
second=$(echo $i)
cut -f1,$first,$second effectors.txt > ./files/"$n"_"$i" 
done 
done


for file in * ; do
mv $file $(head -1 $file| sed s/"effector\t"//g | sed s/"\t"/"_"/g)

