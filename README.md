# Dr.Mizoguchi
### SNPs call　<br>
  - fastq-dump (2.11.3)<br>
  - fastp (0.20.1)<br>
  - bwa-mem (0.7.17)<br>
  - gatk (4.4.0.0)<br>
  - vcftools (0.1.16)<br>
  - samtools (1.13)<br>
## 解析環境の構築
mkdir TL
mkdir TL/{data,rawdata,trimed,sam,bam}
cd TL
## Download DNA sequence
リファレンスゲノム (GRCz11) をダウンロード<br>
```
wget　-P data https://ftp.ensembl.org/pub/release-101/fasta/danio_rerio/dna/Danio_rerio.GRCz11.dna.primary_assembly.fa.gz
```
リファレンスゲノムとして用いる配列情報の抽出 (Chr 1~25 and MT) 
```
wget 
for i in `cat chr_mt.txt`
do
seqkit grep -p ${i} data/Danio_rerio.GRCz11.dna.primary_assembly.fa >> data/Danio_rerio.GRCz11.dna.primary_assembly-only-chr.fa
done
```
