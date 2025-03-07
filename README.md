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

### View info about your jobs in the queue 

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

### Retrieve info about a specific job
