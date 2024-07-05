process readSpots {

	container "quay.io/biocontainers/sra-tools:2.8.2--0"


    output:
    path "dump.version.lower"

    """
    fastq-dump --version > dump.version.lower
    """
}

process convertToUpper {

	container "ubuntu:22.04"

    input:
    path x

    output:
    file("${x.baseName}.upper")

    """
    cat $x | tr '[a-z]' '[A-Z]' > ${x.baseName}.upper
    """
}

workflow {
    readSpots | convertToUpper 
}
