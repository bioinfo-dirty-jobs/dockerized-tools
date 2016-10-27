task variant_effect_predictor {
    File inputFile
    String outputFileName
    File refFasta
    File refFastaFai
    File cacheDir
    File? pluginsDir
    Int? fork

    String species = "homo_sapiens"
    String assembly = "GRCh37"
    String format = "vcf"

    # shortcut for common flags
    Boolean? everything

    # output options
    Boolean? humdiv
    Boolean? gene_phenotype
    Boolean? regulatory
    Boolean? phased
    Boolean? allele_number
    Boolean? total_length
    Boolean? numbers
    Boolean? domains
    Boolean? no_escape
    Boolean? keep_csq
    Boolean? no_consequences
    Boolean? variant_class

    String? cell_type
    String? plugin
    String? pluginFileName
    Array[String]? pluginArgs
    String? individual
    String? sift
    String? polyphen
    String? vcf_info_field
    String? terms

    # identifiers
    Int? shift_hgvs
    Boolean? hgvs
    Boolean? protein
    Boolean? symbol
    Boolean? ccds
    Boolean? uniprot
    Boolean? tsl
    Boolean? appris
    Boolean? canonical
    Boolean? biotype
    Boolean? xref_refseq

    # co-located variants
    Boolean? check_existing
    Boolean? check_alleles
    Boolean? check_svs
    Boolean? gmaf
    Boolean? maf_1kg
    Boolean? maf_esp
    Boolean? maf_exac
    Boolean? old_maf
    Boolean? pubmed
    Int? failed
    
    # output format options
    Boolean? vcf
    Boolean? tab
    Boolean? json
    Boolean? gvcf
    Boolean? minimal
    
    command {
       # plugins
        if [ -n "${sep="," pluginArgs}" ]; then
           PLUGINS="${"--plugin " + plugin + "," + cacheDir + "/" + pluginFileName + ","}${sep="," pluginArgs}"
        else
           PLUGINS="${"--plugin " + plugin + "," + cacheDir + "/" + pluginFileName}"
        fi

        variant_effect_predictor.pl \
        --no_progress \
        --no_stats \
        --offline \
        --input_file ${inputFile} \
        --format ${format} \
        --species ${species} \
        --assembly ${assembly} \
        --fasta ${refFasta} \
        --dir_cache ${cacheDir} \
        ${"--dir_plugins " + pluginsDir} \
        ${"--fork " + fork} \
        ${true="--everything" false="" everything} \
        $PLUGINS \
        ${"--cell_type " + cell_type} \
        ${"--individual " + individual} \
        ${"--sift " + sift} \
        ${"--polyphen " + polyphen} \
        ${"--vcf_info_field " + vcf_info_field} \
        ${"--terms " + terms} \
        ${true="--humdiv" false="" humdiv} \
        ${true="--gene_phenotype" false="" gene_phenotype} \
        ${true="--regulatory" false="" regulatory} \
        ${true="--phased" false="" phased} \
        ${true="--allele_number" false="" allele_number} \
        ${true="--total_length" false="" total_length} \
        ${true="--numbers" false="" numbers} \
        ${true="--domains" false="" domains} \
        ${true="--no_escape" false="" no_escape} \
        ${true="--keep_csq" false="" keep_csq} \
        ${true="--no_consequences" false="" no_consequences} \
        ${true="--variant_class" false="" variant_class} \
        ${"--shift_hgvs " + shift_hgvs} \
        ${true="--hgvs" false="" hgvs} \
        ${true="--protein" false="" protein} \
        ${true="--symbol" false="" symbol} \
        ${true="--ccds" false="" ccds} \
        ${true="--uniprot" false="" uniprot} \
        ${true="--tsl" false="" tsl} \
        ${true="--appris" false="" appris} \
        ${true="--canonical" false="" canonical} \
        ${true="--biotype" false="" biotype} \
        ${true="--xref_refseq" false="" xref_refseq} \
        ${true="--check_existing" false="" check_existing} \
        ${true="--check_alleles" false="" check_alleles} \
        ${true="--check_svs" false="" check_svs} \
        ${true="--gmaf" false="" gmaf} \
        ${true="--maf_1kg" false="" maf_1kg} \
        ${true="--maf_esp" false="" maf_esp} \
        ${true="--maf_exac" false="" maf_exac} \
        ${true="--old_maf" false="" old_maf} \
        ${true="--pubmed" false="" pubmed} \
        ${"--failed " + failed} \
        ${true="--vcf" false="" vcf} \
        ${true="--tab" false="" tab} \
        ${true="--json" false="" json} \
        ${true="--gvcf" false="" gvcf} \
        ${true="--minimal" false="" minimal} \
        --output_file ${outputFileName}
    }

    output {
        File annotatedFile = "${outputFileName}"
    }

    runtime {
        docker: "vep:86"
    }
}

workflow vep {
    call variant_effect_predictor
}
