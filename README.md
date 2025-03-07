# Aliases and functions to check job info in Slurm


## Set up

All aliases and functions are in `check_job_functions.sh`, you can either:

#### A. Paste them directly into your bash_profile or bash_rc
```
vi ~/.bash_profile
```
Press i for insert mode, paste the code, press Esc and write ":wq" to save and quit

#### B. Clone the repo or download the file and add a source command in your bash_profile or bash_rc

Clone the repo
```
git clone https://github.com/ilobon/slurm_jobinfo.git
```
or download the script on its own
```
wget https://github.com/ilobon/slurm_jobinfo/blob/main/check_job_functions.sh
```
Then open your bash profile
```
vi ~/.bash_profile
```
Press i for insert mode, and paste this (susbtituting for your local path to the script):
```
source /local/path/to/check_job_functions.sh
```
Press Esc and write ":wq" to save and quit

You can get the full path it you are in the script's folder with:
```
pwd -P
```

Once you set it up, the commands will be ready to use when you start a new session. To make them available immediately, you can run
```
source ~/.bash_profile
```
## Usage

### 1. View info about your jobs in the queue 

You can view the jobs in the Slurm queue with `q` (for queue)
```
q
```
will print:
```
    JOBID NAME                       USER     STATE      PARTITION NODES  NODELIST(REASON)     CPUS   MIN_MEMORY        TIME     TIME_LEFT
 17222597 nf-NFCORE_RNAFUSION_RNAFUS loboni   RUNNING         ncpu 1      cn028                12     320G        4-05:28:32    3-00:31:28
 17535992 sys/dashboard/sys/bc_deskt loboni   PENDING         ncpu 1      cn085                2      12000M            0:00       4:00:00
```
View only **running** jobs
```
qr
```
```
    JOBID NAME                       USER     STATE      PARTITION NODES  NODELIST(REASON)     CPUS   MIN_MEMORY        TIME     TIME_LEFT
 17222597 nf-NFCORE_RNAFUSION_RNAFUS loboni   RUNNING         ncpu 1      cn028                12     320G        4-05:28:32    3-00:31:28
```
View only **pending** jobs
```
qp
```
```
    JOBID NAME                       USER     STATE      PARTITION NODES  NODELIST(REASON)     CPUS   MIN_MEMORY        TIME     TIME_LEFT
 17535992 sys/dashboard/sys/bc_deskt loboni   PENDING         ncpu 1      cn085                2      12000M            0:00       4:00:00
```
You can print the **working directory** for jobs in the queue, which is particularly useful for jobs submitted by pipelines
```
qwd
```
```
    JOBID NAME                 USER     STATE                                                                                             WORK_DIR
 17222597 nf-NFCORE_RNAFUSION_ loboni   RUNNING            /flask/scratch/turajlics/loboni/nfcore_rnafusion/work/f3/bc01a62110c88ac7bdcd5846aa694e
```

### 2. Retrieve info about a specific job

You can use `jobinfo $JID` with a spefic jobID to see its steps, and if it has finished, the max memory used (MaxRSS)
```
jobinfo 17424192
```
```
          JobID                        JobName      State     ReqMem     MaxRSS  Timelimit    Elapsed  ReqCPUS  AllocCPUS        NodeList 
       17424192 nf-NFCORE_RNAFUSION_RNAFUSION+  COMPLETED         6G              04:00:00   00:01:54        1          2           cn085 
 17424192.batch                          batch  COMPLETED                 1.65G              00:01:54        2          2           cn085 
17424192.extern                         extern  COMPLETED                     0              00:01:54        2          2           cn085 
```
You can also use it on running jobs but the memory usage is still not available
```
jobinfo 17222597
```
          JobID                        JobName      State     ReqMem     MaxRSS  Timelimit    Elapsed  ReqCPUS  AllocCPUS        NodeList 
       17222597 nf-NFCORE_RNAFUSION_RNAFUSION+    RUNNING       320G            7-06:00:00 4-05:43:59        1         12           cn028 
 17222597.batch                          batch    RUNNING                                  4-05:43:59       12         12           cn028 
17222597.extern                         extern    RUNNING                                  4-05:43:59       12         12           cn028 
```
To find the working directory of a jobID, you can use `jobwhere`
```
jobwhere 17222597
```
```
          JobID              JobName      State                                                                                              WorkDir 
       17222597 nf-NFCORE_RNAFUSION+    RUNNING              /flask/scratch/turajlics/loboni/nfcore_rnafusion/work/f3/bc01a62110c88ac7bdcd5846aa694e 
```
For long workdirs you can use `jobwherelong` and it is better to pipe into less `jobwherelong $JID | less -S`
```
jobwherelong 17222597
```
          JobID              JobName      State                                                                                                                                                                                                                                                                                                      WorkDir 
       17222597 nf-NFCORE_RNAFUSION+    RUNNING                                                                                                                                                                                                                      /flask/scratch/turajlics/loboni/nfcore_rnafusion/work/f3/bc01a62110c88ac7bdcd5846aa694e
```
You can retrieve easy to read usage percentage for a finished job
```
jobusage 17424192
```
Requested 6 GB and used 1.65G GB, a usage of 27.00%
```

### 3. Find info on recently submitted jobs even if they are not in the queue anymore

