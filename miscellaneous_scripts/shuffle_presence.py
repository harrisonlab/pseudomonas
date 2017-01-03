import sys 

##f = open("9646_effectors_blast.csv")

effector = sys.argv[1]
shuf = sys.argv[2]

E = open(effector)
S = open(shuf)

for line in S:
    cols = line.strip() 
    shuffled = cols[0]
    print shuffled

#for line in E:
 #   cols = line.strip().split("\t")
  #  print cols[0] + "\t" +  shuffled + "\t" + cols[2]
exit
