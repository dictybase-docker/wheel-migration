remove:
	rm -rf data/stockcenter
docker-copy: remove
	docker cp dsc-users:/data/stockcenter $(shell pwd)/data/ 
copy-phenotype-file:
	cp ${HOME}/Projects/migration-data/strain/DSC_phenotypes_import.tsv data/stockcenter/
copy-plasmid-sequence:
	cp -R ${HOME}/Projects/migration-data/plasmid/formatted_sequence data/stockcenter/
create-tarball: docker-copy copy-phenotype-file copy-plasmid-sequence 
	cd data/stockcenter \
		&& tar cvzf stockcenter.tar.gz * \
		&& mv stockcenter.tar.gz ../  
upload-tarball: create-tarball
	gsutil cp ${PWD}/data/stockcenter.tar.gz gs://dictybase/import/
