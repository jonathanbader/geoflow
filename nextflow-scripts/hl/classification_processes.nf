nextflow.enable.dsl = 2

process create_classification_dataset {
	label 'small_memory'
	container 'floriankaterndahl/geoflow:v0.9.2'

    input:
    tuple val(TID), path(bands), path(slVRTs), path(full_stack), path(cat_vec)

    output:
    path("${TID}_training.pkl")

    script:
	// qgis_process moves output to /tmp/processing when given a relative file path or just the file name
    """
    qgis_process run enmapbox:CreateClassificationDatasetFromCategorizedVectorLayerAndFeatureRaster -- \
    categorizedVector=${cat_vec} \
    featureRaster=${full_stack} \
    categoryField='LC3_ID' \
	coverage=0 \
	majorityVoting=0 \
    outputClassificationDataset=\$PWD/${TID}_training.pkl
    """
}

process merge_and_fit {
    label 'small_memory'

    input:
    path(training_datasets)

    output:
    path("estimator.pkl")

    script:
    // qgis_process moves output to /tmp/processing when given a relative file path or just the file name
    String merged_arguments = ""
    training_datasets.each({ val -> merged_arguments += "datasets=$val "})
    """
    # Merging
    qgis_process run enmapbox:MergeClassificationDatasets -- ${merged_arguments} outputClassificationDataset=\$PWD/merged_training_dataset.pkl

    # Fitting
    qgis_process run enmapbox:FitRandomforestclassifier -- \
    classifier='from sklearn.ensemble import RandomForestClassifier;classifier = RandomForestClassifier(n_estimators=100, oob_score=True)' \
    dataset=merged_training_dataset.pkl \
    outputClassifier=\$PWD/estimator.pkl
    """
}

process predict_classifier {
	label 'medium_memory'

	publishDir "${params.final_outDir}", mode: 'copy', pattern: "${TID}_prediction.tif", overwrite: true

	input:
    tuple val(TID), path(bands), path(slVRTs), path(prediction_stack), path(estimator)

    output:
    path("${TID}_prediction.tif")

    script:
    """
    qgis_process run  enmapbox:PredictClassificationLayer -- \
    raster=${prediction_stack} \
    classifier=${estimator} \
    outputClassification=${TID}_prediction.tif

	gdal_edit.py -a_nodata 0 ${TID}_prediction.tif
    """
}

