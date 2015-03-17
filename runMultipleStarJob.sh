#!/bin/bash
#Script written by Thomas Wentworth, contact at twentworth@gmail.com

#SGE Options:
#-----------------------------------------------------------------------------------

#Nodes To Request
nNodes=8

#e-mail address (blank for no e-mail):
eMail=twentworth@gmail.com

#Job Name (what appears in the qstat command)
jobName=starJob

#Specify qsub queue
specifyQ=True
qsubQ=test.q

#virtualEnv To Activate
activateVirtualEnv=True
virtualEnv=~/py27/bin/activate


#STAR Options:
#-----------------------------------------------------------------------------------

#Star location (where is the star program?)
starLoc=/home/tawentwo/STAR-STAR_2.4.0h/bin/Linux_x86_64_static/STAR

#Star Threads (how many processing threads do you want, on ROUS this would be 8, or maybe 16 if you think hyperthreading might help)
starThreads=16

#Paired ends or not paired ends (enter True or False)
paired=True

#Output Directory (where do you want to save everything?)
outDir=/home/tawentwo/hg19/furling_deleteThisRun

#Which STAR annotation file do you wish to use?
genomeDir=/home/tawentwo/hg19/starGenomeDir_spike_ensKnownRefSeq

#Folder where Fastq files are located
pathToFastqFiles=/home/et_wang/furling/fastq

#List of reads and output name (in the fastQ folder)
#For paired readsm format like this : 
#readFilesIn = (fileA_1 fileA_2 fileAOutputName \
#	fileB_1 fileB_2 fileBOutputName \
#	fileC_1 fileC_2 fileCOutputName)
#For non-paired readsm format like this : 
#readFilesIn = (fileA fileAOutputName \
#	fileB fileBOutputName \
#	fileC fileCOutputName)
#If a name or filename needs a space, use '\ ' instead of ' '

readFilesIn=( C467_RE_B00GGOZ_1_1_C5TPLACXX.IND12.fastq.gz	C467_RE_B00GGOZ_1_2_C5TPLACXX.IND12.fastq.gz     C25-40h-indCTG-3 \
C467_RE_B00GGPI_5_1_C5VH9ACXX.IND6.fastq.gz	C467_RE_B00GGPI_5_2_C5VH9ACXX.IND6.fastq.gz     C25-20h-indCTG-1 \
C467_RE_B00GGPJ_6_1_C5VH9ACXX.IND6.fastq.gz	C467_RE_B00GGPJ_6_2_C5VH9ACXX.IND6.fastq.gz     C25-20h-indCTG-2 \
C467_RE_B00GGPK_7_1_C5VH9ACXX.IND6.fastq.gz	C467_RE_B00GGPK_7_2_C5VH9ACXX.IND6.fastq.gz     C25-20h-indCTG-3 \
C467_RE_B00GGPL_1_1_C5R54ACXX.IND6.fastq.gz	C467_RE_B00GGPL_1_2_C5R54ACXX.IND6.fastq.gz     C25-20h-plus-indCTG-1 \
C467_RE_B00GGPM_2_1_C5R54ACXX.IND6.fastq.gz	C467_RE_B00GGPM_2_2_C5R54ACXX.IND6.fastq.gz     C25-20h-plus-indCTG-2 \
C467_RE_B00GGPN_3_1_C5R54ACXX.IND6.fastq.gz	C467_RE_B00GGPN_3_2_C5R54ACXX.IND6.fastq.gz     C25-20h-plus-indCTG-3 \
C467_RE_B00GGPO_4_1_C5R54ACXX.IND6.fastq.gz	C467_RE_B00GGPO_4_2_C5R54ACXX.IND6.fastq.gz     C25-40h-plus-indCTG-1 \
C467_RE_B00GGPP_5_1_C5R54ACXX.IND6.fastq.gz	C467_RE_B00GGPP_5_2_C5R54ACXX.IND6.fastq.gz     C25-40h-plus-indCTG-2 \
C467_RE_B00GGPQ_5_1_C5VH9ACXX.IND12.fastq.gz	C467_RE_B00GGPQ_5_2_C5VH9ACXX.IND12.fastq.gz     C25-40h-plus-indCTG-3 \
C467_RE_B00GGPR_6_1_C5VH9ACXX.IND12.fastq.gz	C467_RE_B00GGPR_6_2_C5VH9ACXX.IND12.fastq.gz     C25-60h-indCTG-1 \
C467_RE_B00GGPS_7_1_C5VH9ACXX.IND12.fastq.gz	C467_RE_B00GGPS_7_2_C5VH9ACXX.IND12.fastq.gz     C25-60h-indCTG-2 \
C467_RE_B00GGPT_1_1_C5R54ACXX.IND12.fastq.gz	C467_RE_B00GGPT_1_2_C5R54ACXX.IND12.fastq.gz     C25-60h-indCTG-3 \
C467_RE_B00GGPU_2_1_C5R54ACXX.IND12.fastq.gz	C467_RE_B00GGPU_2_2_C5R54ACXX.IND12.fastq.gz     C25-60h-plus-indCTG-1 \
C467_RE_B00GGPV_3_1_C5R54ACXX.IND12.fastq.gz	C467_RE_B00GGPV_3_2_C5R54ACXX.IND12.fastq.gz     C25-60h-plus-indCTG-2 \
C467_RE_B00GGPW_4_1_C5R54ACXX.IND12.fastq.gz	C467_RE_B00GGPW_4_2_C5R54ACXX.IND12.fastq.gz     C25-60h-plus-indCTG-3 \
C467_RE_B00GGPX_5_1_C5R54ACXX.IND12.fastq.gz	C467_RE_B00GGPX_5_2_C5R54ACXX.IND12.fastq.gz     C25-60h-siMBNL12-1 \
C467_RE_B00GGPY_1_1_C5TPLACXX.IND6.fastq.gz	C467_RE_B00GGPY_1_2_C5TPLACXX.IND6.fastq.gz     C25-60h-siMBNL12-2 \
C467_RE_B00GGPZ_4_1_C5TM5ACXX.IND6.fastq.gz	C467_RE_B00GGPZ_4_2_C5TM5ACXX.IND6.fastq.gz     C25-60h-siMBNL12-3 \
C467_RE_B00GGQ0_6_1_C5R54ACXX.IND12.fastq.gz	C467_RE_B00GGQ0_6_2_C5R54ACXX.IND12.fastq.gz     C25-40h-indCTG-1 \
C467_RE_B00GGQ1_4_1_C5TM5ACXX.IND12.fastq.gz	C467_RE_B00GGQ1_4_2_C5TM5ACXX.IND12.fastq.gz     C25-40h-indCTG-2 )

