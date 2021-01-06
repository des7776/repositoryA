# Run iqtree on many loci in an array-like format on the cluster  
## Sophia MacRae Orzechowski  
## 12 May 2020  

### Adapted from G. Bravo's suggestions and advise

1. Set scripts variable
```bash
SCRIPTS="/n/holylfs/LABS/edwards_lab/smorzechowski/meliphagid/scripts/"
```

2. Use sbatch script 07_iqtree_array.sh
```bash
#!/bin/bash
#SBATCH -J iqtree_array  # A single job name
#SBATCH -p test  # Partition to submit to
#SBATCH -n 2             # Number of cores
#SBATCH -N 1 # All cores on one machine
#SBATCH -t 0-4:00      # Runtime in days-hours:minutes
#SBATCH --mem 12000       # Memory in MB
#SBATCH -J iqtree_array         # job name
#SBATCH -o iqtree_array.%A.out        # File to which standard out will be written
#SBATCH -e iqtree_array.%A.err        # File to which standard err will be written
#SBATCH --mail-type=ALL        # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=smorzechowski@g.harvard.edu  # Email to which notifications will be sent
#SBATCH --account=oeb275r

module purge
module load gcc/7.1.0-fasrc01 iqtree/1.6.10-fasrc01

./uce_phy${SLURM_ARRAY_TASK_ID}.txt
```

3. Create a txt file with all commands created with ls and sed
```bash
# Make a text file of all the file names, make sure the format is uce_phy{NUM}.txt to match the sbatch file 
ls *.phy > uce_phy2.txt

# To add strings before each line in a text file using sed: 
sed -e 's|^|'iqtree' '-s' '/n/holyscratch01/edwards_lab/smorzechowski/meliphagid/analysis/2020-05-08/data/phy2/'|' -i uce_phy2.txt

# To add strings after each line in a text file using sed:
sed -e 's|$| '-nt' '2'|' -i uce_phy2.txt

# To make all files in a folder executable:
chmod +x /n/holyscratch01/edwards_lab/smorzechowski/meliphagid/analysis/2020-05-08/data/phy2/*
```

4. Add commands to run again with outgroup and prefix! 
```bash
# To add strings after each line in a text file using sed:
sed -e 's|$| '-o' '"Caracara_cheriway"' '-pre' 'outgroup' '-redo'|' -i uce_phy2.txt

```
5. Remove/replace commands to run again
```bash
sed -i 's/'-pre' 'outgroup' '-redo'//g' uce_phy1.txt

sed -e 's|'Caracara_cheriway'|'\"Caracara_cheriway\"'|g' -i uce_phy1.txt
```

5. Run the array! 
```bash
# navigate to the folder with all the files you want IQTREE to estimate gene trees for
sbatch --array=2 $SCRIPTS/07_iqtree_array.sh
```
