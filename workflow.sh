#!/bin/bash

#Set the inputReads and reference -- change at your leisure
inputReads=filtered_subreads.fastq
reference=lambda_modified.fasta

echo "PIEMapping"
Honey.py pie $inputReads $reference -o mappingFinal.sam

echo "Sam To Bam"
samtools view -bt $reference mappingFinal.sam |
    samtools sort - > mappingFinal.bam
samtools index mappingFinal.bam

echo "Calling Tails"
Honey.py tails mappingFinal.bam

echo "Calling Spots"
Honey.py spots --reference $reference mappingFinal.bam

