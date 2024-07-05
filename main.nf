process readSpots {

	container "767397757111.dkr.ecr.us-east-1.amazonaws.com/quay/sra-tools:2.8.2--0"


    output:
    path "dump.version.lower"

    """
    fastq-dump --version > dump.version.lower
    """
}

process convertToUpper {

	container "767397757111.dkr.ecr.us-east-1.amazonaws.com/dockerhub/ubuntu:20.04"

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
