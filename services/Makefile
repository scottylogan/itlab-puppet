
%:
	@$(MAKE) s_$@

s_%:
	@echo Creating service $@
	@mkdir -p $@/files $@/manifests $@/templates
	@echo '#' `echo $@|sed s/s_//` service              >  $@/manifests/init.pp
	@echo                                  >> $@/manifests/init.pp
	@echo class $@ inherits defaults '{'   >> $@/manifests/init.pp
	@echo ' ' include user::itlab-users    >> $@/manifests/init.pp
	@echo                                  >> $@/manifests/init.pp
	@echo '}'                              >> $@/manifests/init.pp

