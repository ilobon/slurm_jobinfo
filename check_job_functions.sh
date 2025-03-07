##########################################################################
#### Aliases and functions to help getting job info in a Slurm system ####
####                       by Irene Lobon                             ####
##########################################################################


#### 1. Check jobs in the queue ####

# Print info on all the user's jobs in the queue
alias q='squeue -u $(id -un) --format="%.9i %26j %8u %10T %.9P %6D %20R %6C %11m %.10M %.13L"'
# Print info on RUNNING jobs
alias qr='squeue -u $(id -un) --format="%.9i %26j %8u %10T %.9P %6D %20R %6C %11m %.10M %.13L" | grep -w -v "PENDING"'
# Print info on PENDING jobs
alias qp='squeue -u $(id -un) --format="%.9i %26j %8u %10T %.9P %6D %20R %6C %11m %.10M %.13L" | grep -w -v "RUNNING"'
# Print job info, focusing on the working directory
alias qwd='squeue -u $(id -un) --format="%.9i %20j %8u %10T %.95Z"'


#### 2. Retrieve info on a specific job ####

# Print information on a specific job, including its steps and max memory used if it has finished (MaxRSS)
jobinfo(){
        sacct -j $1 --format="JobID%15,JobName%30,State,ReqMem,MaxRSS,Timelimit,Elapsed,ReqCPUS,AllocCPUS,NodeList" --units=G
}

# Print working directory a specific job
jobwhere(){
        sacct -j $1 --format="JobID%15,JobName%20,State,WorkDir%100" --units=G
}

# Print working directory a specific job, prints 300 characters of the workdir instead of 100
jobwherelong(){
        sacct -j $1 --format="JobID%15,JobName%20,State,WorkDir%300" --units=G | less -S
}

## Return easy to read usage percentage for a finished job

jobusage(){
        req=$(sacct -j $1 --format="ReqMem" --units=G | sed -n 3p | tr -d 'G' | tr -d ' ')
        used=$(sacct -j $1 --format="MaxRSS" --units=G | sed -n 4p | tr -d 'K' | tr -d ' ')
        usage=$(echo "scale=2; ($used / $req )*100" | bc)
        echo "Requested $req GB and used $used GB, a usage of $usage%"
}

# Print long format information about a job - just runs scontrol show
jobinfodump(){
scontrol show job $1
}


#### 3. Find recently run jobs ####

# Print information on jobs run in the last day - will print the batch step to show max mem used
ydayinfo(){
        sacct --starttime $(date -d "$date -1 days" +"%Y-%m-%d") --endtime $(date -d "$date +1 days" +"%Y-%m-%d") --format="JobID%9,State%9,JobName%30,Start,End,Elapsed,Timelimit,ReqMem%6,MaxRSS%6,ReqCPUS%5,AllocCPUS%5" --units=G | grep -v ".extern"
}

# Print jobID, name and working directory of jobs run in the last day
ydayinfowd(){
        sacct --starttime $(date -d "$date -1 days" +"%Y-%m-%d") --endtime $(date -d "$date +1 days" +"%Y-%m-%d") --format="JobID%9,State%9,JobName%28,WorkDir%100" --units=G | grep -v ".extern" | grep -v ".batch"
}

# Print jobID, name and working directory of jobs run in the last day - for long workdirs
ydayinfowdlong(){
        sacct --starttime $(date -d "$date -1 days" +"%Y-%m-%d") --endtime $(date -d "$date +1 days" +"%Y-%m-%d") --format="JobID%9,State%9,JobName%68,WorkDir%300" --units=G | grep -v ".extern" | grep -v ".batch"
}

# Print information on jobs run in the last week - will print the batch step to show max mem used
weekinfo(){
        sacct --starttime $(date -d "$date -7 days" +"%Y-%m-%d") --endtime $(date -d "$date +1 days" +"%Y-%m-%d") --format="JobID%9,State%9,JobName%30,Start,End,Elapsed,Timelimit,ReqMem%6,MaxRSS%6,ReqCPUS%5,AllocCPUS%5" --units=G | grep -v ".extern"
}

# Print jobID, name and working directory of jobs run in the last week
weekinfowd(){
        sacct --starttime $(date -d "$date -7 days" +"%Y-%m-%d") --endtime $(date -d "$date +1 days" +"%Y-%m-%d") --format="JobID%9,State%9,JobName%28,WorkDir%100" --units=G | grep -v ".extern" | grep -v ".batch"
}

# Print jobID, name and working directory of jobs run in the last weel - for long workdirs
weekinfowdlong(){
        sacct --starttime $(date -d "$date -7 days" +"%Y-%m-%d") --endtime $(date -d "$date +1 days" +"%Y-%m-%d") --format="JobID%9,State%9,JobName%68,WorkDir%300" --units=G | grep -v ".extern" | grep -v ".batch"
}

