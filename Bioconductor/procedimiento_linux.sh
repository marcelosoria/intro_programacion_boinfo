# 1. Software necesario (algunos de estos programas pueden a su vez tener 
#
# otros requerimientos
# NCBI SRA tools (https://github.com/ncbi/sra-tools)
# FastQC (https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
# MultiQC (https://multiqc.info/)
# Cutadapt (https://cutadapt.readthedocs.io/en/stable/)
# STAR (https://github.com/alexdobin/STAR)


# 2. Descarga de las archivos fastq
# Ubicar donde está la carpeta "ncbi_downloads" que creó "SRA tools"
# En mi caso esa en ~data/~/data/ncbi_downloads/
# Verificar que la carpeta ~/data/ncbi_downloads/sra está vacía
prefetch --option-file SRR_Acc_List.txt

# En la carpeta de trabajo crear una carpeta fastq y hacerla la carpeta de trabajo
mkdir fastq
cd fastq

# Y desde esa carpeta convertir los archivos sra en fastq 
fasterq-dump --split-files --threads 12 ~/data/ncbi_downloads/sra/*sra

# Si el paso anterior salió bien, borrar los archivos SRR de
# ncbi_downloads/sra

# 3. Control de calidad con con MultiQC
#
# 
mkdir quality_report_1
mkdir quality_report_2

cd fastq
fastqc -f fastq -t 14 -o ../quality_report_1 SRR3396382.sra_1.fastq SRR3396384.sra_1.fastq SRR3396385.sra_1.fastq SRR3396386.sra_1.fastq SRR3396387.sra_1.fastq SRR3396388.sra_1.fastq SRR3396389.sra_1.fastq SRR3396390.sra_1.fastq SRR3396391.sra_1.fastq SRR3396392.sra_1.fastq SRR3396393.sra_1.fastq

fastqc -f fastq -t 14 -o ../quality_report_2 SRR3396382.sra_2.fastq SRR3396384.sra_2.fastq SRR3396385.sra_2.fastq SRR3396386.sra_2.fastq SRR3396387.sra_2.fastq SRR3396388.sra_2.fastq SRR3396389.sra_2.fastq SRR3396390.sra_2.fastq SRR3396391.sra_2.fastq SRR3396392.sra_2.fastq SRR3396393.sra_2.fastq

cd ..

multiqc quality_report_1/ -o quality_report_1/
multiqc quality_report_2/ -o quality_report_2/

# 4. Limpieza de reads con cutadapt
#
# 1. Aunque estan en baja frecuencia, eliminar el "Illumina Universal adapter"
# 2. Eliminar 11 nucleótidos del lado 5'
mkdir trimmed

# copiar lo que sigue a un archivo "cutadapt_trimming.sh"  y establecer los permisos apropiados --------------

cutadapt --minimum-length 1 --cores=12 -u 11 -a AGATCGGAAGAG -A AGATCGGAAGAG -o trimmed/tr_SRR3396381.sra_1.fastq -p trimmed/tr_SRR3396381.sra_2.fastq fastq/SRR3396381.sra_1.fastq fastq/SRR3396381.sra_2.fastq
cutadapt --minimum-length 1 --cores=12 -u 11 -a AGATCGGAAGAG -A AGATCGGAAGAG -o trimmed/tr_SRR3396382.sra_1.fastq -p trimmed/tr_SRR3396382.sra_2.fastq fastq/SRR3396382.sra_1.fastq fastq/SRR3396382.sra_2.fastq
cutadapt --minimum-length 1 --cores=12 -u 11 -a AGATCGGAAGAG -A AGATCGGAAGAG -o trimmed/tr_SRR3396384.sra_1.fastq -p trimmed/tr_SRR3396384.sra_2.fastq fastq/SRR3396384.sra_1.fastq fastq/SRR3396384.sra_2.fastq
cutadapt --minimum-length 1 --cores=12 -u 11 -a AGATCGGAAGAG -A AGATCGGAAGAG -o trimmed/tr_SRR3396385.sra_1.fastq -p trimmed/tr_SRR3396385.sra_2.fastq fastq/SRR3396385.sra_1.fastq fastq/SRR3396385.sra_2.fastq
cutadapt --minimum-length 1 --cores=12 -u 11 -a AGATCGGAAGAG -A AGATCGGAAGAG -o trimmed/tr_SRR3396386.sra_1.fastq -p trimmed/tr_SRR3396386.sra_2.fastq fastq/SRR3396386.sra_1.fastq fastq/SRR3396386.sra_2.fastq
cutadapt --minimum-length 1 --cores=12 -u 11 -a AGATCGGAAGAG -A AGATCGGAAGAG -o trimmed/tr_SRR3396387.sra_1.fastq -p trimmed/tr_SRR3396387.sra_2.fastq fastq/SRR3396387.sra_1.fastq fastq/SRR3396387.sra_2.fastq
cutadapt --minimum-length 1 --cores=12 -u 11 -a AGATCGGAAGAG -A AGATCGGAAGAG -o trimmed/tr_SRR3396388.sra_1.fastq -p trimmed/tr_SRR3396388.sra_2.fastq fastq/SRR3396388.sra_1.fastq fastq/SRR3396388.sra_2.fastq
cutadapt --minimum-length 1 --cores=12 -u 11 -a AGATCGGAAGAG -A AGATCGGAAGAG -o trimmed/tr_SRR3396389.sra_1.fastq -p trimmed/tr_SRR3396389.sra_2.fastq fastq/SRR3396389.sra_1.fastq fastq/SRR3396389.sra_2.fastq
cutadapt --minimum-length 1 --cores=12 -u 11 -a AGATCGGAAGAG -A AGATCGGAAGAG -o trimmed/tr_SRR3396390.sra_1.fastq -p trimmed/tr_SRR3396390.sra_2.fastq fastq/SRR3396390.sra_1.fastq fastq/SRR3396390.sra_2.fastq
cutadapt --minimum-length 1 --cores=12 -u 11 -a AGATCGGAAGAG -A AGATCGGAAGAG -o trimmed/tr_SRR3396391.sra_1.fastq -p trimmed/tr_SRR3396391.sra_2.fastq fastq/SRR3396391.sra_1.fastq fastq/SRR3396391.sra_2.fastq
cutadapt --minimum-length 1 --cores=12 -u 11 -a AGATCGGAAGAG -A AGATCGGAAGAG -o trimmed/tr_SRR3396392.sra_1.fastq -p trimmed/tr_SRR3396392.sra_2.fastq fastq/SRR3396392.sra_1.fastq fastq/SRR3396392.sra_2.fastq
cutadapt --minimum-length 1 --cores=12 -u 11 -a AGATCGGAAGAG -A AGATCGGAAGAG -o trimmed/tr_SRR3396393.sra_1.fastq -p trimmed/tr_SRR3396393.sra_2.fastq fastq/SRR3396393.sra_1.fastq fastq/SRR3396393.sra_2.fastq

# ------------------------------------------------------

# Y ejecutarlo:
chmod u+x cutadapt_trimming.sh
./cutadapt_trimming.sh

# nota: en lugar de crear el archivo script se puede copiar desde este documento
# a la linea de comando y ejecutar directamente.

# 5. Recuperar información del genome de referencia
#
# Crear una carpeta "reference"
mkdir reference
cd reference

# Descargar la secuencia y la anotación genómicas de Saccharomyces cerevisiae desde EnsembleGenomes:

curl ftp://ftp.ensemblgenomes.org/pub/release-51/fungi/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna_sm.toplevel.fa.gz
curl ftp://ftp.ensemblgenomes.org/pub/release-51/fungi/gtf/saccharomyces_cerevisiae/Saccharomyces_cerevisiae.R64-1-1.51.gtf.gz

# Descomprimir estos archivos

gunzip Saccharomyces_cerevisiae.R64-1-1.dna_sm.toplevel.fa.gz
gunzip Saccharomyces_cerevisiae.R64-1-1.51.gtf.gz

cd ..

# 6. Mapeo con STAR
#
# Primero creamos el índice con el genoma de referencia

mkdir star_yeast_index

STAR --runThreadN 14 \
  --runMode  genomeGenerate \
  --genomeDir reference/star_yeast_index \
  --genomeFastaFiles reference/Saccharomyces_cerevisiae.R64-1-1.dna_sm.toplevel.fa \
  --sjdbGTFfile reference/Saccharomyces_cerevisiae.R64-1-1.51.gtf \
  --sjdbOverhang 89
  
# Correr el mapeo y recuento de reads para cada transcripto
#
# Guardar lo que sigue en map_star.sh y establecer los permisos apropiados ----------------

STAR --runThreadN 14 \
  --runMode alignReads \
  --quantMode GeneCounts \
  --genomeDir reference/star_yeast_index \
  --readFilesIn trimmed/tr_SRR3396381.sra_1.fastq trimmed/tr_SRR3396381.sra_2.fastq \
  --outFileNamePrefix star_output/ampho_1_
  
STAR --runThreadN 14 \
  --runMode alignReads \
  --quantMode GeneCounts \
  --genomeDir reference/star_yeast_index \
  --readFilesIn trimmed/tr_SRR3396382.sra_1.fastq trimmed/tr_SRR3396382.sra_2.fastq \
  --outFileNamePrefix star_output/ampho_2_

STAR --runThreadN 14 \
  --runMode alignReads \
  --quantMode GeneCounts \
  --genomeDir reference/star_yeast_index \
  --readFilesIn trimmed/tr_SRR3396384.sra_1.fastq trimmed/tr_SRR3396384.sra_2.fastq \
  --outFileNamePrefix star_output/ampho_3_

STAR --runThreadN 14 \
  --runMode alignReads \
  --quantMode GeneCounts \
  --genomeDir reference/star_yeast_index \
  --readFilesIn trimmed/tr_SRR3396385.sra_1.fastq trimmed/tr_SRR3396385.sra_2.fastq \
  --outFileNamePrefix star_output/control_ampho_1_

STAR --runThreadN 14 \
  --runMode alignReads \
  --quantMode GeneCounts \
  --genomeDir reference/star_yeast_index \
  --readFilesIn trimmed/tr_SRR3396386.sra_1.fastq trimmed/tr_SRR3396386.sra_2.fastq \
  --outFileNamePrefix star_output/control_ampho_2_

STAR --runThreadN 14 \
  --runMode alignReads \
  --quantMode GeneCounts \
  --genomeDir reference/star_yeast_index \
  --readFilesIn trimmed/tr_SRR3396387.sra_1.fastq trimmed/tr_SRR3396387.sra_2.fastq \
  --outFileNamePrefix star_output/control_ampho_3_

STAR --runThreadN 14 \
  --runMode alignReads \
  --quantMode GeneCounts \
  --genomeDir reference/star_yeast_index \
  --readFilesIn trimmed/tr_SRR3396388.sra_1.fastq trimmed/tr_SRR3396388.sra_2.fastq \
  --outFileNamePrefix star_output/ampho_lacto_1_

STAR --runThreadN 14 \
  --runMode alignReads \
  --quantMode GeneCounts \
  --genomeDir reference/star_yeast_index \
  --readFilesIn trimmed/tr_SRR3396389.sra_1.fastq trimmed/tr_SRR3396389.sra_2.fastq \
  --outFileNamePrefix star_output/ampho_lacto_2_

STAR --runThreadN 14 \
  --runMode alignReads \
  --quantMode GeneCounts \
  --genomeDir reference/star_yeast_index \
  --readFilesIn trimmed/tr_SRR3396390.sra_1.fastq trimmed/tr_SRR3396390.sra_2.fastq \
  --outFileNamePrefix star_output/ampho_lacto_3_

STAR --runThreadN 14 \
  --runMode alignReads \
  --quantMode GeneCounts \
  --genomeDir reference/star_yeast_index \
  --readFilesIn trimmed/tr_SRR3396391.sra_1.fastq trimmed/tr_SRR3396391.sra_2.fastq \
  --outFileNamePrefix star_output/control_ampho_lacto_1_

STAR --runThreadN 14 \
  --runMode alignReads \
  --quantMode GeneCounts \
  --genomeDir reference/star_yeast_index \
  --readFilesIn trimmed/tr_SRR3396392.sra_1.fastq trimmed/tr_SRR3396392.sra_2.fastq \
  --outFileNamePrefix star_output/control_ampho_lacto_2_
  
STAR --runThreadN 14 \
  --runMode alignReads \
  --quantMode GeneCounts \
  --genomeDir reference/star_yeast_index \
  --readFilesIn trimmed/tr_SRR3396393.sra_1.fastq trimmed/tr_SRR3396393.sra_2.fastq \
  --outFileNamePrefix star_output/control_ampho_lacto_3_

# -------------------------------------------------------------------------------

# nota: en lugar de crear el archivo script se puede copiar desde este documento
# a la linea de comando y ejecutar directamente.

# Ejecutar el script


./map_star.sh

