# Aliases and functions to check job info in Slurm


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
You can also use it on running jobs but the memory usage won't be available yet
```
jobinfo 17222597
```
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
```
          JobID              JobName      State                                                                                                                                                                                                                                                                                                      WorkDir 
       17222597 nf-NFCORE_RNAFUSION+    RUNNING                                                                                                                                                                                                                      /flask/scratch/turajlics/loboni/nfcore_rnafusion/work/f3/bc01a62110c88ac7bdcd5846aa694e
```
You can retrieve easy to read usage percentage for a finished job
```
jobusage 17424192
```
```
Requested 6 GB and used 1.65G GB, a usage of 27.00%
```

### 3. Find info on recently submitted jobs even if they are not in the queue anymore

You can print the info on jobs submitted in the last day
```
ydayinfo
```
```
    JobID     State                        JobName               Start                 End    Elapsed  Timelimit ReqMem MaxRSS ReqCP Alloc 
 17222560   RUNNING              run_rnafusion_HMF 2025-03-03T11:36:02             Unknown 4-06:04:51 8-00:00:00    16G            1     2 
17222560+   RUNNING                          batch 2025-03-03T11:36:02             Unknown 4-06:04:51                              2     2 
 17222596 COMPLETED nf-NFCORE_RNAFUSION_RNAFUSION+ 2025-03-03T11:37:02 2025-03-06T10:15:04 2-22:38:02 6-06:00:00   320G            1    12 
17222596+ COMPLETED                          batch 2025-03-03T11:37:02 2025-03-06T10:15:04 2-22:38:02                    4.72G    12    12 
```
To print the working directory, add wd to the command
```
ydayinfowd
```
```
    JobID     State                      JobName                                                                                              WorkDir 
 17222560   RUNNING            run_rnafusion_HMF                                                     /flask/scratch/turajlics/loboni/nfcore_rnafusion 
 17222596 COMPLETED nf-NFCORE_RNAFUSION_RNAFUSI+              /flask/scratch/turajlics/loboni/nfcore_rnafusion/work/3e/0fdc647afe9f4eddf7eab96ddc758b 
```
If your working directory is longer than 100 characters you can use `ydayinfowdlong` instead, and ideally pipe it into less `| less -S`

To print info on jobs run starting 7 days ago you can run
```
weekinfo
```
```
    JobID     State                        JobName               Start                 End    Elapsed  Timelimit ReqMem MaxRSS ReqCP Alloc 
 16749520    FAILED nf-NFCORE_RNAFUSION_RNAFUSION+ 2025-02-24T11:01:43 2025-03-02T17:00:49 6-05:59:06 6-06:00:00   320G            1    12 
16749520+    FAILED                          batch 2025-02-24T11:01:43 2025-03-02T17:00:49 6-05:59:06                   55.88G    12    12 
 16749524 COMPLETED nf-NFCORE_RNAFUSION_RNAFUSION+ 2025-02-24T11:01:43 2025-02-28T01:19:26 3-14:17:43 6-06:00:00   320G            1    12 
16749524+ COMPLETED                          batch 2025-02-24T11:01:43 2025-02-28T01:19:26 3-14:17:43                   68.93G    12    12 
```
You can also see the working directories using `weekinfowd` and `weekinfowdlong` in the same way as the "yday" commands.

## Set up

All aliases and functions are in `check_job_functions.sh`, you can either:

#### A. Download the file and add a source command in your bash_profile or bash_rc
```
cd
wget https://github.com/ilobon/slurm_jobinfo/blob/main/check_job_functions.sh
```
Then open your bash profile and add a source command
```
vi ~/.bash_profile
# Add:
source ~/check_job_functions.sh
```
Remember to source the bash_profile to make them immediately available
```
source ~/.bash_profile
```
#### B. Clone the whole repo to download the README too

```
git clone https://github.com/ilobon/slurm_jobinfo.git
```
Then open your bash profile and add a source command
```
source /local/path/to/check_job_functions.sh
```
Remember that you can get the full path it you are in the script's folder with:
```
pwd -P
```

#### C. Paste them directly into your bash_profile or bash_rc
Copy the functions on github 
```
vi ~/.bash_profile
```
Press i for insert mode, paste the code, press Esc and write ":wq" to save and quit