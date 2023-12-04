#!/bin/bash
for i in 1 2 3 4
do
# trimming
fastp --thread 8 --in1 rawdata/merge_0${i}_1.fastq.gz --in2 rawdata/merge_0${i}_2.fastq.gz --out1 trimed/0${i}_1_trim.fastq.gz --out2 trimed/0${i}_2_trim.fastq.gz --detect_adapter_for_pe &
done
wait
for i in 1 2 3 4
do
bwa mem -t 16 data/Danio_rerio.GRCz11.dna.primary_assembly-only-chr.fa trimed/0${i}_1_trim.fastq.gz trimed/0${i}_2_trim.fastq.gz -o sam/0${i}.sam
done
for i in 1 2 3 4
do
rm trimed/0${i}_*_trim.fastq.gz &
#
# samからbamに変換
samtools view -h sam/0${i}.sam | awk '$17 !~ /XA:/|| $1 ~ /^@/' | samtools view -bS - > bam/0${i}.uniq.bam &
done
wait
for i in 1 2 3 4
do
rm sam/0${i}.sam
samtools sort bam/0${i}.uniq.bam > bam/0${i}.uniq.sort.bam &
done
wait

