
%:
	@echo Creating module $@
	@mkdir -p $@/files $@/manifests $@/templates
	@echo '#' general $@ configuration     >  $@/manifests/init.pp
	@echo                                  >> $@/manifests/init.pp
	@echo class $@ '{'                     >> $@/manifests/init.pp
	@echo                                  >> $@/manifests/init.pp
	@echo ' ' package '{'                  >> $@/manifests/init.pp
	@echo '    ['                          >> $@/manifests/init.pp
	@echo '    ]:'                         >> $@/manifests/init.pp
	@echo '      ensure => present'        >> $@/manifests/init.pp
	@echo '  }'                            >> $@/manifests/init.pp
	@echo                                  >> $@/manifests/init.pp
	@echo '}'                              >> $@/manifests/init.pp

