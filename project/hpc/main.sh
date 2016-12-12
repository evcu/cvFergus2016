#!/bin/bash
#PBS -l nodes=1:ppn=16,walltime=30:00,mem=8GB
#PBS -N cvTrial1
#PBS -M ue225@nyu.edu
#PBS -m abe
#PBS -e localhost:/scratch/ue225/${PBS_JOBNAME}.e${PBS_JOBID}
#PBS -o localhost:/scratch/ue225/${PBS_JOBNAME}.o${PBS_JOBID}

cd $PBS_JOBTMP 
cp -r $HOME/cv2016/project ./
cd project/
module load torch/gnu/20160623 
time qlua main.lua  -nEpochs 6 -nThr 8 -model cifar -jobID ${PBS_JOBID}
zip -r $PBS_JOBID.zip logs
curl --upload-file $PBS_JOBID.zip https://transfer.sh/$PBS_JOBID.zip > $HOME/output/$PBS_JOBID
cp $PBS_JOBID.zip $HOME/output/
exit 0;