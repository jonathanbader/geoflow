nextflow.enable.dsl = 2

process stm_BLUE_pr {
	label 'debug'

	input:
	tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path(base_files)

	output:
	tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path("${TID}_${sensor_abbr}_BLUE_STMS.tif")

	script:
	// last mv call not needed?! -> depends on the output of the process. Not decided yet
	"""
	mkdir vrt
	mv ${base_files} vrt
	ls -1 vrt/* | grep BOA-01 > BLUE_files.txt
	gdalbuildvrt -q -separate -input_file_list BLUE_files.txt BLUE_stack.vrt

	for stm in 0 1 2 3 4 5 6 7 8 9 10 11 12; do
		qgis_process run enmapbox:AggregateRasterBands -- raster=BLUE_stack.vrt function=\$stm outraster=${TID}_${sensor_abbr}_BLUE_STMS-\$stm-temp.tif;
		adjust_indices.py -STM -src ${TID}_${sensor_abbr}_BLUE_STMS-\$stm-temp.tif -of ${TID}_${sensor_abbr}_BLUE_STMS-\$stm.tif;
	done

	gdal_merge.py -separate -o ${TID}_${sensor_abbr}_BLUE_STMS.tif *BLUE_STMS-*.tif

	mv vrt/* .
	"""
}

process stm_GREEN_pr {
        label 'debug'

        input:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path(base_files)

        output:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path("${TID}_${sensor_abbr}_GREEN_STMS.tif")

        script:
        // last mv call not needed?!
        """
        mkdir vrt
        mv ${base_files} vrt
        ls -1 vrt/* | grep BOA-02 > GREEN_files.txt
        gdalbuildvrt -q -separate -input_file_list GREEN_files.txt GREEN_stack.vrt

	for stm in 0 1 2 3 4 5 6 7 8 9 10 11 12; do
	        qgis_process run enmapbox:AggregateRasterBands -- raster=GREEN_stack.vrt function=\$stm outraster=${TID}_${sensor_abbr}_GREEN_STMS-\$stm-temp.tif;
		adjust_indices.py -STM -src ${TID}_${sensor_abbr}_GREEN_STMS-\$stm-temp.tif -of ${TID}_${sensor_abbr}_GREEN_STMS-\$stm.tif;
	done

	gdal_merge.py -separate -o ${TID}_${sensor_abbr}_GREEN_STMS.tif *GREEN_STMS-*.tif

        mv vrt/* .
        """
}

process stm_RED_pr {
	label 'debug'

        input:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path(base_files)

        output:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path("${TID}_${sensor_abbr}_RED_STMS.tif")

        script:
        // last mv call not needed?!
        """
        mkdir vrt
        mv ${base_files} vrt
        ls -1 vrt/* | grep BOA-03 > RED_files.txt
        gdalbuildvrt -q -separate -input_file_list RED_files.txt RED_stack.vrt

	for stm in 0 1 2 3 4 5 6 7 8 9 10 11 12; do
	        qgis_process run enmapbox:AggregateRasterBands -- raster=RED_stack.vrt function=\$stm outraster=${TID}_${sensor_abbr}_RED_STMS-\$stm-temp.tif;
		adjust_indices.py -STM -src ${TID}_${sensor_abbr}_RED_STMS-\$stm-temp.tif -of ${TID}_${sensor_abbr}_RED_STMS-\$stm.tif;
	done;

	gdal_merge.py -separate -o ${TID}_${sensor_abbr}_RED_STMS.tif *RED_STMS-*.tif

        mv vrt/* .
        """
}

