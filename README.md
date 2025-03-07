# Aliases and functions to check job info in Slurm


## Set up

All functions are in `check_job_functions.sh`, you can either:

#### A. Paste them directly into your bash_profile or bash_rc
```
vi ~/.bash_profile
```
Press i for insert mode, paste the code, press Esc and write ":wq" to save and quit

#### B. Clone the repo and add a source command in your bash_profile or bash_rc
```
git clone https://github.com/ilobon/slurm_jobinfo.git
vi ~/.bash_profile
```
Press i for insert mode, and paste this (susbtituting for your local path):
```
source /local/path/to/repo/check_job_functions.sh
```
Press Esc and write ":wq" to save and quit

The local path is where you were when running `git clone`. You can get the full path with:
```
pwd -P
```
## Usage
Once you set it up, the commands will be ready to use when you start a new session. To make them available without restarting a session, you can run
```
source ~/.bash_profile
```
### View your jobs in the queue 

The standard way to view the jobs in the Slurm queue is
```
squeue -u $USER
```
You can get more information, including the number of requested CPUs and MEM just running one of the aliases:
```
q
```
The ouput will look like this, with one line per job
```
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
          17222597      ncpu nf-NFCOR   loboni  R 4-04:03:06      1 cn028
```
