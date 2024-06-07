nextflow.enable.dsl = 2

process mask_layer_stack {
	label 'miniscule_memory'
	container 'floriankaterndahl/geoflow:v0.9.2'

    input:
    tuple val(TID), val(date), val(identifier), val(sensor), val(sensor_abbr), path(reflectance), path(qai)

    output:
    tuple val(TID), val(date), val(identifier), val(sensor), val(sensor_abbr), path(reflectance), path(qai), path("masked_reflectance.vrt"), path("mask_raster.tif")

    script:
    """
    QAI2bit_mask.py -qf ${qai} -of mask_raster.tif -qb ${params.quality_cat}
    vrt_add_mask.py --input-file ${reflectance} --mask mask_raster.tif --output-file masked_reflectance.vrt
    """
}
