#!/bin/bash
#SBATCH --job-name=RNAseq
#SBATCH --partition=biostat
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rgriffard@kumc.edu
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --mem=48gb
#SBATCH --time=24:00:00
#SBATCH --output=test%j.log

pwd; hostname; date
module load R
module load fastqc
module load rsem
ml load bowtie2
echo "Running R script"
Rscript fastq_practice.R
date