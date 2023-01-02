#RNA seq pre-processing pipeline - fastQC & rsem
#Rachel Griffard
#092322

library(stringr)

#wd to locate files
wd <- "/panfs/pfs.local/home/r816g589/work/fastq"
ref <- "/panfs/pfs.local/work/biostat/d324p169/reference/fridleyRef/ucsc-mm10-rsem/mm10-rsem"

#names of files should be in format of #_R1.fastq and #_R2.fastq, with indicating the sample
#comp indicates numbers of sample
comp <- c(1:3, 5:7)

#ensure resource request matches number of threads
threads <- 8

for (i in comp) {
  #make folder for each combined file
  mkdir <- paste("mkdir ", wd, "/sample_", i, sep="")
  system(mkdir)
  #string of all files
  file <- paste(wd, "/", comp, "_R1", ".fastq ", wd, "/", comp, "_R2", ".fastq"
                ,sep="")
  files <- paste(file, sep=" ")
}
#collapse into single string
files <- str_c(files, collapse=" ")

#fastqc for all files
system(paste("fastqc -o ", wd, "/fastqc -f fastq -t ",
            threads, " ", files, sep=""))

#rsem for all files
#for creating new project without rsem file, but exists in hpc already
#system(paste("rsem-prepare-reference ", ref, sep=""))
for (i in comp) {
  system(paste("rsem-calculate-expression -p ", threads, " --bowtie2 --paired-end --output-genome-bam ",
               wd, "/", i, "_R1.fastq ", wd, "/", i, "_R2.fastq ",
               ref, " ", wd, "/sample_", i,"/rsemR_", i, sep=""))
}