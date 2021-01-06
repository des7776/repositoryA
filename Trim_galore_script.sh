#!/bin/bash
#SBATCH -p serial_requeue
#SBATCH -n 30
#SBATCH -N 1
#SBATCH --mem 120000
#SBATCH -t 2-00:00
#SBATCH -J Trim_Climac2
#SBATCH -o Trim_Climac2_%j.out
#SBATCH -e Trim_Climac_2%j.err
#SBATCH --mail-type=ALL        # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=strauss224@yahoo.com  # Email to which notifications will be sent

# load TrimGalore module and fastqc module of choice 

    module load TrimGalore
    module load fastqc

# change to directory that fastq sequencing files are in (concatenated R1 and concatenated R2 to one separate file each)

    cd /Path_TO_Directory/  

# add unique parts of filename separated by a space and loop the different files

for i in [List of unique part of file name each separated by a space ] 

do

  # trim excess adaptor content and reads under 100 base pairs, retain the unpaired reads and perform fastqc on trimmed reads
  # For R1 and R2 with the following file name structure PREP0022_DStra10037A_B03v1_57746_S77_L001_R1_001.fastq.gz PREP0022_DStra10037A_B03v1_57746_S77_L001_R2_001.fastq.gz, loop the unique part

     trim_galore --phred33 --fastqc --paired --retain_unpaired -r1 100 -r2 100 PREP0022_DStra10037A_${i}L001_R1_001.fastq.gz PREP0022_DStra10037A_${i}L001_R2_001.fastq.gz

	# Move individual files produced by TrimGalore and Fastqc to their respective subdirectories...

		mv *val_1.fq.gz val_2.fq.gz ./trimmed
		mv *fastqc.html ./fastqc_html
		mv *fastqc.zip ./fastqc_zip
		mv *unpaired_1.fq.gz unpaired_2.fq.gz ./unpaired

done



 

 
