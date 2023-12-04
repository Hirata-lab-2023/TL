# TL マッピング
### Mapping tools　<br>
  - seqkit (2.1.0)<br>
  - fastp (0.20.1)<br>
  - bwa-mem (0.7.17)<br>
  - samtools (1.13)<br>
## 解析環境の構築
```
git clone https://github.com/Hirata-lab-2023/TL.git
mkdir TL/{data,rawdata,trimed,sam,bam}
cd TL
```
## リファレンスゲノムの入手・編集
リファレンスゲノム (GRCz11) をダウンロード<br>
```
wget　-P data https://ftp.ensembl.org/pub/release-101/fasta/danio_rerio/dna/Danio_rerio.GRCz11.dna.primary_assembly.fa.gz
```
リファレンスゲノムとして用いる配列情報の抽出 (Chr 1~25 and MT) 
```
for i in `cat chr_mt.txt`
do
seqkit grep -p ${i} data/Danio_rerio.GRCz11.dna.primary_assembly.fa >> data/Danio_rerio.GRCz11.dna.primary_assembly-only-chr.fa
done
```
リファレンスゲノムの index の作成
```
# bwa
bwa index data/Danio_rerio.GRCz11.dna.primary_assembly-only-chr.fa

# samtools
samtools faidx data/Danio_rerio.GRCz11.dna.primary_assembly-only-chr.fa
```

## 生データのマージとシンボリックリンクの作成
***`データの保存先`は自身の生データ保存先に変更してから実行***
```
# fastq のマージ
count=NULL
for i in 07 09 11 13
do
t=`expr ${i} + 1`
((count++))
cat　'データの保存先'/JN00012150-mizoguchi/rawdata/TL-0${i}-0${i}_1.fastq.gz 'データの保存先'/JN00012150-mizoguchi/rawdata/TL-0${t}-0${t}_1.fastq.gz > 'データの保存先'/JN00012150-mizoguchi/rawdata/merge_0${count}_1_fastq.gz &
cat　'データの保存先'/JN00012150-mizoguchi/rawdata/TL-0${i}-0${i}_2.fastq.gz 'データの保存先'/JN00012150-mizoguchi/rawdata/TL-0${t}-0${t}_2.fastq.gz > 'データの保存先'/JN00012150-mizoguchi/rawdata/merge_0${count}_2_fastq.gz
done
```

```
# rawdata にシンボリックリンクの作成
for i in 1 2 3 4
do
ln -s 'データの保存先'/JN00012150-mizoguchi/rawdata/merge_0${i}_*_fastq.gz rawdata/
done
```

## マッピングの実行
***以下の作業は時間がかかるため、バックグラウンドでの解析を推奨 (nohup)***
```
bash mizoguchi.sh
```