#Options : 
#format like this:
#options=(option1Name option1Value \
#	option2Name option2Value \
#	option3Name option3Value)
#If a option value needs a space, use '\ ' instead of ' '

options=(outFilterMismatchNoverReadLmax .06 \
outFilterMismatchNmax 999 \
readFilesCommand zcat \
outFilterScoreMinOverLread 0.8 \
outFilterMismatchNoverLmax .06 \
outFilterMatchNmin 0 \
outFilterMatchNminOverLread .9 \
alignEndsType EndToEnd \
limitBAMsortRAM 30000000000
outFilterMultimapNmax 1 \
outFilterMultimapScoreRange 0 \
outSAMtype BAM\ SortedByCoordinate \
genomeLoad NoSharedMemory)






#DO NOT EDIT BELOW THIS LINE!!!!!
#-------------------------------------------------------------------------------------------------------------------------------------


#MAKE SURE THAT WE DON'T OVERWRITE DIRECTORY

if [ -d "$outDir" ]
then
	dirAdd=1
	while [ -d "${outDir}_${dirAdd}" ]
	do
		let "dirAdd+=1"
	done
	outDir=${outDir}_${dirAdd}
fi

#make the directory
mkdir -p ${outDir}


#Make command
strHead='#!/bin/bash\n#$ -S /bin/bash\n#$ -N '$jobName'\n#$ -cwd\n#$ -m bea\n#$ -M '${eMail}'\n#$ -pe whole_nodes '$nNodes'\n'

if [[ paired ]]; then
	div=3
else
	div=2
fi

optionString=''
for i in  ${!options[@]};
do
	if [ $(( i % 2 )) != 0 ];
		then
		continue
	fi
	optionString=${optionString}'--'${options[i]}' '${options[i+1]}' '
done

tmpFileSt=`cat /dev/urandom | env LC_CTYPE=C tr -dc "a-zA-Z0-9" | head -c10`
for i in ${!readFilesIn[@]};
do
	if [ $(( i % div )) != 0 ];
	then
		continue
	fi
	runStr=$strHead
	if [[ activateVirtualEnv ]]; then
		runStr=$runStr'\nsource '${virtualEnv}'\n'
	fi
	runStr=$runStr'\n'$starLoc' --genomeDir '${genomeDir}
	if [[ paired ]]; then
		outFilePrefix=${outDir}/${readFilesIn[i+2]}.
		runStr=$runStr' --readFilesIn '${pathToFastqFiles}/${readFilesIn[i]}' '${pathToFastqFiles}/${readFilesIn[i+1]}' --outFileNamePrefix '${outFilePrefix}
	else
		outFilePrefix=${outDir}/${readFilesIn[i+1]}.
		runStr=$runStr' --readFilesIn '${pathToFastqFiles}/${readFilesIn[i]}' --outFileNamePrefix '${outFilePrefix}
	fi
	runStr=$runStr' --runThreadN '${starThreads}
	runStr=$runStr' '${optionString}
	runStr=$runStr'\nsamtools index '${outFilePrefix}'Aligned.sortedByCoord.out.bam'
	flName=${tmpFileSt}`cat /dev/urandom | env LC_CTYPE=C tr -dc "a-zA-Z0-9" | head -c10`.sh

	echo -e $runStr > ${flName}
	
	if [[ specifyQ ]]; then
		qsub -q ${qsubQ} ${flName}
	else
		qsub ${flName}
	fi
	rm $flName
	
done
