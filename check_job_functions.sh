##########################################################################
#### Aliases and functions to help getting job info in a Slurm system ####
####                       by Irene Lobon                             ####
##########################################################################


#### 1. Check jobs in the queue ####


alias sq='squeue -u $(id -un) --format="%.9i %22j %8u %8T %.7M %.13l %6D %20R %6C %11m %E"'

function j() {
      squeue --format='%.18i %.9P %.8j %.8u %.2t %.10M %.6D %.5C %.20R %.20L' -u $(id -un)
}

function jr(){
        squeue --format='%.18i %.9P %.8j %.8u %.2t %.10M %.6D %.5C %.20R %.20L' -u $(id -un) | awk '{if($5=="R")print $0}'
} 

function jp(){
        squeue --format='%.18i %.9P %.8j %.8u %.2t %.10M %.6D %.5C %.20R %.20L' -u $(id -un) | awk '{if($5=="PD")print $0}'
}

function q() {
        squeue --format='%10i %.100j %.2t %.10M %.6D %.5C %.20L %.9P %.20R %.150Z' -u $(id -un) | less -S
}


#### 2. Retrieve info on a specific running or pending job ####

runjobinfo(){
scontrol show job $1
}


#### 3. Check info on a specific finished job ####

jobinfo(){
        sacct -j $1 --format="JobID%15,JobName%30,State%25,ReqMem,MaxRSS,Timelimit,Elapsed,ReqCPUS,AllocCPUS,NodeList" --units=G
}

jobwhere(){
        sacct -j $1 --format="JobID%15,JobName%150,State%25,ReqMem,MaxRSS,Timelimit,Elapsed,ReqCPUS,AllocCPUS,ConsumedEnergy,ReqNodes,AllocNodes,SubmitLine%300,WorkDir%250" --units=G
}

## Return easy to read usage for a finished job

jobusage(){
        req=$(sacct -j $1 --format="ReqMem" --units=G | sed -n 3p | tr -d 'G' | tr -d ' ')
        used=$(sacct -j $1 --format="MaxRSS" --units=G | sed -n 4p | tr -d 'K' | tr -d ' ')
        usage=$(echo "scale=2; ($used / $req )*100" | bc)
        echo "Requested $req GB and used $used GB, a usage of $usage%"
}


#### 4. Find recently run jobs ####

weekInfo(){
        sacct --starttime $(date -d "$date -7 days" +"%Y-%m-%d") --endtime $(date -d "$date +1 days" +"%Y-%m-%d") --format="JobID%15,JobName%30,State%25,ReqMem,MaxRSS,Timelimit,Elapsed,ReqCPUS,AllocCPUS,End" --units=G
}

ydayInfo(){
        sacct --starttime $(date -d "$date -7 days" +"%Y-%m-%d") --endtime $(date -d "$date +1 days" +"%Y-%m-%d") --format="JobID%15,JobName%30,State%25,ReqMem,MaxRSS,Timelimit,Elapsed,ReqCPUS,AllocCPUS,End" --units=G
}

ydayWorkdir(){
        sacct --starttime $(date -d "$date -7 days" +"%Y-%m-%d") --endtime $(date -d "$date +1 days" +"%Y-%m-%d") --format="JobID%15,JobName%150,State%25,ReqMem,MaxRSS,Timelimit,Elapsed,ReqCPUS,AllocCPUS,End,SubmitLine%100,WorkDir%250" --units=G
}