process stm_RE1_pr {
	label 'debug'

        input:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path(base_files)

        output:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path("${TID}_${sensor_abbr}_RE1_STMS.tif")

        script:
        // last mv call not needed?!
        """
        mkdir vrt
        mv ${base_files} vrt
        ls -1 vrt/* | grep BOA-04 > RE1_files.txt
        gdalbuildvrt -q -separate -input_file_list RE1_files.txt RE1_stack.vrt

	for stm in 0 1 2 3 4 5 6 7 8 9 10 11 12; do
	        qgis_process run enmapbox:AggregateRasterBands -- raster=RE1_stack.vrt function=\$stm outraster=${TID}_${sensor_abbr}_RE1_STMS-\$stm-temp.tif;
		adjust_indices.py -STM -src ${TID}_${sensor_abbr}_RE1_STMS-\$stm-temp.tif -of ${TID}_${sensor_abbr}_RE1_STMS-\$stm.tif;
	done

	gdal_merge.py -separate -o ${TID}_${sensor_abbr}_RE1_STMS.tif *RE1_STMS-*.tif

        mv vrt/* .
        """
}

process stm_RE2_pr {
	label 'debug'

        input:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path(base_files)

        output:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path("${TID}_${sensor_abbr}_RE2_STMS.tif")

        script:
        // last mv call not needed?!
        """
        mkdir vrt
        mv ${base_files} vrt
        ls -1 vrt/* | grep BOA-05 > RE2_files.txt
        gdalbuildvrt -q -separate -input_file_list RE2_files.txt RE2_stack.vrt

	for stm in 0 1 2 3 4 5 6 7 8 9 10 11 12; do
	        qgis_process run enmapbox:AggregateRasterBands -- raster=RE2_stack.vrt function=\$stm outraster=${TID}_${sensor_abbr}_RE2_STMS-\$stm-temp.tif;
		adjust_indices.py -STM -src ${TID}_${sensor_abbr}_RE2_STMS-\$stm-temp.tif -of ${TID}_${sensor_abbr}_RE2_STMS-\$stm.tif;
	done

	gdal_merge.py -separate -o ${TID}_${sensor_abbr}_RE2_STMS.tif *RE2_STMS-*.tif

        mv vrt/* .
        """
}

process stm_RE3_pr {
	label 'debug'

        input:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path(base_files)

        output:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path("${TID}_${sensor_abbr}_RE3_STMS.tif")

        script:
        // last mv call not needed?!
        """
        mkdir vrt
        mv ${base_files} vrt
        ls -1 vrt/* | grep BOA-06 > RE3_files.txt
        gdalbuildvrt -q -separate -input_file_list RE3_files.txt RE3_stack.vrt

	for stm in 0 1 2 3 4 5 6 7 8 9 10 11 12; do
	        qgis_process run enmapbox:AggregateRasterBands -- raster=RE3_stack.vrt function=\$stm outraster=${TID}_${sensor_abbr}_RE3_STMS-\$stm-temp.tif;
		adjust_indices.py -STM -src ${TID}_${sensor_abbr}_RE3_STMS-\$stm-temp.tif -of ${TID}_${sensor_abbr}_RE3_STMS-\$stm.tif;
	done

	gdal_merge.py -separate -o ${TID}_${sensor_abbr}_RE3_STMS.tif *RE3_STMS-*.tif

        mv vrt/* .
        """
}

process stm_BNIR_pr {
	label 'debug'

        input:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path(base_files)

        output:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path("${TID}_${sensor_abbr}_BNIR_STMS.tif")

        script:
        // last mv call not needed?!
        """
        mkdir vrt
        mv ${base_files} vrt
        ls -1 vrt/* | grep BOA-07 > BNIR_files.txt
        gdalbuildvrt -q -separate -input_file_list BNIR_files.txt BNIR_stack.vrt

	for stm in 0 1 2 3 4 5 6 7 8 9 10 11 12; do
	        qgis_process run enmapbox:AggregateRasterBands -- raster=BNIR_stack.vrt function=\$stm outraster=${TID}_${sensor_abbr}_BNIR_STMS-\$stm-temp.tif;
		adjust_indices.py -STM -src ${TID}_${sensor_abbr}_BNIR_STMS-\$stm-temp.tif -of ${TID}_${sensor_abbr}_BNIR_STMS-\$stm.tif;
	done

	gdal_merge.py -separate -o ${TID}_${sensor_abbr}_BNIR_STMS.tif *BNIR_STMS-*.tif

        mv vrt/* .
        """
}

