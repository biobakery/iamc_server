# IAMC Transfer server

## MGX analysis description

### Raw data

Raw sequencing data is on the odyssey cluster at `/n/hutlab12_nobackup/data/iamc/raw_fastq_all/`.

Outputs from biobakery workflows are found at `/n/hutlab12_nobackup/data/iamc/analysis_all/`

After the biobakery workflow is run,
the files from an individual run are transferred to `hutlab12_nobackup`.

```sh
$ rsync -avzP output/ /n/hutlab12_nobackup/data/iamc/analysis_all/
```

(be sure to change the name of the files in the `merged/` subfolders
- see below)

#### Folder Struture of `analysis_all/`

Here's what the structure is supposed to be:

```sh
[harviamc@iamc analysis_all]$ tree -d
.
├── humann2
│   ├── counts
│   ├── logs
│   ├── main
│   ├── merged
│   ├── regrouped
│   └── relab
│       ├── ecs
│       ├── genes
│       └── pathways
├── kneaddata
│   ├── main
│   └── merged
├── metaphlan2
│   ├── main
│   └── merged
├── strainphlan
│   ├── main
│   └── merged
```

NOTE: The files in `merged/` subfolders are produced without batch identifiers.
Prior to moving these files into the main folders,
they are renamed with their batch identifier (see `data.toml` for batch #s).

From the biobakery workflow output folder:

```sh
$ for f in $(find . | grep merged); do mv -vn $f ${f/merged\//merged\/batch###_}; done
```

Replace `batch###` with the correct batch number,
but keep the trailing underscore.



#### The `humann2/` folder
- The `human2/counts/` folder contains count tables of various sorts. These come out of the workflow named:
    - `humann2_ecs_relab_counts.tsv`
    - `humann2_feature_counts.tsv`
    - `humann2_genefamilies_relab_counts.tsv`
    - `humann2_pathabundance_relab_counts.tsv`
    - `humann2_read_and_species_count_table.tsv`
- The `human2/logs/` folder contains logfiles from humann2 runs. These are found inside the `main/` folder when the workflow finished and have the extension `.log`
- The `human2/main/` folder contains gene family abundance as well as pathway abundance and coverage tables for each sample run through the pipeline. Those files are named:
    - `{SAMPLE_NAME}_genefamilies.tsv`
    - `{SAMPLE_NAME}_pathabundance.tsv`
    - `{SAMPLE_NAME}_pathcoverage.tsv`
- The `human2/merged/` folder contains merged tables from `main/`. These come out of the workflow named:
    - `ecs_relab.tsv`
    - `ecs.tsv`
    - `genefamilies_relab.tsv`
    - `genefamilies.tsv`
    - `pathabundance_relab.tsv`
    - `pathabundance.tsv`
- The `humann2/regrouped` folder contains `ecs` files (eg `genefamilies` files regrouped as enzyme classes) for each sample run through the pipeline. Those files are named `{SAMPLE_NAME}_ecs.tsv`
- The subfolders of `humann2/relab` contains the same tables as `main/` and `regrouped/`, but transformed for per-sample relative abundance. Those files are named:
    - `ecs/{SAMPLE_NAME}_ecs_relab.tsv`
    - `genes/{SAMPLE_NAME}_genefamilies_relab.tsv`
    - `pathways/{SAMPLE_NAME}_pathabundance_relab.tsv`

#### The `kneaddata/` folder

- The `kneaddata/main` folder contains several output files for each sample run through the pipline. This will include some subset of (note: these may come out of the pipepline uncompressed):
    - `{SAMPLE_NAME}.fastq.gz`
    - `{SAMPLE_NAME}_Homo_sapiens_bowtie2_paired_contam_1.fastq.gz`
    - `{SAMPLE_NAME}_Homo_sapiens_bowtie2_paired_contam_2.fastq.gz`
    - `{SAMPLE_NAME}_Homo_sapiens_bowtie2_unmatched_1_contam.fastq.gz`
    - `{SAMPLE_NAME}_Homo_sapiens_bowtie2_unmatched_2_contam.fastq.gz`
    - `{SAMPLE_NAME}.log`
    - `{SAMPLE_NAME}_SILVA_128_LSUParc_SSUParc_ribosomal_RNA_bowtie2_paired_contam_1.fastq.gz`
    - `{SAMPLE_NAME}_SILVA_128_LSUParc_SSUParc_ribosomal_RNA_bowtie2_paired_contam_2.fastq.gz`
    - `{SAMPLE_NAME}_SILVA_128_LSUParc_SSUParc_ribosomal_RNA_bowtie2_unmatched_1_contam.fastq.gz`
    - `{SAMPLE_NAME}_SILVA_128_LSUParc_SSUParc_ribosomal_RNA_bowtie2_unmatched_2_contam.fastq.gz`
    - `{SAMPLE_NAME}_unmatched_1.fastq.gz`
    - `{SAMPLE_NAME}_unmatched_2.fastq.gz`
- The `kneaddata/merged` folder contains a table of read counts called `read_count_table.tsv`

#### The `metaphlan2/` folder

- The `metaphlan2/main` folder contains taxonomic profiles and sam alignment files for each sample run through the pipeline. These files are called:
    - `{SAMPLE_NAME}_taxonomic_profile.tsv`
    - `{SAMPLE_NAME}_bowtie2.sam`
- The `metaphlan2/merged` folder contains merged tables from `main/`. These come out of the workflow named:
    - `metaphlan2_taxonomic_profiles.tsv`
    - `metaphlan2_species_counts_table.tsv`


#### The `strainphlan/` folder

- The `strainphlan/markers` folder contains strainphlan `.markers` files for
  each sample run through the pipeline. These files are called:
    - `{SAMPLE_NAME}_metaphlan_bowtie2.markers`
- Files beginning with `SRS` are samples from the extended human microbiome
  project (HMP1-II) - all are healthy controls.
    - The first visit of each subject in HMP1-II are included
