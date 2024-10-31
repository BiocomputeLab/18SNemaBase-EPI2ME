# 18S NemaBase Database for wf-metagenomics in EPI2ME

This repository contains files to enable the use of the [18SNemaBase](https://github.com/WormsEtAl/18SNemaBase) database for the wf-metagenomics workflow in EPI2ME. N.B. we have updated the `18S_NemaBase.fasta` file to use underscores in place of any spaces in the reference names to ensure proper mappings.

The required files are created using the `create_ref2taxid.jl` script. This takes the reference list from 18SNemaBase (`18S_NemaBase.fasta`) and generates the `ref2taxid_18S_NemaBase.txt` file that maps the species of each reference to a valid taxids in NCBI. This is possible by using the `taxid2name.txt` file that was taken from a taxonomy dump from the NCBI. Any references (i.e., species) not present in the NCBI mapping will be given the taxid 28384 ("other sequence").

To use this database in the wf-metagenomics EPI2ME workflow, you need to select the `minimap2` aligner, use the `18S_NemaBase.fasta` file as the reference library and `ref2taxid_18S_NemaBase.txt` for the ref2taxid mapping option.

For further information on how to use a custom database with the wf-metagenomics workflow see the documentation at: https://labs.epi2me.io/metagenomic-databases/
