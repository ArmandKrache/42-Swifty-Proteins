import os
import requests
import re


def download_sdf(url, filename):
    response = requests.get(url)
    if response.status_code == 200:
        with open(filename, 'wb') as f:
            f.write(response.content)

def count_element_occurrences(file_path):
    element_counts = {}
    with open(file_path, 'r') as f:
        lines = f.readlines()
        maxLines = len(lines)
        nb = int(lines[3].split()[0])
        for i in range (nb):
            if (nb >= maxLines):
                break
            #atomic_symbol = lines[i + 4][31:34].strip()  # Assuming the atomic symbol column is at positions 32-34
            #print(atomic_symbol)
            element = re.split(r'\s+', lines[i + 4])[4]
            print(element)
            element_counts[element] = element_counts.get(element, 0) + 1
    return element_counts

ligands_directory = './files/'

with open('../assets/files/ligands.txt', 'r') as file:
    ligands_list = [line.strip() for line in file.readlines()]

# Initialize dictionary to store element counts
total_element_counts = {}

# Iterate over each ligand
for ligand in ligands_list:
    
    sdf_file = f'{ligand}_ideal.sdf'
    sdf_path = os.path.join(ligands_directory, sdf_file)

    # UnComment to enable the download of all the files
    # sdf_url = f'https://files.rcsb.org/ligands/download/{ligand}_ideal.sdf'
    # download_sdf(sdf_url, sdf_path)

    element_counts = count_element_occurrences(sdf_path)

    # Update total element counts
    for element, count in element_counts.items():
        total_element_counts[element] = total_element_counts.get(element, 0) + count

# Print the total element counts
for element, count in total_element_counts.items():
    print(f"{element}: {count}")

print(total_element_counts)