process stm_NIR_pr {
	label 'debug'

        input:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path(base_files)

        output:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path("${TID}_${sensor_abbr}_NIR_STMS.tif")

        script:
        // last mv call not needed?!
	String band_index = sensor_abbr == 'S' ? 'BOA-08' : 'BOA-04'

        """
        mkdir vrt
        mv ${base_files} vrt
        ls -1 vrt/* | grep ${band_index} > NIR_files.txt
        gdalbuildvrt -q -separate -input_file_list NIR_files.txt NIR_stack.vrt

	for stm in 0 1 2 3 4 5 6 7 8 9 10 11 12; do
	        qgis_process run enmapbox:AggregateRasterBands -- raster=NIR_stack.vrt function=\$stm outraster=${TID}_${sensor_abbr}_NIR_STMS-\$stm-temp.tif;
		adjust_indices.py -STM -src ${TID}_${sensor_abbr}_NIR_STMS-\$stm-temp.tif -of ${TID}_${sensor_abbr}_NIR_STMS-\$stm.tif;
	done

	gdal_merge.py -separate -o ${TID}_${sensor_abbr}_NIR_STMS.tif *NIR_STMS-*.tif

        mv vrt/* .
        """
}

process stm_SWIR1_pr {
	label 'debug'

        input:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path(base_files)

        output:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path("${TID}_${sensor_abbr}_SWIR1_STMS.tif")

        script:
        // last mv call not needed?!
	String band_index = sensor_abbr == 'S' ? 'BOA-09' : 'BOA-05'

        """
        mkdir vrt
        mv ${base_files} vrt
        ls -1 vrt/* | grep ${band_index} > SWIR1_files.txt
        gdalbuildvrt -q -separate -input_file_list SWIR1_files.txt SWIR1_stack.vrt

	for stm in 0 1 2 3 4 5 6 7 8 9 10 11 12; do
	        qgis_process run enmapbox:AggregateRasterBands -- raster=SWIR1_stack.vrt function=\$stm outraster=${TID}_${sensor_abbr}_SWIR1_STMS-\$stm-temp.tif;
		adjust_indices.py -STM -src ${TID}_${sensor_abbr}_SWIR1_STMS-\$stm-temp.tif -of ${TID}_${sensor_abbr}_SWIR1_STMS-\$stm.tif;
	done

	gdal_merge.py -separate -o ${TID}_${sensor_abbr}_SWIR1_STMS.tif *SWIR1_STMS-*.tif

        mv vrt/* .
        """
}

process stm_SWIR2_pr {
	label 'debug'

        input:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path(base_files)

        output:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path("${TID}_${sensor_abbr}_SWIR2_STMS.tif")

        script:
        // last mv call not needed?!
	String band_index = sensor_abbr == 'S' ? 'BOA-10' : 'BOA-06'

        """
        mkdir vrt
        mv ${base_files} vrt
        ls -1 vrt/* | grep ${band_index} > SWIR2_files.txt
        gdalbuildvrt -q -separate -input_file_list SWIR2_files.txt SWIR2_stack.vrt

	for stm in 0 1 2 3 4 5 6 7 8 9 10 11 12; do
	        qgis_process run enmapbox:AggregateRasterBands -- raster=SWIR2_stack.vrt function=\$stm outraster=${TID}_${sensor_abbr}_SWIR2_STMS-\$stm-temp.tif;
		adjust_indices.py -STM -src ${TID}_${sensor_abbr}_SWIR2_STMS-\$stm-temp.tif -of ${TID}_${sensor_abbr}_SWIR2_STMS-\$stm.tif;
	done

	gdal_merge.py -separate -o ${TID}_${sensor_abbr}_SWIR2_STMS.tif *SWIR2_STMS-*.tif

        mv vrt/* .
        """
}

