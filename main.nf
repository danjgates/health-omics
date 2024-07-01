process readSpots {

	container "quay.io/biocontainers/sra-tools:2.8.2--0"

	input:
	path x

    output:
    path "${x}.spots.lower"

    """
    fastq-dump --legacy-report ${x} > ${x}.spots.lower
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
    Channel.of(file(params.input)) | readSpots | flatten | convertToUpper 
}
