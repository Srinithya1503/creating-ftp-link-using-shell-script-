#!/bin/bash

# Input and output files
input_file="ftp_link_creation.tsv"
output_file="ftp_link.ods"

# The constant base URL for FTP links
base_url="ftp://ftp.ncbi.nlm.nih.gov/genomes/all"

# Read the input file line by line
while IFS=$'\t' read -r AA AN Organism_Name ftp_link; do
    # Skip the header if present
    if [[ "$AA" == "AA" ]]; then
        echo -e "${AA}\t${AN}\t${Organism_Name}\tftp_link" >> "$output_file"
        continue
    fi
   
    # Break AA into parts
    prefix=$(echo "$AA" | cut -d'_' -f1)
    numeric=$(echo "$AA" | cut -d'_' -f2 | cut -d'.' -f1)
    part1=$(echo "$numeric" | cut -c1-3)
    part2=$(echo "$numeric" | cut -c4-6)
    part3=$(echo "$numeric" | cut -c7-9)

    # Form the FTP link
    ftp_link="${base_url}/${prefix}/${part1}/${part2}/${part3}/${AA}_${AN}"

    # Append the result to the output file
    echo -e "${AA}\t${AN}\t${Organism_Name}\t${ftp_link}" >> "$output_file"

done < "$input_file"
