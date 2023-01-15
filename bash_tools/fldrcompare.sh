#bash
#compare two folders, ignore file extensions, see whats missing
find srcpngjpg  -type f -printf "%f\n" | sed 's/\.[^.]*$//' | sort > list1.txt
find avif  -type f -printf "%f\n" | sed 's/\.[^.]*$//' | sort > list2.txt
diff list1.txt list2.txt
#comm -23 list1.txt list2.txt
