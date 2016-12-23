#!/bin/bash
#PBS -l nodes=1:ppn=1:gpus=1,walltime=4:30:00,mem=8GB
#PBS -N cvTrial1
#PBS -M ue225@nyu.edu
#PBS -m abe
#PBS -e localhost:/scratch/ue225/${PBS_JOBNAME}.e${PBS_JOBID}
#PBS -o localhost:/scratch/ue225/${PBS_JOBNAME}.o${PBS_JOBID}

EPOCHS=1
NITER=40

OUT_FOLDER=$HOME/cv2016/out
LOG_FOLDER=$SCRATCH/cvproj/

cd $PBS_JOBTMP 
cp -r $HOME/cv2016/project ./
cd project
module load torch/gnu/20160623 

time qlua main.lua  -reTrain -reLoad -cuda -nEpochs $EPOCHS -iPruning $NITER -jobID ${PBS_JOBID}-$l

zip -r $PBS_JOBID.zip logs
curl --upload-file $PBS_JOBID.zip https://transfer.sh/$PBS_JOBID.zip > $OUT_FOLDER/$PBS_JOBID
cp $PBS_JOBID.zip $OUT_FOLDER/
mv $SCRATCH/${PBS_JOBNAME}.e${PBS_JOBID} $LOG_FOLDER
mv $SCRATCH/${PBS_JOBNAME}.o${PBS_JOBID} $LOG_FOLDER
exit 0;