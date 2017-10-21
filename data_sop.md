# IAMC Data Depot SOP

## IAMC files and directories
1. `README`: table of contents with project numbers and dataset info. Directories with these project numbers could be made under the archive, data, work, and devel folders. This file could contain further details of the cohorts, WTCGH sequencing run, etc:

 ```
 batch001proj001 - 60 patients from the Birmingham cohort. Sequenced by the WTCHG “rawsequencefilename.” Analyzed by Bahar Sayoldin and Kevin Bonham (Huttenhower Lab).
 pilot001proj002 - 23 patients from the New York cohort. Sequenced by the WTCHG “rawsequencefilename.” Analyzed by Bahar Sayoldin and Kevin Bonham (Huttenhower Lab).
 ```
2. `archive/` - datasets that need to be archived at Oxford. I have now transferred the “birmingham” directory to proj001 and “nygc” to proj002 along with your accompanying README file. I think it could be helpful to include notes on the scripts run (ie fastqc, trimming, phase1 vs phase2 vs phase3?). It also looks like Project_LIT_1xxxx files are in both the ”archive” and “nygc” subfolder— is one version extra and could it be removed?
3. `data/`: active datasets being transferred between sites (but not yet at the archiving stage)
4. `work/`: any further analysis derived from datasets (ie further analyses performed at Oxford on archived datasets from the Huttenhower lab)
5. `devel/`: any codes to be shared

## Procedures

### Downloading raw sequences from WTCHG

1. The WTCHG will provide a download link when sequences are available.
2. Raw sequences will be downloaded (Lillian) to kgen/iamc/archive (see below for specific procedure).
3. Checksums will be validated (Lillian) to insure data integrity (see below for specific procedure).
4. Lilian will also notify Brian/Bahar/Kevin that sequences are ready for analysis, and will forward the WTCHG email with download details.

#### Downloading Initial lane(s) for a given batch

##### Step1: Set up Batch Directory

First, change to the archive directory:

```sh
[harviamc@iamc ~]$ cd archive/
```

Next, make a new folder for for the current batch (eg `$ mkdir batch{NUM}`,
where `{NUM}` is the batch number), then move into that folder (eg `$ cd batch{NUM}`)
and create directories `fastq/`, `bam/`, `bai/` and `qc/`:

```sh
[harviamc@iamc batch{NUM}]$ mkdir fastq/ bam/ bai/ qc/
```

##### Step2: Get Files

Download files from ftp. The WTCHG will provide an ftp link that contains
authentication, so you can simple do `$ wget {link} ./`. This download should
contain compressed fastq files (with extension `.fastq.gz`), BAM and BAM index
files (`.bam` and `.bai` respectively), a QC file (`.zip`) and an MD5 checksum
file (`.txt`). Move each of the first 4 file types into their subfolders:

```sh
[harviamc@iamc batch{NUM}]$ mv *.fastq.gz fastq/
[harviamc@iamc batch{NUM}]$ mv *.bam bam/
[harviamc@iamc batch{NUM}]$ mv *.bai bai/
[harviamc@iamc batch{NUM}]$ mv *.zip qc/
```

At this point, if you use `ls` you should see something like:

```
[harviamc@iamc batch002]$ ls
bam    bai    fastq    P170482-md5sum.txt    qc
```

##### Step 3: Split checksum

The `md5sum` file contains checksums for each file, and will be used to verify
that no file corruption occurred on transfer (see below). First, this file
should be split into each folder. The following commands will take the lines
from this file containing each file type, and write them to new files in the
proper subdirectories:

```sh
[harviamc@iamc batch002]$ cat P170482-md5sum.txt | grep 'fastq\.gz$' > fastq/fastq.md5
[harviamc@iamc batch002]$ cat P170482-md5sum.txt | grep 'bai$' > bai/bai.md5
[harviamc@iamc batch002]$ cat P170482-md5sum.txt | grep 'bam$' > bam/bam.md5
[harviamc@iamc batch002]$ cat P170482-md5sum.txt | grep 'zip$' > qc/qc.md5
```

##### Step 4: Rename repeatable files

Then, because subsequent lanes sent by the WTCHG will use the same file name for
the `md5sum` and `QC` files, rename them. Eg, if the first download contained
the first two lanes:

```
[harviamc@iamc batch002]$ mv P170482-md5sum.txt P170482-md5sum-lane1-2.txt
[harviamc@iamc batch002]$ mv qc/P170482-QC.zip  qc/P170482-QC-lane1-2.zip
```

#### Downloading Subsequent lane(s) for a given batch

##### Step 1: Check current QC and md5sum file to prevent overwriting

As before, navigate to the correct batch folder. Use `ls` to ensure that any
`md5sum.txt` in the root directory and `.zip` files in the `qc/` directory have
lane information in their file names. The WTCHG uses the same name for each set
of files for a given project, so if these files haven't been renamed, they will
be overwritten. If these files do not contain `laneX` in the file name, perform
step 4 above.

##### Step 2: Get New Files

Follow the same procedure as Step 2 above.

##### Step 3: Append checksum info to appropriate files

Again, the checksum file can split into the appropriate folders. However, using
the same command as above would overwrite the previous files. Instead, use the
double greater than `>>` to *append* to the proper file:

```sh
[harviamc@iamc batch002]$ cat P170482-md5sum.txt | grep 'fastq\.gz$' >> fastq/fastq.md5
[harviamc@iamc batch002]$ cat P170482-md5sum.txt | grep 'bai$' >> bai/bai.md5
[harviamc@iamc batch002]$ cat P170482-md5sum.txt | grep 'bam$' >> bam/bam.md5
[harviamc@iamc batch002]$ cat P170482-md5sum.txt | grep 'zip$' >> qc/qc.md5
```

##### Step 4: Rename repeatable files

Same as Step 4 above

### Verifying file transfers with md5sum

Files downloaded from the sequencing core are accompanied by a text file
containing md5 checksum values. One all files have been transferred, the
integrity of the transfer can be verified by moving into the appropriate
directory and running the command:

```sh
$ md5sum -c <md5_file.txt>
```

Where `<md5_file.txt>`  is the checksum file generated by the sequencing core.
This command will print each file name, and at the end will report if any errors
were generated. For example:

```
WTCHG_406782_201191.bam: OK
WTCHG_406782_201191.bam.bai: OK
WTCHG_406782_201191_1.fastq.gz: OK
WTCHG_406782_201191_2.fastq.gz: OK
WTCHG_406782_202179.bam: FAILED
WTCHG_406782_202179.bam.bai: OK
WTCHG_406782_202179_1.fastq.gz: OK
WTCHG_406782_202179_2.fastq.gz: OK
WTCHG_406782_203167.bam: OK
WTCHG_406782_203167.bam.bai: OK
md5sum: WARNING: 1 computed checksum did NOT match
```

Other critical files being transferred to the datastore should have md5 checksum
files generated as well to ensure data integrity. For example, before
transferring a folder containing data tables, navigate the the folder containing
the tables and then use the command:

```sh
$ md5sum * > my_checksum.md5
```

Then transfer this file along with the data tables to the datastore, and then
use `md5sum -c` to check that the files were properly transferred.

Note: the relative file paths are stored in the checksum file. If you generate
the file from outside the folder containing the files, they will need to have
the same folder names when moved to the server for the command to work.