process stm_NDVI_pr {
	label 'debug'

        input:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path(base_files)

        output:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path("${TID}_${sensor_abbr}_NDVI_STMS.tif")

        script:
        // last mv call not needed?!
        """
        mkdir vrt
        mv ${base_files} vrt
        ls -1 vrt/* | grep NDVI > NDVI_files.txt
        gdalbuildvrt -q -separate -input_file_list NDVI_files.txt NDVI_stack.vrt

	for stm in 0 1 2 3 4 5 6 7 8 9 10 11 12; do
	        qgis_process run enmapbox:AggregateRasterBands -- raster=NDVI_stack.vrt function=\$stm outraster=${TID}_${sensor_abbr}_NDVI_STMS-\$stm-temp.tif;
		adjust_indices.py -STM -src ${TID}_${sensor_abbr}_NDVI_STMS-\$stm-temp.tif -of ${TID}_${sensor_abbr}_NDVI_STMS-\$stm.tif;
	done

	gdal_merge.py -separate -o ${TID}_${sensor_abbr}_NDVI_STMS.tif *NDVI_STMS-*.tif

        mv vrt/* .
        """
}

process stm_NBR_pr {
	label 'debug'

        input:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path(base_files)

        output:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path("${TID}_${sensor_abbr}_NBR_STMS.tif")

        script:
        // last mv call not needed?!
        """
        mkdir vrt
        mv ${base_files} vrt
        ls -1 vrt/* | grep NBR > NBR_files.txt
        gdalbuildvrt -q -separate -input_file_list NBR_files.txt NBR_stack.vrt

	for stm in 0 1 2 3 4 5 6 7 8 9 10 11 12; do
	        qgis_process run enmapbox:AggregateRasterBands -- raster=NBR_stack.vrt function=\$stm outraster=${TID}_${sensor_abbr}_NBR_STMS-\$stm-temp.tif;
		adjust_indices.py -STM -src ${TID}_${sensor_abbr}_NBR_STMS-\$stm-temp.tif -of ${TID}_${sensor_abbr}_NBR_STMS-\$stm.tif;
	done

	gdal_merge.py -separate -o ${TID}_${sensor_abbr}_NBR_STMS.tif *NBR_STMS-*.tif

        mv vrt/* .
        """
}

process stm_NDTI_pr {
	label 'debug'

        input:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path(base_files)

        output:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path("${TID}_${sensor_abbr}_NDTI_STMS.tif")

        script:
        // last mv call not needed?!
        """
        mkdir vrt
        mv ${base_files} vrt
        ls -1 vrt/* | grep NDTI > NDTI_files.txt
        gdalbuildvrt -q -separate -input_file_list NDTI_files.txt NDTI_stack.vrt

	for stm in 0 1 2 3 4 5 6 7 8 9 10 11 12; do
	        qgis_process run enmapbox:AggregateRasterBands -- raster=NDTI_stack.vrt function=\$stm outraster=${TID}_${sensor_abbr}_NDTI_STMS-\$stm-temp.tif;
		adjust_indices.py -STM -src ${TID}_${sensor_abbr}_NDTI_STMS-\$stm-temp.tif -of ${TID}_${sensor_abbr}_NDTI_STMS-\$stm.tif;
	done

	gdal_merge.py -separate -o ${TID}_${sensor_abbr}_NDTI_STMS.tif *NDTI_STMS-*.tif

        mv vrt/* .
        """
}

process stm_SAVI_pr {
	label 'debug'

        input:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path(base_files)

        output:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path("${TID}_${sensor_abbr}_SAVI_STMS.tif")

        script:
        // last mv call not needed?!
        """
        mkdir vrt
        mv ${base_files} vrt
        ls -1 vrt/* | grep SAVI > SAVI_files.txt
        gdalbuildvrt -q -separate -input_file_list SAVI_files.txt SAVI_stack.vrt

	for stm in 0 1 2 3 4 5 6 7 8 9 10 11 12; do
	        qgis_process run enmapbox:AggregateRasterBands -- raster=SAVI_stack.vrt function=\$stm outraster=${TID}_${sensor_abbr}_SAVI_STMS-\$stm-temp.tif;
		adjust_indices.py -STM -src ${TID}_${sensor_abbr}_SAVI_STMS-\$stm-temp.tif -of ${TID}_${sensor_abbr}_SAVI_STMS-\$stm.tif;
	done

	gdal_merge.py -separate -o ${TID}_${sensor_abbr}_SAVI_STMS.tif *SAVI_STMS-*.tif

        mv vrt/* .
        """
}

