TEMPLATE_DIR	:= k8-byexamples-
PREFIX			:= k8-byexamples

new-%:

	$(eval NEW_DIR := $(PREFIX)-$*)

	cp -R $(TEMPLATE_DIR) $(NEW_DIR) && cd $(NEW_DIR) && \
										git init && \
										git remote add origin git@github.com:mateothegreat/$(NEW_DIR).git && \
										git add . && \
										git commit -am'initial commit yall' && \
										git push -u origin master
