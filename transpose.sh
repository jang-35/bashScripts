if [ $# -lt 2 ] ; then   
    echo "error: less than 2 parameters">&2  
    exit 1;  
fi  
  
src=$1  
tgt=$2  
  
mkdir "$tgt"  
if [ $? '!=' 0 ] ; then  
    echo "error: could not create directory \""$tgt"\"">&2  
    exit 2;  
fi  
  
for i in "$src"/* ; do   
  
    root=$(basename "$i")  
    for j in "$i"/* ; do  
        base=$(basename "$j")  
        mkdir -p "$tgt"/"$base"/"$root"  
        cp -R "$src"/"$root"/"$base/." "$tgt"/"$base"/"$root"  
    done  
done 