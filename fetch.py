# fetch.py uses Biopython Entrez to download full protein information of interest from Genbank
# make sure to have an input text file containing all accession numbers of protein of interest

#!/usr/bin/env python
"""Fetch GenBank entries for given accessions. 

USAGE:
 
  cat input.txt | python fetch.py > out.gb

DEPENDENCIES:
Biopython
"""

import sys
from Bio import Entrez

#define email for entrez login
db           = "protein"
Entrez.email = "youremail@email.com"

#load accessions from arguments
if len(sys.argv[1:]) > 1:
  accs = sys.argv[1:]
else: #load accesions from stdin  
  accs = [ l.strip() for l in sys.stdin if l.strip() ]
#fetch
sys.stderr.write( "Fetching %s entries from GenBank: %s\n" % (len(accs), ", ".join(accs[:10])))
for i,acc in enumerate(accs):
  try:
    sys.stderr.write( " %9i %s          \r" % (i+1,acc))  
    handle = Entrez.efetch(db=db, rettype="gb", id=acc)
    #print output to stdout
    sys.stdout.write(handle.read())
  except:
    sys.stderr.write( "Error! Cannot fetch: %s        \n" % acc)  