process stm_SARVI_pr {
	label 'debug'

        input:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path(base_files)

        output:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path("${TID}_${sensor_abbr}_SARVI_STMS.tif")

        script:
        // last mv call not needed?!
        """
        mkdir vrt
        mv ${base_files} vrt
        ls -1 vrt/* | grep SARVI > SARVI_files.txt
        gdalbuildvrt -q -separate -input_file_list SARVI_files.txt SARVI_stack.vrt

	for stm in 0 1 2 3 4 5 6 7 8 9 10 11 12; do
	        qgis_process run enmapbox:AggregateRasterBands -- raster=SARVI_stack.vrt function=\$stm outraster=${TID}_${sensor_abbr}_SARVI_STMS-\$stm-temp.tif;
		adjust_indices.py -STM -src ${TID}_${sensor_abbr}_SARVI_STMS-\$stm-temp.tif -of ${TID}_${sensor_abbr}_SARVI_STMS-\$stm.tif;
	done

	gdal_merge.py -separate -o ${TID}_${sensor_abbr}_SARVI_STMS.tif *SARVI_STMS-*.tif

        mv vrt/* .
        """
}

process stm_EVI_pr {
	label 'debug'

        input:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path(base_files)

        output:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path("${TID}_${sensor_abbr}_EVI_STMS.tif")

        script:
        // last mv call not needed?!
        """
        mkdir vrt
        mv ${base_files} vrt
        ls -1 vrt/* | grep EVI > EVI_files.txt
        gdalbuildvrt -q -separate -input_file_list EVI_files.txt EVI_stack.vrt

	for stm in 0 1 2 3 4 5 6 7 8 9 10 11 12; do
	        qgis_process run enmapbox:AggregateRasterBands -- raster=EVI_stack.vrt function=\$stm outraster=${TID}_${sensor_abbr}_EVI_STMS-\$stm-temp.tif;
		adjust_indices.py -STM -src ${TID}_${sensor_abbr}_EVI_STMS-\$stm-temp.tif -of ${TID}_${sensor_abbr}_EVI_STMS-\$stm.tif;
	done

	gdal_merge.py -separate -o ${TID}_${sensor_abbr}_EVI_STMS.tif *EVI_STMS-*.tif

        mv vrt/* .
        """
}

process stm_ARVI_pr {
	label 'debug'

        input:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path(base_files)

        output:
        tuple val(TID), val(identifier), val(sensor_abbr), val(sensor), val(year), val(month), val(quarter), path("${TID}_${sensor_abbr}_ARVI_STMS.tif")

        script:
        // last mv call not needed?!
        """
        mkdir vrt
        mv ${base_files} vrt
        ls -1 vrt/* | grep ARVI > ARVI_files.txt
        gdalbuildvrt -q -separate -input_file_list ARVI_files.txt ARVI_stack.vrt

	for stm in 0 1 2 3 4 5 6 7 8 9 10 11 12; do
	        qgis_process run enmapbox:AggregateRasterBands -- raster=ARVI_stack.vrt function=\$stm outraster=${TID}_${sensor_abbr}_ARVI_STMS-\$stm-temp.tif;
		adjust_indices.py -STM -src ${TID}_${sensor_abbr}_ARVI_STMS-\$stm-temp.tif -of ${TID}_${sensor_abbr}_ARVI_STMS-\$stm.tif;
	done

	gdal_merge.py -separate -o ${TID}_${sensor_abbr}_ARVI_STMS.tif *ARVI_STMS-*.tif

        mv vrt/* .
        """
}


