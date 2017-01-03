import sys 

fasta= open(sys.argv[1])
newnames= open(sys.argv[2])
newfasta= open(sys.argv[3], 'w')

for line in fasta:
    if line.startswith('>'):
        newname= newnames.readline()
        newfasta.write(">"+newname)
    else:
        newfasta.write(line)

fasta.close()
newnames.close()
newfasta.close()
